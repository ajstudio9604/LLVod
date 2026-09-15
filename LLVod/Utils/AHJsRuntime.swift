//
//  AHJsRuntime.swift
//  LLVod
//
//  JS 规则运行时，对应 Flutter JsRuleEngine（parser_utils.dart）+ JsBridge（js_bridge.dart）
//
//  两个关键点：
//  1. 规则函数可能是 async function，返回 Promise。调用时统一包一层序列化 IIFE，
//     Promise 和普通返回值都收敛成一个 JSON 字符串，再交给原生解析。
//  2. 规则里会用 console / EvalHttp / CryptoUtil / Save，这些在裸 JSContext 里不存在，
//     少一个就会抛 ReferenceError 让整条规则失效，所以要全部注入。
//
//  JSValue 不能跨线程用，整个运行时固定在主线程；
//  EvalHttp 的 Promise 也要在主线程 resolve，否则 JS 的微任务队列推不动。
//

import Foundation
import JavaScriptCore

enum AHJsRuntimeError: LocalizedError {
    case contextUnavailable
    case ruleInitFailed(String)
    case evaluateFailed(String, String)
    case promiseRejected(String, String)
    case promiseTimeout(String)
    case invalidResult(String, String)

    var errorDescription: String? {
        switch self {
        case .contextUnavailable:
            return ""
        case .ruleInitFailed(let message):
            return ""
        case .evaluateFailed(let function, let message):
            return ""
        case .promiseRejected(let function, let message):
            return ""
        case .promiseTimeout(let function):
            return ""
        case .invalidResult(let function, let value):
            return ""
        }
    }
}

@MainActor
final class AHJsRuntime {

    private static let callbackTimeout: TimeInterval = 30

    private static let saveKeyPrefix = "ah_js_rule_"

    private let context: JSContext
    private var lastException: String?

    init(rule: String) throws {
        guard let context = JSContext() else {
            throw AHJsRuntimeError.contextUnavailable
        }
        self.context = context

        context.exceptionHandler = { [weak self] _, value in
            let message = value?.toString() ?? "unknown"
            self?.lastException = message
          
        }

        AHJsRuntime.installBridge(in: context)

        lastException = nil
        context.evaluateScript(rule)
        if let exception = lastException {
            throw AHJsRuntimeError.ruleInitFailed(exception)
        }
    }

    // MARK: - 调用

    func callValue(_ function: String, args: [String] = []) async throws -> Any? {
        guard let fn = context.objectForKeyedSubscript(function),
              !fn.isUndefined, !fn.isNull else {
            return nil
        }

        lastException = nil
        let script = AHJsRuntime.serializedCall(function: function, args: args)

        guard let raw = context.evaluateScript(script) else {
            throw AHJsRuntimeError.evaluateFailed(function, lastException ?? "no result")
        }

        if let exception = lastException {
            throw AHJsRuntimeError.evaluateFailed(function, exception)
        }

        let serialized: String
        if isThenable(raw) {
            serialized = try await awaitPromise(raw, function: function)
        } else {
            serialized = raw.toString() ?? "null"
        }

        // 大 JSON 放到后台解码，避免瓜子/详情这类大包卡住主线程（对应 Flutter decodeJsonAsync）
        return try await AHJsRuntime.decodeAsync(serialized, function: function)
    }

    func callList(_ function: String, args: [String] = []) async throws -> [Any] {
        let value = try await callValue(function, args: args)
        guard let value else { return [] }
        guard let list = value as? [Any] else {
            throw AHJsRuntimeError.invalidResult(function, String(describing: value))
        }
        return list
    }

    func callString(_ function: String, args: [String] = []) async throws -> String {
        let value = try await callValue(function, args: args)
        guard let value else { return "" }
        if let text = value as? String { return text }
        return String(describing: value)
    }

    // MARK: - Promise

    private func isThenable(_ value: JSValue) -> Bool {
        guard !value.isUndefined, !value.isNull, value.isObject else { return false }
        guard let then = value.objectForKeyedSubscript("then") else { return false }
        return !then.isUndefined && !then.isNull
    }

    private func awaitPromise(_ promise: JSValue, function: String) async throws -> String {
        let box = AHJsResumeBox()

        return try await withCheckedThrowingContinuation { continuation in
            let finish: (Result<String, Error>) -> Void = { result in
                guard !box.done else { return }
                box.done = true
                box.timeout?.cancel()
                continuation.resume(with: result)
            }

            let onResolve: @convention(block) (JSValue?) -> Void = { value in
                finish(.success(value?.toString() ?? "null"))
            }
            let onReject: @convention(block) (JSValue?) -> Void = { value in
                finish(.failure(
                    AHJsRuntimeError.promiseRejected(function, value?.toString() ?? "unknown")
                ))
            }

            promise.invokeMethod(
                "then",
                withArguments: [
                    JSValue(object: onResolve, in: context) as Any,
                    JSValue(object: onReject, in: context) as Any
                ]
            )

            box.timeout = Task { @MainActor in
                try? await Task.sleep(
                    nanoseconds: UInt64(AHJsRuntime.callbackTimeout * 1_000_000_000)
                )
                guard !Task.isCancelled else { return }
                finish(.failure(AHJsRuntimeError.promiseTimeout(function)))
            }
        }
    }

    // MARK: - 序列化

    private static func serializedCall(function: String, args: [String]) -> String {
        let argList = args.map(jsonQuoted).joined(separator: ", ")
        return """
        (function() {
          var value = \(function)(\(argList));
          var serialize = function(resolved) {
            var json = JSON.stringify(resolved);
            return json === undefined ? "null" : json;
          };
          if (value && typeof value.then === "function") {
            return value.then(serialize);
          }
          return serialize(value);
        })()
        """
    }

    private static func jsonQuoted(_ value: String) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: [value]),
              let text = String(data: data, encoding: .utf8),
              text.count >= 2 else {
            return "\"\""
        }
        // ["..."] 去掉外层数组括号
        return String(text.dropFirst().dropLast())
    }

    private static let largeJSONThreshold = 64 * 1024

    private static func decodeAsync(_ serialized: String, function: String) async throws -> Any? {
        if serialized.utf8.count < largeJSONThreshold {
            return try Self.decodeJSON(serialized, function: function)
        }

        return try await Task.detached(priority: .userInitiated) {
            try Self.decodeJSON(serialized, function: function)
        }.value
    }

    nonisolated private static func decodeJSON(_ serialized: String, function: String) throws -> Any? {
        if serialized.isEmpty || serialized == "null" || serialized == "undefined" {
            return nil
        }

        guard let data = serialized.data(using: .utf8) else {
            throw AHJsRuntimeError.invalidResult(function, serialized)
        }

        guard let json = try? JSONSerialization.jsonObject(
            with: data,
            options: [.fragmentsAllowed]
        ) else {
            throw AHJsRuntimeError.invalidResult(function, serialized)
        }

        return json is NSNull ? nil : json
    }

    // MARK: - Bridge

    private static func installBridge(in context: JSContext) {
        let consoleBlock: @convention(block) (String, String) -> Void = { level, message in  }

        let md5Block: @convention(block) (String, Bool) -> String = { input, is16Bit in
            let full = CryptoUtil.md5Hex(input)
            // 对应 Flutter 的 16 位 MD5：取中间 16 位
            guard is16Bit, full.count == 32 else { return full }
            let start = full.index(full.startIndex, offsetBy: 8)
            let end = full.index(full.startIndex, offsetBy: 24)
            return String(full[start..<end])
        }
        let sha1Block: @convention(block) (String) -> String = { CryptoUtil.sha1Hex($0) }
        let sha256Block: @convention(block) (String) -> String = { CryptoUtil.sha256Hex($0) }
        let base64EncodeBlock: @convention(block) (String) -> String = { CryptoUtil.base64Encode($0) }
        let base64DecodeBlock: @convention(block) (String) -> String = { CryptoUtil.base64Decode($0) }

        let aesEncryptBlock: @convention(block) (String, String, String, String, String) -> String = {
            input, key, iv, mode, padding in
            (try? CryptoUtil.aesEncryptBytes(
                Array(input.utf8),
                key: Array(key.utf8),
                iv: Array(iv.utf8),
                mode: mode.isEmpty ? "ECB" : mode,
                padding: padding.isEmpty ? "PKCS7" : padding
            )) ?? ""
        }

        let aesDecryptBlock: @convention(block) (String, String, String, String, String) -> String = {
            input, key, iv, mode, padding in
            (try? CryptoUtil.aesDecrypt(
                input,
                key: key,
                iv: iv,
                mode: mode.isEmpty ? "ECB" : mode,
                padding: padding.isEmpty ? "PKCS7" : padding
            )) ?? ""
        }

        let rsaEncryptBlock: @convention(block) (String, String, String) -> String = {
            input, publicKeyPem, encoding in
            (try? CryptoUtil.rsaEncrypt(
                input,
                publicKeyPem: publicKeyPem,
                encoding: encoding.isEmpty ? "OAEP" : encoding
            )) ?? ""
        }

        let rsaDecryptBlock: @convention(block) (String, String, String) -> String = {
            input, privateKeyPem, encoding in
            (try? CryptoUtil.rsaDecrypt(
                input,
                privateKeyPem: privateKeyPem,
                encoding: encoding.isEmpty ? "OAEP" : encoding
            )) ?? ""
        }

        let rsaDecryptChunkedBlock: @convention(block) (String, String, String) -> String = {
            input, privateKeyPem, encoding in
            (try? CryptoUtil.rsaDecryptChunked(
                input,
                privateKeyPem: privateKeyPem,
                encoding: encoding.isEmpty ? "PKCS1" : encoding
            )) ?? ""
        }

        // 原生毫秒时间戳 + HTTP Date 校准偏移，避免 JSC/设备时钟偏差触发「时钟慢了」
        // 必须返回整数毫秒：桔子 v5 会 juString(Date.now()) 做 AES/RSA 签名，
        // 小数会变成 "….123"，zone/getDetail 校验失败后回退旧接口（连续剧只给第 1 集）
        let dateNowBlock: @convention(block) () -> Double = {
            AHJsTimeSync.currentEpochMilliseconds()
        }

        let storeStringBlock: @convention(block) (String, String) -> Void = { key, value in
            UserDefaults.standard.set(value, forKey: saveKeyPrefix + key)
        }
        let takeStringBlock: @convention(block) (String) -> String = { key in
            UserDefaults.standard.string(forKey: saveKeyPrefix + key) ?? ""
        }
        let storeIntBlock: @convention(block) (String, Int) -> Void = { key, value in
            UserDefaults.standard.set(value, forKey: saveKeyPrefix + key)
        }
        let takeIntBlock: @convention(block) (String) -> Int = { key in
            UserDefaults.standard.integer(forKey: saveKeyPrefix + key)
        }
        let storeBoolBlock: @convention(block) (String, Bool) -> Void = { key, value in
            UserDefaults.standard.set(value, forKey: saveKeyPrefix + key)
        }
        let takeBoolBlock: @convention(block) (String) -> Bool = { key in
            UserDefaults.standard.bool(forKey: saveKeyPrefix + key)
        }
        let deleteBlock: @convention(block) (String) -> Void = { key in
            UserDefaults.standard.removeObject(forKey: saveKeyPrefix + key)
        }

        // EvalHttp 返回 Promise，JS 侧可以直接 await
        let httpGetBlock: @convention(block) (String, JSValue?, JSValue?) -> JSValue? = { url, query, headers in
            AHJsRuntime.httpPromise(method: "GET", url: url, query: query, body: nil, headers: headers)
        }
        // data 可能是对象（Dio Map）或已编码字符串；按 Content-Type 决定 JSON / form
        let httpPostBlock: @convention(block) (String, JSValue?, JSValue?) -> JSValue? = { url, data, headers in
            let headerMap = AHJsRuntime.dictionary(from: headers)
            let encoded = AHJsRuntime.encodePostBody(data, headers: headerMap)
            return AHJsRuntime.httpPromise(
                method: "POST",
                url: url,
                query: nil,
                body: encoded.body,
                headers: headers,
                ensureContentType: encoded.ensureContentType
            )
        }
        let httpPostRawBlock: @convention(block) (String, JSValue?, JSValue?) -> JSValue? = { url, base64Body, headers in
            AHJsRuntime.httpPromise(
                method: "POST",
                url: url,
                query: nil,
                body: base64Body.flatMap { $0.isUndefined || $0.isNull ? nil : $0.toString() },
                headers: headers,
                bodyIsBase64: true,
                responseAsBase64: true
            )
        }

        let natives: [String: Any] = [
            "nativeConsoleLog": consoleBlock,
            "nativeMd5": md5Block,
            "nativeSha1": sha1Block,
            "nativeSha256": sha256Block,
            "nativeBase64Encode": base64EncodeBlock,
            "nativeBase64Decode": base64DecodeBlock,
            "nativeAesEncrypt": aesEncryptBlock,
            "nativeAesDecrypt": aesDecryptBlock,
            "nativeRsaEncrypt": rsaEncryptBlock,
            "nativeRsaDecrypt": rsaDecryptBlock,
            "nativeRsaDecryptChunked": rsaDecryptChunkedBlock,
            "nativeDateNow": dateNowBlock,
            "nativeSaveStoreString": storeStringBlock,
            "nativeSaveTakeString": takeStringBlock,
            "nativeSaveStoreInt": storeIntBlock,
            "nativeSaveTakeInt": takeIntBlock,
            "nativeSaveStoreBool": storeBoolBlock,
            "nativeSaveTakeBool": takeBoolBlock,
            "nativeSaveDelete": deleteBlock,
            "nativeHttpGet": httpGetBlock,
            "nativeHttpPost": httpPostBlock,
            "nativeHttpPostRaw": httpPostRawBlock
        ]

        for (name, block) in natives {
            context.setObject(block, forKeyedSubscript: name as NSString)
        }

        context.evaluateScript(bridgeGlue)
    }

    private static func httpPromise(
        method: String,
        url: String,
        query: JSValue?,
        body: String?,
        headers: JSValue?,
        bodyIsBase64: Bool = false,
        responseAsBase64: Bool = false,
        ensureContentType: String? = nil
    ) -> JSValue? {
        guard let context = JSContext.current() else { return nil }

        var headerMap = dictionary(from: headers)
        if let ensureContentType,
           headerMap.keys.contains(where: { $0.lowercased() == "content-type" }) == false {
            headerMap["Content-Type"] = ensureContentType
        }
        let queryMap = dictionary(from: query)
        let finalURL = appendQuery(url, query: queryMap)

        return JSValue(newPromiseIn: context) { resolve, reject in
            Task.detached(priority: .userInitiated) {
                do {
                    let text = try await AHJsRuntime.request(
                        method: method,
                        url: finalURL,
                        body: body,
                        headers: headerMap,
                        bodyIsBase64: bodyIsBase64,
                        responseAsBase64: responseAsBase64
                    )
                    await MainActor.run {
                        resolve?.call(withArguments: [text])
                    }
                } catch {
                    let message = error.localizedDescription
                    await MainActor.run {
                        reject?.call(withArguments: [message])
                    }
                }
            }
        }
    }

    private static func encodePostBody(
        _ data: JSValue?,
        headers: [String: String]
    ) -> (body: String?, ensureContentType: String?) {
        guard let data, !data.isUndefined, !data.isNull else {
            return (nil, nil)
        }

        if data.isString {
            return (data.toString(), nil)
        }

        let contentType = headers.first(where: { $0.key.lowercased() == "content-type" })?.value
            .lowercased() ?? ""
        let preferForm = contentType.contains("application/x-www-form-urlencoded")

        if data.isObject, let map = data.toDictionary(), !map.isEmpty {
            if preferForm {
                let pairs: [String] = map.compactMap { key, value in
                    guard let key = key as? String else { return nil }
                    return "\(formEncode(key))=\(formEncode(jsFormValue(value)))"
                }
                return (
                    pairs.joined(separator: "&"),
                    "application/x-www-form-urlencoded;charset=utf-8"
                )
            }

            // Dio 默认把 Map 当 JSON
            if JSONSerialization.isValidJSONObject(map),
               let jsonData = try? JSONSerialization.data(withJSONObject: map),
               let json = String(data: jsonData, encoding: .utf8) {
                return (json, "application/json; charset=utf-8")
            }
        }

        return (data.toString(), nil)
    }

    private static func jsFormValue(_ value: Any) -> String {
        if value is NSNull { return "" }
        if let number = value as? NSNumber {
            // JS boolean 在桥里常是 NSNumber
            if CFGetTypeID(number) == CFBooleanGetTypeID() {
                return number.boolValue ? "true" : "false"
            }
            return number.stringValue
        }
        if let text = value as? String { return text }
        return String(describing: value)
    }

    private static func formEncode(_ value: String) -> String {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "-_.!~*'()")
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    private static func request(
        method: String,
        url: String,
        body: String?,
        headers: [String: String],
        bodyIsBase64: Bool,
        responseAsBase64: Bool
    ) async throws -> String {
        guard let target = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: target)
        request.httpMethod = method
        // 对齐 Flutter EvalHttp：connect/receive/send = 10s
        request.timeoutInterval = 10

        var finalHeaders = headers
        if finalHeaders["User-Agent"] == nil {
            finalHeaders["User-Agent"] = SearchUserAgent.generate()
        }
        for (key, value) in finalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body, !body.isEmpty {
            if bodyIsBase64 {
                request.httpBody = Data(
                    base64Encoded: body,
                    options: [.ignoreUnknownCharacters]
                ) ?? Data(body.utf8)
            } else {
                request.httpBody = Data(body.utf8)
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse {
            AHJsTimeSync.ingest(httpResponse: http)
        }

        if responseAsBase64 {
            return data.base64EncodedString()
        }
        return String(data: data, encoding: .utf8)
            ?? String(data: data, encoding: .ascii)
            ?? ""
    }

    private static func appendQuery(_ url: String, query: [String: String]) -> String {
        guard !query.isEmpty, var components = URLComponents(string: url) else { return url }
        var items = components.queryItems ?? []
        items.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
        components.queryItems = items
        return components.url?.absoluteString ?? url
    }

    private static func dictionary(from value: JSValue?) -> [String: String] {
        guard let value, !value.isUndefined, !value.isNull,
              let raw = value.toDictionary() else {
            return [:]
        }

        var result: [String: String] = [:]
        for (key, item) in raw {
            guard let key = key as? String else { continue }
            result[key] = String(describing: item)
        }
        return result
    }

    private static let bridgeGlue = """
    var console = {
      log: function() { nativeConsoleLog('log', Array.prototype.slice.call(arguments).join(' ')); },
      error: function() { nativeConsoleLog('error', Array.prototype.slice.call(arguments).join(' ')); },
      warn: function() { nativeConsoleLog('warn', Array.prototype.slice.call(arguments).join(' ')); },
      info: function() { nativeConsoleLog('info', Array.prototype.slice.call(arguments).join(' ')); }
    };

    // 用原生时钟 + HTTP Date 偏移覆盖 Date.now，供瓜子/桔子等按秒签名的源使用。
    // 浏览器/Android 的 Date.now() 是整数毫秒；原生桥若返回 Double 小数，
    // 桔子 juString(timestamp) 会带小数点，导致 v5 protobuf 鉴权失败。
    (function() {
      var _originalDateNow = Date.now.bind(Date);
      Date.now = function() {
        try {
          if (typeof nativeDateNow === 'function') {
            return Math.floor(Number(nativeDateNow()) || 0);
          }
        } catch (_) {}
        return Math.floor(_originalDateNow());
      };
    })();

    var EvalHttp = {
      get: function(url, query, headers) { return nativeHttpGet(url, query || null, headers || null); },
      post: function(url, data, headers) { return nativeHttpPost(url, data || null, headers || null); },
      postRaw: function(url, base64Body, headers) { return nativeHttpPostRaw(url, base64Body || null, headers || null); }
    };

    var CryptoUtil = {
      Md5: function(input, is16Bit) { return nativeMd5(input, is16Bit === true); },
      Sha1: function(input) { return nativeSha1(input); },
      Sha256: function(input) { return nativeSha256(input); },
      Base64Encode: function(input) { return nativeBase64Encode(input); },
      Base64Decode: function(input) { return nativeBase64Decode(input); },
      AesEncrypt: function(input, key, iv, modes, padding) {
        return nativeAesEncrypt(input, key, iv || '', modes || 'ECB', padding || 'PKCS7');
      },
      AesDecrypt: function(input, key, iv, modes, padding) {
        return nativeAesDecrypt(input, key, iv || '', modes || 'ECB', padding || 'PKCS7');
      },
      RsaEncrypt: function(input, publicKeyPem, encoding) {
        return nativeRsaEncrypt(input, publicKeyPem, encoding || 'OAEP');
      },
      RsaDecrypt: function(input, privateKeyPem, encoding) {
        return nativeRsaDecrypt(input, privateKeyPem, encoding || 'OAEP');
      },
      RsaDecryptChunked: function(input, privateKeyPem, encoding) {
        return nativeRsaDecryptChunked(input, privateKeyPem, encoding || 'PKCS1');
      }
    };

    var Save = {
      StoreString: function(key, value) { nativeSaveStoreString(key, value); },
      TakeString: function(key) { return nativeSaveTakeString(key); },
      StoreInt: function(key, value) { nativeSaveStoreInt(key, value); },
      TakeInt: function(key) { return nativeSaveTakeInt(key); },
      StoreBool: function(key, value) { nativeSaveStoreBool(key, value); },
      TakeBool: function(key) { return nativeSaveTakeBool(key); },
      Delete: function(key) { nativeSaveDelete(key); }
    };
    """
}

enum AHJsTimeSync {
    private static let lock = NSLock()
    private static var _offsetMilliseconds: Double = 0

    static var offsetMilliseconds: Double {
        lock.lock()
        defer { lock.unlock() }
        return _offsetMilliseconds
    }

    static func currentEpochMilliseconds() -> Double {
        floor(Date().timeIntervalSince1970 * 1000 + offsetMilliseconds)
    }

    static func ingest(httpResponse: HTTPURLResponse) {
        guard let raw = httpResponse.value(forHTTPHeaderField: "Date"),
              let server = AHJsTimeSync.parseHTTPDate(raw) else {
            return
        }

        let serverMs = server.timeIntervalSince1970 * 1000
        let localMs = Date().timeIntervalSince1970 * 1000
        let next = serverMs - localMs

        lock.lock()
        // 小于 0.5s 的偏差忽略，避免抖动；否则写入供后续签名使用
        if abs(next) >= 500 {
            _offsetMilliseconds = next
        }
        lock.unlock()
    }

    private static func parseHTTPDate(_ raw: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        if let date = formatter.date(from: raw) {
            return date
        }
        formatter.dateFormat = "EEEE, dd-MMM-yy HH:mm:ss zzz"
        return formatter.date(from: raw)
    }
}

@MainActor
private final class AHJsResumeBox {
    var done = false
    var timeout: Task<Void, Never>?
}

@MainActor
enum AHJsRuntimeCache {

    private static var runtimes: [String: AHJsRuntime] = [:]
    private static var order: [String] = []
    private static let limit = 6

    static func runtime(for rule: String) -> AHJsRuntime? {
        // v6：Date.now 强制整数毫秒（桔子 v5 protobuf 签名）
        let key = CryptoUtil.md5Hex("bridge-v6:" + rule)

        if let cached = runtimes[key] {
            return cached
        }

        guard let runtime = try? AHJsRuntime(rule: rule) else {
            return nil
        }

        runtimes[key] = runtime
        order.append(key)

        if order.count > limit, let oldest = order.first {
            order.removeFirst()
            runtimes.removeValue(forKey: oldest)
        }

        return runtime
    }
}
