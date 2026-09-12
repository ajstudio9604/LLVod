















import Foundation
import JavaScriptCore

enum NaDqiJWAABPJi: LocalizedError {
    case contextUnavailable
    case ruleInitFailed(String)
    case evaluateFailed(String, String)
    case promiseRejected(String, String)
    case promiseTimeout(String)
    case invalidResult(String, String)

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.fEZgsKlmqZETe()

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

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fEZgsKlmqZETe() -> String {
        let base = (89 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 89) * 5
        let token = "\u{37}\u{37}\u{38}\u{32}\u{64}\u{66}\u{36}\u{64}\u{31}\u{34}\u{35}\u{30}\u{38}\u{34}\u{62}\u{31}\u{32}\u{37}\u{38}\u{30}\u{38}\u{30}\u{30}\u{34}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

@MainActor
final class DsUfbDxzJNTEGoDtXLj {

    private static let callbackTimeout: TimeInterval = 30

    private static let saveKeyPrefix = "\u{61}\u{68}\u{5f}\u{6a}\u{73}\u{5f}\u{72}\u{75}\u{6c}\u{65}\u{5f}"

    private let context: JSContext
    private var lastException: String?

    init(rule: String) throws {
        // source-obfuscator:padding:v1
        _ = Self.lUZfbdzNKlamGsVVDsG()

        guard let context = JSContext() else {
            throw NaDqiJWAABPJi.contextUnavailable
        }
        self.context = context

        context.exceptionHandler = { [weak self] _, value in
            let message = value?.toString() ?? "\u{75}\u{6e}\u{6b}\u{6e}\u{6f}\u{77}\u{6e}"
            self?.lastException = message
          
        }

        DsUfbDxzJNTEGoDtXLj.mAJaDRwtrUrmGScHQ(in: context)

        lastException = nil
        context.evaluateScript(rule)
        if let exception = lastException {
            throw NaDqiJWAABPJi.ruleInitFailed(exception)
        }
    }

    

    func gUgCVVATuARdK(_ function: String, args: [String] = []) async throws -> Any? {
        guard let fn = context.objectForKeyedSubscript(function),
              !fn.isUndefined, !fn.isNull else {
            return nil
        }

        lastException = nil
        let script = DsUfbDxzJNTEGoDtXLj.hZkoZIZLyBOVdCFV(function: function, args: args)

        guard let raw = context.evaluateScript(script) else {
            throw NaDqiJWAABPJi.evaluateFailed(function, lastException ?? "\u{6e}\u{6f} \u{72}\u{65}\u{73}\u{75}\u{6c}\u{74}")
        }

        if let exception = lastException {
            throw NaDqiJWAABPJi.evaluateFailed(function, exception)
        }

        let serialized: String
        if zEetAACWdmTzpHU(raw) {
            serialized = try await uCPeMSBuPHeRkrb(raw, function: function)
        } else {
            serialized = raw.toString() ?? "\u{6e}\u{75}\u{6c}\u{6c}"
        }

        
        return try await DsUfbDxzJNTEGoDtXLj.tOCEMEuKtUvh(serialized, function: function)
    }

    func aXvFZHktziGrSToOxB(_ function: String, args: [String] = []) async throws -> [Any] {
        let value = try await gUgCVVATuARdK(function, args: args)
        guard let value else { return [] }
        guard let list = value as? [Any] else {
            throw NaDqiJWAABPJi.invalidResult(function, String(describing: value))
        }
        return list
    }

    func nUSHBdBnpFzLwOwdcv(_ function: String, args: [String] = []) async throws -> String {
        let value = try await gUgCVVATuARdK(function, args: args)
        guard let value else { return "" }
        if let text = value as? String { return text }
        return String(describing: value)
    }

    

    private func zEetAACWdmTzpHU(_ value: JSValue) -> Bool {
        
        do {
            let bUzJIGQfRKnIZARjJ = [8, 54, 42]
            var wZmbDICylMiy = 0
            for lPVFlzhaswlTnpJ in bUzJIGQfRKnIZARjJ {
                switch (wZmbDICylMiy + lPVFlzhaswlTnpJ) % 3 {
                case 0:
                    wZmbDICylMiy = (wZmbDICylMiy * 7 + lPVFlzhaswlTnpJ) % 101
                case 1:
                    wZmbDICylMiy ^= lPVFlzhaswlTnpJ + 3
                default:
                    wZmbDICylMiy = (wZmbDICylMiy + lPVFlzhaswlTnpJ * 5) % 97
                }
            }
            let nRKoYhPVuxiwAikMk = bUzJIGQfRKnIZARjJ.map { (($0 * 11) + wZmbDICylMiy) % 127 }
            let rPkrFJFumtAtmjSLgwFs = nRKoYhPVuxiwAikMk.filter { ($0 + wZmbDICylMiy) % 2 == 0 }
            let vTKlfcpqnAar = Dictionary(uniqueKeysWithValues: rPkrFJFumtAtmjSLgwFs.enumerated().map { ($0.offset, $0.element) })
            for cGgzaQgREBxPdMvAATb in vTKlfcpqnAar.keys.sorted() {
                wZmbDICylMiy = (wZmbDICylMiy + cGgzaQgREBxPdMvAATb + (vTKlfcpqnAar[cGgzaQgREBxPdMvAATb] ?? 0)) % 131
            }
            let bQlBjFcxAhrgA = nRKoYhPVuxiwAikMk.map { String($0) }.joined(separator: "\u{2d}")
            wZmbDICylMiy = (wZmbDICylMiy + bQlBjFcxAhrgA.utf8.count) % 137
            _ = wZmbDICylMiy
        }

        guard !value.isUndefined, !value.isNull, value.isObject else { return false }
        guard let then = value.objectForKeyedSubscript("\u{74}\u{68}\u{65}\u{6e}") else { return false }
        return !then.isUndefined && !then.isNull
    }

    

    

    private static func hZkoZIZLyBOVdCFV(function: String, args: [String]) -> String {
        
        do {
            let iGJGHowuOLIQyg = [15, 44, 37]
            var dZkCUiIBCVuppSd = 0
            for tCfIjlkrpeAvAIGgL in iGJGHowuOLIQyg {
                switch (dZkCUiIBCVuppSd + tCfIjlkrpeAvAIGgL) % 3 {
                case 0:
                    dZkCUiIBCVuppSd = (dZkCUiIBCVuppSd * 7 + tCfIjlkrpeAvAIGgL) % 101
                case 1:
                    dZkCUiIBCVuppSd ^= tCfIjlkrpeAvAIGgL + 3
                default:
                    dZkCUiIBCVuppSd = (dZkCUiIBCVuppSd + tCfIjlkrpeAvAIGgL * 5) % 97
                }
            }
            let sSricNoBdHCyrLV = iGJGHowuOLIQyg.map { (($0 * 11) + dZkCUiIBCVuppSd) % 127 }
            let wJEnuDGFFeKMAGnpTU = sSricNoBdHCyrLV.filter { ($0 + dZkCUiIBCVuppSd) % 2 == 0 }
            let jSnnFnSCnOUSZpEIIgHL = Dictionary(uniqueKeysWithValues: wJEnuDGFFeKMAGnpTU.enumerated().map { ($0.offset, $0.element) })
            for tOVZfXZWVqxaCqMwnoyz in jSnnFnSCnOUSZpEIIgHL.keys.sorted() {
                dZkCUiIBCVuppSd = (dZkCUiIBCVuppSd + tOVZfXZWVqxaCqMwnoyz + (jSnnFnSCnOUSZpEIIgHL[tOVZfXZWVqxaCqMwnoyz] ?? 0)) % 131
            }
            let pZEqIhqOBaTHPXsD = sSricNoBdHCyrLV.map { String($0) }.joined(separator: "\u{2d}")
            dZkCUiIBCVuppSd = (dZkCUiIBCVuppSd + pZEqIhqOBaTHPXsD.utf8.count) % 137
            _ = dZkCUiIBCVuppSd
        }

        let argList = args.map(bNTVqhHeWeTSGgAIoX).joined(separator: "\u{2c} ")
        return """
        \u{28}\u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b}
          \u{76}\u{61}\u{72} \u{76}\u{61}\u{6c}\u{75}\u{65} \u{3d} \(function)\u{28}\(argList)\u{29}\u{3b}
          \u{76}\u{61}\u{72} \u{73}\u{65}\u{72}\u{69}\u{61}\u{6c}\u{69}\u{7a}\u{65} \u{3d} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{72}\u{65}\u{73}\u{6f}\u{6c}\u{76}\u{65}\u{64}\u{29} \u{7b}
            \u{76}\u{61}\u{72} \u{6a}\u{73}\u{6f}\u{6e} \u{3d} \u{4a}\u{53}\u{4f}\u{4e}\u{2e}\u{73}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{69}\u{66}\u{79}\u{28}\u{72}\u{65}\u{73}\u{6f}\u{6c}\u{76}\u{65}\u{64}\u{29}\u{3b}
            \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6a}\u{73}\u{6f}\u{6e} \u{3d}\u{3d}\u{3d} \u{75}\u{6e}\u{64}\u{65}\u{66}\u{69}\u{6e}\u{65}\u{64} \u{3f} \u{22}\u{6e}\u{75}\u{6c}\u{6c}\u{22} \u{3a} \u{6a}\u{73}\u{6f}\u{6e}\u{3b}
          \u{7d}\u{3b}
          \u{69}\u{66} \u{28}\u{76}\u{61}\u{6c}\u{75}\u{65} \u{26}\u{26} \u{74}\u{79}\u{70}\u{65}\u{6f}\u{66} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{2e}\u{74}\u{68}\u{65}\u{6e} \u{3d}\u{3d}\u{3d} \u{22}\u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{22}\u{29} \u{7b}
            \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{2e}\u{74}\u{68}\u{65}\u{6e}\u{28}\u{73}\u{65}\u{72}\u{69}\u{61}\u{6c}\u{69}\u{7a}\u{65}\u{29}\u{3b}
          \u{7d}
          \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{73}\u{65}\u{72}\u{69}\u{61}\u{6c}\u{69}\u{7a}\u{65}\u{28}\u{76}\u{61}\u{6c}\u{75}\u{65}\u{29}\u{3b}
        \u{7d}\u{29}\u{28}\u{29}
        """
    }

    

    private static let largeJSONThreshold = 64 * 1024

    

    

    

    

    

    private static func rSxtmeTXGdOFQln(
        _ data: JSValue?,
        headers: [String: String]
    ) -> (body: String?, ensureContentType: String?) {
        guard let data, !data.isUndefined, !data.isNull else {
            return (nil, nil)
        }

        if data.isString {
            return (data.toString(), nil)
        }

        let contentType = headers.first(where: { $0.key.lowercased() == "\u{63}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{74}\u{79}\u{70}\u{65}" })?.value
            .lowercased() ?? ""
        let preferForm = contentType.contains("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}")

        if data.isObject, let map = data.toDictionary(), !map.isEmpty {
            if preferForm {
                let pairs: [String] = map.compactMap { key, value in
                    guard let key = key as? String else { return nil }
                    return "\(iLcuomneEofjtN(key))\u{3d}\(iLcuomneEofjtN(nNNiIqJkhOeEnm(value)))"
                }
                return (
                    pairs.joined(separator: "\u{26}"),
                    "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}"
                )
            }

            
            if JSONSerialization.isValidJSONObject(map),
               let jsonData = try? JSONSerialization.data(withJSONObject: map),
               let json = String(data: jsonData, encoding: .utf8) {
                return (json, "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{3b} \u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}")
            }
        }

        return (data.toString(), nil)
    }

    private static func nNNiIqJkhOeEnm(_ value: Any) -> String {
        
        do {
            let gVfQxslDXVbGXJMOdgJ = [40, 40, 28]
            var uVZIIpZmZZHVRtImV = 0
            for rUjhAvgOptKC in gVfQxslDXVbGXJMOdgJ {
                switch (uVZIIpZmZZHVRtImV + rUjhAvgOptKC) % 3 {
                case 0:
                    uVZIIpZmZZHVRtImV = (uVZIIpZmZZHVRtImV * 7 + rUjhAvgOptKC) % 101
                case 1:
                    uVZIIpZmZZHVRtImV ^= rUjhAvgOptKC + 3
                default:
                    uVZIIpZmZZHVRtImV = (uVZIIpZmZZHVRtImV + rUjhAvgOptKC * 5) % 97
                }
            }
            let kJOPerCOmPYkuwftWv = gVfQxslDXVbGXJMOdgJ.map { (($0 * 11) + uVZIIpZmZZHVRtImV) % 127 }
            let wCLOXbTutXNN = kJOPerCOmPYkuwftWv.filter { ($0 + uVZIIpZmZZHVRtImV) % 2 == 0 }
            let oCKIOozvOMdSZfQW = Dictionary(uniqueKeysWithValues: wCLOXbTutXNN.enumerated().map { ($0.offset, $0.element) })
            for lIlMUmukbXkiqyuDhYoZ in oCKIOozvOMdSZfQW.keys.sorted() {
                uVZIIpZmZZHVRtImV = (uVZIIpZmZZHVRtImV + lIlMUmukbXkiqyuDhYoZ + (oCKIOozvOMdSZfQW[lIlMUmukbXkiqyuDhYoZ] ?? 0)) % 131
            }
            let gGStwAatvyNzRBR = kJOPerCOmPYkuwftWv.map { String($0) }.joined(separator: "\u{2d}")
            uVZIIpZmZZHVRtImV = (uVZIIpZmZZHVRtImV + gGStwAatvyNzRBR.utf8.count) % 137
            _ = uVZIIpZmZZHVRtImV
        }

        
        switch (value is NSNull) {
        case true: do {return "" }
        case false:
            break
        }
        if let number = value as? NSNumber {
            
            if CFGetTypeID(number) == CFBooleanGetTypeID() {
                return number.boolValue ? "\u{74}\u{72}\u{75}\u{65}" : "\u{66}\u{61}\u{6c}\u{73}\u{65}"
            }
            return number.stringValue
        }
        if let text = value as? String { return text }
        return String(describing: value)
    }

    private static func iLcuomneEofjtN(_ value: String) -> String {
        
        do {
            let qNnoZTRyyytUZBzRppU = [9, 20, 52]
            var gJRRvgkrNrcP = 0
            for fRbDXDsdVfuuPIfz in qNnoZTRyyytUZBzRppU {
                switch (gJRRvgkrNrcP + fRbDXDsdVfuuPIfz) % 3 {
                case 0:
                    gJRRvgkrNrcP = (gJRRvgkrNrcP * 7 + fRbDXDsdVfuuPIfz) % 101
                case 1:
                    gJRRvgkrNrcP ^= fRbDXDsdVfuuPIfz + 3
                default:
                    gJRRvgkrNrcP = (gJRRvgkrNrcP + fRbDXDsdVfuuPIfz * 5) % 97
                }
            }
            let xHnQSLkTNRnrDECWYN = qNnoZTRyyytUZBzRppU.map { (($0 * 11) + gJRRvgkrNrcP) % 127 }
            let nFkHqIYodJiidBxVdHJ = xHnQSLkTNRnrDECWYN.filter { ($0 + gJRRvgkrNrcP) % 2 == 0 }
            let zVSPfAgzNBskzPWq = Dictionary(uniqueKeysWithValues: nFkHqIYodJiidBxVdHJ.enumerated().map { ($0.offset, $0.element) })
            for pDZmdvagsizjkmJNrqc in zVSPfAgzNBskzPWq.keys.sorted() {
                gJRRvgkrNrcP = (gJRRvgkrNrcP + pDZmdvagsizjkmJNrqc + (zVSPfAgzNBskzPWq[pDZmdvagsizjkmJNrqc] ?? 0)) % 131
            }
            let vZvAOjpxfUQACfRYhZ = xHnQSLkTNRnrDECWYN.map { String($0) }.joined(separator: "\u{2d}")
            gJRRvgkrNrcP = (gJRRvgkrNrcP + vZvAOjpxfUQACfRYhZ.utf8.count) % 137
            _ = gJRRvgkrNrcP
        }

        var allowed = CharacterSet.alphanumerics
        
        do {
            let zWXEimqKxKTW = [29, 70, 42]
            let zKAgVucldeRkxaTFeQy = (zWXEimqKxKTW.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch zKAgVucldeRkxaTFeQy {
            case 0:
                allowed.insert(charactersIn: "\u{2d}\u{5f}\u{2e}\u{21}\u{7e}\u{2a}\u{27}\u{28}\u{29}")
            case 1:
                allowed.insert(charactersIn: "\u{2d}\u{5f}\u{2e}\u{21}\u{7e}\u{2a}\u{27}\u{28}\u{29}")
            case 2:
                allowed.insert(charactersIn: "\u{2d}\u{5f}\u{2e}\u{21}\u{7e}\u{2a}\u{27}\u{28}\u{29}")
            default:
                allowed.insert(charactersIn: "\u{2d}\u{5f}\u{2e}\u{21}\u{7e}\u{2a}\u{27}\u{28}\u{29}")
            }
        }
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    

    private static func aBdjYkrTjtMTaoIIPz(_ url: String, query: [String: String]) -> String {
        
        do {
            let tEFFGMsyzkXdT = [37, 47, 43]
            var iPdIPQJpRytNvZTTF = 0
            for lYrEfrwdCTyMDRmEG in tEFFGMsyzkXdT {
                switch (iPdIPQJpRytNvZTTF + lYrEfrwdCTyMDRmEG) % 3 {
                case 0:
                    iPdIPQJpRytNvZTTF = (iPdIPQJpRytNvZTTF * 7 + lYrEfrwdCTyMDRmEG) % 101
                case 1:
                    iPdIPQJpRytNvZTTF ^= lYrEfrwdCTyMDRmEG + 3
                default:
                    iPdIPQJpRytNvZTTF = (iPdIPQJpRytNvZTTF + lYrEfrwdCTyMDRmEG * 5) % 97
                }
            }
            let jUoromqYIGAO = tEFFGMsyzkXdT.map { (($0 * 11) + iPdIPQJpRytNvZTTF) % 127 }
            let rHmYAcuWlRPfJlonDhZY = jUoromqYIGAO.filter { ($0 + iPdIPQJpRytNvZTTF) % 2 == 0 }
            let gHzDjNeFHAPEkKHJGd = Dictionary(uniqueKeysWithValues: rHmYAcuWlRPfJlonDhZY.enumerated().map { ($0.offset, $0.element) })
            for bVbAZgBymEbIGSst in gHzDjNeFHAPEkKHJGd.keys.sorted() {
                iPdIPQJpRytNvZTTF = (iPdIPQJpRytNvZTTF + bVbAZgBymEbIGSst + (gHzDjNeFHAPEkKHJGd[bVbAZgBymEbIGSst] ?? 0)) % 131
            }
            let yQTapjjyqaRsecTNOrZ = jUoromqYIGAO.map { String($0) }.joined(separator: "\u{2d}")
            iPdIPQJpRytNvZTTF = (iPdIPQJpRytNvZTTF + yQTapjjyqaRsecTNOrZ.utf8.count) % 137
            _ = iPdIPQJpRytNvZTTF
        }

        guard !query.isEmpty, var components = URLComponents(string: url) else { return url }
        var items = components.queryItems ?? []
        
        do {
            let dMaZfqQOjOtjiRxOoh = [17, 45, 74]
            let yQevzoVLLLNHWpbiueyw = (dMaZfqQOjOtjiRxOoh.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch yQevzoVLLLNHWpbiueyw {
            case 0:
                items.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
            case 1:
                items.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
            case 2:
                items.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
            default:
                items.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
            }
        }
        components.queryItems = items
        return components.url?.absoluteString ?? url
    }

    private static func sPuaJqNgerHHUXf(from value: JSValue?) -> [String: String] {
        
        do {
            let tUCMYrAhuqKQQDF = [38, 34, 45]
            var rZFifSdEOdsmo = 0
            for fNhRpcFhXEncw in tUCMYrAhuqKQQDF {
                switch (rZFifSdEOdsmo + fNhRpcFhXEncw) % 3 {
                case 0:
                    rZFifSdEOdsmo = (rZFifSdEOdsmo * 7 + fNhRpcFhXEncw) % 101
                case 1:
                    rZFifSdEOdsmo ^= fNhRpcFhXEncw + 3
                default:
                    rZFifSdEOdsmo = (rZFifSdEOdsmo + fNhRpcFhXEncw * 5) % 97
                }
            }
            let jJrbnUGdjnSVvoOsm = tUCMYrAhuqKQQDF.map { (($0 * 11) + rZFifSdEOdsmo) % 127 }
            let zDJegYQJWWxfsm = jJrbnUGdjnSVvoOsm.filter { ($0 + rZFifSdEOdsmo) % 2 == 0 }
            let gUZDNVarPUKacqmAgHJz = Dictionary(uniqueKeysWithValues: zDJegYQJWWxfsm.enumerated().map { ($0.offset, $0.element) })
            for vIgSgzmtBrVkZ in gUZDNVarPUKacqmAgHJz.keys.sorted() {
                rZFifSdEOdsmo = (rZFifSdEOdsmo + vIgSgzmtBrVkZ + (gUZDNVarPUKacqmAgHJz[vIgSgzmtBrVkZ] ?? 0)) % 131
            }
            let cPTTzHkFxKfJ = jJrbnUGdjnSVvoOsm.map { String($0) }.joined(separator: "\u{2d}")
            rZFifSdEOdsmo = (rZFifSdEOdsmo + cPTTzHkFxKfJ.utf8.count) % 137
            _ = rZFifSdEOdsmo
        }

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
    \u{76}\u{61}\u{72} \u{63}\u{6f}\u{6e}\u{73}\u{6f}\u{6c}\u{65} \u{3d} \u{7b}
      \u{6c}\u{6f}\u{67}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{43}\u{6f}\u{6e}\u{73}\u{6f}\u{6c}\u{65}\u{4c}\u{6f}\u{67}\u{28}\u{27}\u{6c}\u{6f}\u{67}\u{27}\u{2c} \u{41}\u{72}\u{72}\u{61}\u{79}\u{2e}\u{70}\u{72}\u{6f}\u{74}\u{6f}\u{74}\u{79}\u{70}\u{65}\u{2e}\u{73}\u{6c}\u{69}\u{63}\u{65}\u{2e}\u{63}\u{61}\u{6c}\u{6c}\u{28}\u{61}\u{72}\u{67}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{29}\u{2e}\u{6a}\u{6f}\u{69}\u{6e}\u{28}\u{27} \u{27}\u{29}\u{29}\u{3b} \u{7d}\u{2c}
      \u{65}\u{72}\u{72}\u{6f}\u{72}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{43}\u{6f}\u{6e}\u{73}\u{6f}\u{6c}\u{65}\u{4c}\u{6f}\u{67}\u{28}\u{27}\u{65}\u{72}\u{72}\u{6f}\u{72}\u{27}\u{2c} \u{41}\u{72}\u{72}\u{61}\u{79}\u{2e}\u{70}\u{72}\u{6f}\u{74}\u{6f}\u{74}\u{79}\u{70}\u{65}\u{2e}\u{73}\u{6c}\u{69}\u{63}\u{65}\u{2e}\u{63}\u{61}\u{6c}\u{6c}\u{28}\u{61}\u{72}\u{67}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{29}\u{2e}\u{6a}\u{6f}\u{69}\u{6e}\u{28}\u{27} \u{27}\u{29}\u{29}\u{3b} \u{7d}\u{2c}
      \u{77}\u{61}\u{72}\u{6e}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{43}\u{6f}\u{6e}\u{73}\u{6f}\u{6c}\u{65}\u{4c}\u{6f}\u{67}\u{28}\u{27}\u{77}\u{61}\u{72}\u{6e}\u{27}\u{2c} \u{41}\u{72}\u{72}\u{61}\u{79}\u{2e}\u{70}\u{72}\u{6f}\u{74}\u{6f}\u{74}\u{79}\u{70}\u{65}\u{2e}\u{73}\u{6c}\u{69}\u{63}\u{65}\u{2e}\u{63}\u{61}\u{6c}\u{6c}\u{28}\u{61}\u{72}\u{67}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{29}\u{2e}\u{6a}\u{6f}\u{69}\u{6e}\u{28}\u{27} \u{27}\u{29}\u{29}\u{3b} \u{7d}\u{2c}
      \u{69}\u{6e}\u{66}\u{6f}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{43}\u{6f}\u{6e}\u{73}\u{6f}\u{6c}\u{65}\u{4c}\u{6f}\u{67}\u{28}\u{27}\u{69}\u{6e}\u{66}\u{6f}\u{27}\u{2c} \u{41}\u{72}\u{72}\u{61}\u{79}\u{2e}\u{70}\u{72}\u{6f}\u{74}\u{6f}\u{74}\u{79}\u{70}\u{65}\u{2e}\u{73}\u{6c}\u{69}\u{63}\u{65}\u{2e}\u{63}\u{61}\u{6c}\u{6c}\u{28}\u{61}\u{72}\u{67}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{29}\u{2e}\u{6a}\u{6f}\u{69}\u{6e}\u{28}\u{27} \u{27}\u{29}\u{29}\u{3b} \u{7d}
    \u{7d}\u{3b}

    \u{2f}\u{2f} \u{7528}\u{539f}\u{751f}\u{65f6}\u{949f} \u{2b} \u{48}\u{54}\u{54}\u{50} \u{44}\u{61}\u{74}\u{65} \u{504f}\u{79fb}\u{8986}\u{76d6} \u{44}\u{61}\u{74}\u{65}\u{2e}\u{6e}\u{6f}\u{77}\u{ff0c}\u{4f9b}\u{74dc}\u{5b50}\u{2f}\u{6854}\u{5b50}\u{7b49}\u{6309}\u{79d2}\u{7b7e}\u{540d}\u{7684}\u{6e90}\u{4f7f}\u{7528}\u{3002}
    \u{2f}\u{2f} \u{6d4f}\u{89c8}\u{5668}\u{2f}\u{41}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64} \u{7684} \u{44}\u{61}\u{74}\u{65}\u{2e}\u{6e}\u{6f}\u{77}\u{28}\u{29} \u{662f}\u{6574}\u{6570}\u{6beb}\u{79d2}\u{ff1b}\u{539f}\u{751f}\u{6865}\u{82e5}\u{8fd4}\u{56de} \u{44}\u{6f}\u{75}\u{62}\u{6c}\u{65} \u{5c0f}\u{6570}\u{ff0c}
    \u{2f}\u{2f} \u{6854}\u{5b50} \u{6a}\u{75}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{28}\u{74}\u{69}\u{6d}\u{65}\u{73}\u{74}\u{61}\u{6d}\u{70}\u{29} \u{4f1a}\u{5e26}\u{5c0f}\u{6570}\u{70b9}\u{ff0c}\u{5bfc}\u{81f4} \u{76}\u{35} \u{70}\u{72}\u{6f}\u{74}\u{6f}\u{62}\u{75}\u{66} \u{9274}\u{6743}\u{5931}\u{8d25}\u{3002}
    \u{28}\u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b}
      \u{76}\u{61}\u{72} \u{5f}\u{6f}\u{72}\u{69}\u{67}\u{69}\u{6e}\u{61}\u{6c}\u{44}\u{61}\u{74}\u{65}\u{4e}\u{6f}\u{77} \u{3d} \u{44}\u{61}\u{74}\u{65}\u{2e}\u{6e}\u{6f}\u{77}\u{2e}\u{62}\u{69}\u{6e}\u{64}\u{28}\u{44}\u{61}\u{74}\u{65}\u{29}\u{3b}
      \u{44}\u{61}\u{74}\u{65}\u{2e}\u{6e}\u{6f}\u{77} \u{3d} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{29} \u{7b}
        \u{74}\u{72}\u{79} \u{7b}
          \u{69}\u{66} \u{28}\u{74}\u{79}\u{70}\u{65}\u{6f}\u{66} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{44}\u{61}\u{74}\u{65}\u{4e}\u{6f}\u{77} \u{3d}\u{3d}\u{3d} \u{27}\u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{27}\u{29} \u{7b}
            \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{4d}\u{61}\u{74}\u{68}\u{2e}\u{66}\u{6c}\u{6f}\u{6f}\u{72}\u{28}\u{4e}\u{75}\u{6d}\u{62}\u{65}\u{72}\u{28}\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{44}\u{61}\u{74}\u{65}\u{4e}\u{6f}\u{77}\u{28}\u{29}\u{29} \u{7c}\u{7c} \u{30}\u{29}\u{3b}
          \u{7d}
        \u{7d} \u{63}\u{61}\u{74}\u{63}\u{68} \u{28}\u{5f}\u{29} \u{7b}\u{7d}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{4d}\u{61}\u{74}\u{68}\u{2e}\u{66}\u{6c}\u{6f}\u{6f}\u{72}\u{28}\u{5f}\u{6f}\u{72}\u{69}\u{67}\u{69}\u{6e}\u{61}\u{6c}\u{44}\u{61}\u{74}\u{65}\u{4e}\u{6f}\u{77}\u{28}\u{29}\u{29}\u{3b}
      \u{7d}\u{3b}
    \u{7d}\u{29}\u{28}\u{29}\u{3b}

    \u{76}\u{61}\u{72} \u{45}\u{76}\u{61}\u{6c}\u{48}\u{74}\u{74}\u{70} \u{3d} \u{7b}
      \u{67}\u{65}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{75}\u{72}\u{6c}\u{2c} \u{71}\u{75}\u{65}\u{72}\u{79}\u{2c} \u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{73}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{48}\u{74}\u{74}\u{70}\u{47}\u{65}\u{74}\u{28}\u{75}\u{72}\u{6c}\u{2c} \u{71}\u{75}\u{65}\u{72}\u{79} \u{7c}\u{7c} \u{6e}\u{75}\u{6c}\u{6c}\u{2c} \u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{73} \u{7c}\u{7c} \u{6e}\u{75}\u{6c}\u{6c}\u{29}\u{3b} \u{7d}\u{2c}
      \u{70}\u{6f}\u{73}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{75}\u{72}\u{6c}\u{2c} \u{64}\u{61}\u{74}\u{61}\u{2c} \u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{73}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{48}\u{74}\u{74}\u{70}\u{50}\u{6f}\u{73}\u{74}\u{28}\u{75}\u{72}\u{6c}\u{2c} \u{64}\u{61}\u{74}\u{61} \u{7c}\u{7c} \u{6e}\u{75}\u{6c}\u{6c}\u{2c} \u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{73} \u{7c}\u{7c} \u{6e}\u{75}\u{6c}\u{6c}\u{29}\u{3b} \u{7d}\u{2c}
      \u{70}\u{6f}\u{73}\u{74}\u{52}\u{61}\u{77}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{75}\u{72}\u{6c}\u{2c} \u{62}\u{61}\u{73}\u{65}\u{36}\u{34}\u{42}\u{6f}\u{64}\u{79}\u{2c} \u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{73}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{48}\u{74}\u{74}\u{70}\u{50}\u{6f}\u{73}\u{74}\u{52}\u{61}\u{77}\u{28}\u{75}\u{72}\u{6c}\u{2c} \u{62}\u{61}\u{73}\u{65}\u{36}\u{34}\u{42}\u{6f}\u{64}\u{79} \u{7c}\u{7c} \u{6e}\u{75}\u{6c}\u{6c}\u{2c} \u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{73} \u{7c}\u{7c} \u{6e}\u{75}\u{6c}\u{6c}\u{29}\u{3b} \u{7d}
    \u{7d}\u{3b}

    \u{76}\u{61}\u{72} \u{43}\u{72}\u{79}\u{70}\u{74}\u{6f}\u{55}\u{74}\u{69}\u{6c} \u{3d} \u{7b}
      \u{4d}\u{64}\u{35}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{69}\u{73}\u{31}\u{36}\u{42}\u{69}\u{74}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{4d}\u{64}\u{35}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{69}\u{73}\u{31}\u{36}\u{42}\u{69}\u{74} \u{3d}\u{3d}\u{3d} \u{74}\u{72}\u{75}\u{65}\u{29}\u{3b} \u{7d}\u{2c}
      \u{53}\u{68}\u{61}\u{31}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{68}\u{61}\u{31}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29}\u{3b} \u{7d}\u{2c}
      \u{53}\u{68}\u{61}\u{32}\u{35}\u{36}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{68}\u{61}\u{32}\u{35}\u{36}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29}\u{3b} \u{7d}\u{2c}
      \u{42}\u{61}\u{73}\u{65}\u{36}\u{34}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{42}\u{61}\u{73}\u{65}\u{36}\u{34}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29}\u{3b} \u{7d}\u{2c}
      \u{42}\u{61}\u{73}\u{65}\u{36}\u{34}\u{44}\u{65}\u{63}\u{6f}\u{64}\u{65}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{42}\u{61}\u{73}\u{65}\u{36}\u{34}\u{44}\u{65}\u{63}\u{6f}\u{64}\u{65}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29}\u{3b} \u{7d}\u{2c}
      \u{41}\u{65}\u{73}\u{45}\u{6e}\u{63}\u{72}\u{79}\u{70}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{6b}\u{65}\u{79}\u{2c} \u{69}\u{76}\u{2c} \u{6d}\u{6f}\u{64}\u{65}\u{73}\u{2c} \u{70}\u{61}\u{64}\u{64}\u{69}\u{6e}\u{67}\u{29} \u{7b}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{41}\u{65}\u{73}\u{45}\u{6e}\u{63}\u{72}\u{79}\u{70}\u{74}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{6b}\u{65}\u{79}\u{2c} \u{69}\u{76} \u{7c}\u{7c} \u{27}\u{27}\u{2c} \u{6d}\u{6f}\u{64}\u{65}\u{73} \u{7c}\u{7c} \u{27}\u{45}\u{43}\u{42}\u{27}\u{2c} \u{70}\u{61}\u{64}\u{64}\u{69}\u{6e}\u{67} \u{7c}\u{7c} \u{27}\u{50}\u{4b}\u{43}\u{53}\u{37}\u{27}\u{29}\u{3b}
      \u{7d}\u{2c}
      \u{41}\u{65}\u{73}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{6b}\u{65}\u{79}\u{2c} \u{69}\u{76}\u{2c} \u{6d}\u{6f}\u{64}\u{65}\u{73}\u{2c} \u{70}\u{61}\u{64}\u{64}\u{69}\u{6e}\u{67}\u{29} \u{7b}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{41}\u{65}\u{73}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{6b}\u{65}\u{79}\u{2c} \u{69}\u{76} \u{7c}\u{7c} \u{27}\u{27}\u{2c} \u{6d}\u{6f}\u{64}\u{65}\u{73} \u{7c}\u{7c} \u{27}\u{45}\u{43}\u{42}\u{27}\u{2c} \u{70}\u{61}\u{64}\u{64}\u{69}\u{6e}\u{67} \u{7c}\u{7c} \u{27}\u{50}\u{4b}\u{43}\u{53}\u{37}\u{27}\u{29}\u{3b}
      \u{7d}\u{2c}
      \u{52}\u{73}\u{61}\u{45}\u{6e}\u{63}\u{72}\u{79}\u{70}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{70}\u{75}\u{62}\u{6c}\u{69}\u{63}\u{4b}\u{65}\u{79}\u{50}\u{65}\u{6d}\u{2c} \u{65}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}\u{29} \u{7b}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{52}\u{73}\u{61}\u{45}\u{6e}\u{63}\u{72}\u{79}\u{70}\u{74}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{70}\u{75}\u{62}\u{6c}\u{69}\u{63}\u{4b}\u{65}\u{79}\u{50}\u{65}\u{6d}\u{2c} \u{65}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67} \u{7c}\u{7c} \u{27}\u{4f}\u{41}\u{45}\u{50}\u{27}\u{29}\u{3b}
      \u{7d}\u{2c}
      \u{52}\u{73}\u{61}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{70}\u{72}\u{69}\u{76}\u{61}\u{74}\u{65}\u{4b}\u{65}\u{79}\u{50}\u{65}\u{6d}\u{2c} \u{65}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}\u{29} \u{7b}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{52}\u{73}\u{61}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{70}\u{72}\u{69}\u{76}\u{61}\u{74}\u{65}\u{4b}\u{65}\u{79}\u{50}\u{65}\u{6d}\u{2c} \u{65}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67} \u{7c}\u{7c} \u{27}\u{4f}\u{41}\u{45}\u{50}\u{27}\u{29}\u{3b}
      \u{7d}\u{2c}
      \u{52}\u{73}\u{61}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{43}\u{68}\u{75}\u{6e}\u{6b}\u{65}\u{64}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{70}\u{72}\u{69}\u{76}\u{61}\u{74}\u{65}\u{4b}\u{65}\u{79}\u{50}\u{65}\u{6d}\u{2c} \u{65}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}\u{29} \u{7b}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{52}\u{73}\u{61}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{43}\u{68}\u{75}\u{6e}\u{6b}\u{65}\u{64}\u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{2c} \u{70}\u{72}\u{69}\u{76}\u{61}\u{74}\u{65}\u{4b}\u{65}\u{79}\u{50}\u{65}\u{6d}\u{2c} \u{65}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67} \u{7c}\u{7c} \u{27}\u{50}\u{4b}\u{43}\u{53}\u{31}\u{27}\u{29}\u{3b}
      \u{7d}
    \u{7d}\u{3b}

    \u{76}\u{61}\u{72} \u{53}\u{61}\u{76}\u{65} \u{3d} \u{7b}
      \u{53}\u{74}\u{6f}\u{72}\u{65}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{2c} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{53}\u{74}\u{6f}\u{72}\u{65}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{28}\u{6b}\u{65}\u{79}\u{2c} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{29}\u{3b} \u{7d}\u{2c}
      \u{54}\u{61}\u{6b}\u{65}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{54}\u{61}\u{6b}\u{65}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{28}\u{6b}\u{65}\u{79}\u{29}\u{3b} \u{7d}\u{2c}
      \u{53}\u{74}\u{6f}\u{72}\u{65}\u{49}\u{6e}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{2c} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{53}\u{74}\u{6f}\u{72}\u{65}\u{49}\u{6e}\u{74}\u{28}\u{6b}\u{65}\u{79}\u{2c} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{29}\u{3b} \u{7d}\u{2c}
      \u{54}\u{61}\u{6b}\u{65}\u{49}\u{6e}\u{74}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{54}\u{61}\u{6b}\u{65}\u{49}\u{6e}\u{74}\u{28}\u{6b}\u{65}\u{79}\u{29}\u{3b} \u{7d}\u{2c}
      \u{53}\u{74}\u{6f}\u{72}\u{65}\u{42}\u{6f}\u{6f}\u{6c}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{2c} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{53}\u{74}\u{6f}\u{72}\u{65}\u{42}\u{6f}\u{6f}\u{6c}\u{28}\u{6b}\u{65}\u{79}\u{2c} \u{76}\u{61}\u{6c}\u{75}\u{65}\u{29}\u{3b} \u{7d}\u{2c}
      \u{54}\u{61}\u{6b}\u{65}\u{42}\u{6f}\u{6f}\u{6c}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{54}\u{61}\u{6b}\u{65}\u{42}\u{6f}\u{6f}\u{6c}\u{28}\u{6b}\u{65}\u{79}\u{29}\u{3b} \u{7d}\u{2c}
      \u{44}\u{65}\u{6c}\u{65}\u{74}\u{65}\u{3a} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{28}\u{6b}\u{65}\u{79}\u{29} \u{7b} \u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{44}\u{65}\u{6c}\u{65}\u{74}\u{65}\u{28}\u{6b}\u{65}\u{79}\u{29}\u{3b} \u{7d}
    \u{7d}\u{3b}
    """

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lUZfbdzNKlamGsVVDsG() -> String {
        _ = Self.qUwDXEaAifJX()
        _ = Self.rArkyXSunfMSVJvLgqj()
        _ = Self.jNrCkGjASWhcJ()
        _ = Self.wQgZKgWSrAJMyrbvUj()
        _ = Self.qEwEYJidXzQeAnLTiXcd()
        let token = "\u{65}\u{62}\u{30}\u{39}\u{63}\u{64}\u{31}\u{61}\u{62}\u{64}\u{33}\u{33}\u{39}\u{39}\u{31}\u{62}\u{36}\u{63}\u{66}\u{66}\u{64}\u{30}\u{34}\u{64}"
        let source = "\u{65}\u{62}\u{30}\u{39}\u{63}\u{64}\u{31}\u{61}\u{62}\u{64}\u{33}\u{33}\u{39}\u{39}\u{31}\u{62}\u{36}\u{63}\u{66}\u{66}\u{64}\u{30}\u{34}\u{64}\u{2d}\u{33}\u{38}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 38) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func qUwDXEaAifJX() -> String {
        let token = "\u{30}\u{65}\u{63}\u{63}\u{39}\u{33}\u{36}\u{30}\u{38}\u{37}\u{37}\u{34}\u{62}\u{39}\u{31}\u{62}\u{33}\u{31}\u{62}\u{39}\u{34}\u{38}\u{36}\u{36}"
        let base = (9 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 9) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func rArkyXSunfMSVJvLgqj() -> String {
        let base = (39 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 39) * 7
        let token = "\u{63}\u{37}\u{64}\u{63}\u{64}\u{65}\u{65}\u{31}\u{36}\u{66}\u{62}\u{39}\u{34}\u{37}\u{66}\u{64}\u{63}\u{36}\u{37}\u{62}\u{33}\u{66}\u{32}\u{65}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func jNrCkGjASWhcJ() -> String {
        let token = "\u{62}\u{64}\u{35}\u{33}\u{61}\u{65}\u{36}\u{30}\u{65}\u{34}\u{65}\u{39}\u{65}\u{64}\u{61}\u{38}\u{35}\u{62}\u{36}\u{61}\u{30}\u{34}\u{62}\u{65}"
        let base = (74 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 74) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func wQgZKgWSrAJMyrbvUj() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 8, "\u{65}\u{61}\u{73}\u{74}": 17, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 72]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 8) * 9
        let token = "\u{33}\u{37}\u{32}\u{38}\u{36}\u{36}\u{62}\u{63}\u{34}\u{64}\u{37}\u{66}\u{36}\u{30}\u{37}\u{32}\u{32}\u{62}\u{65}\u{31}\u{37}\u{66}\u{65}\u{33}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func qEwEYJidXzQeAnLTiXcd() -> String {
        let token = "\u{36}\u{65}\u{65}\u{66}\u{33}\u{38}\u{36}\u{30}\u{64}\u{30}\u{62}\u{38}\u{32}\u{39}\u{39}\u{62}\u{64}\u{65}\u{65}\u{35}\u{39}\u{61}\u{65}\u{65}"
        let base = (7 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 7) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

enum AmnhMLrPDtSFdZD {
    private static let lock = NSLock()
    private static var _offsetMilliseconds: Double = 0

    static var offsetMilliseconds: Double {
        lock.lock()
        defer { lock.unlock() }
        return _offsetMilliseconds
    }

    

    static func iLScMcjYLUhrZT(httpResponse: HTTPURLResponse) {
        // source-obfuscator:padding:v1
        _ = Self.xTJaWXomuECbbdKzUU()

        
        do {
            let xITSJGfAajrZ = [9, 59, 65]
            var tELetWXGiGYOIaFny = 0
            for mCTqlzzKwGXKBqxNsSk in xITSJGfAajrZ {
                switch (tELetWXGiGYOIaFny + mCTqlzzKwGXKBqxNsSk) % 3 {
                case 0:
                    tELetWXGiGYOIaFny = (tELetWXGiGYOIaFny * 7 + mCTqlzzKwGXKBqxNsSk) % 101
                case 1:
                    tELetWXGiGYOIaFny ^= mCTqlzzKwGXKBqxNsSk + 3
                default:
                    tELetWXGiGYOIaFny = (tELetWXGiGYOIaFny + mCTqlzzKwGXKBqxNsSk * 5) % 97
                }
            }
            let cUQjvSqgEhIHLKwU = xITSJGfAajrZ.map { (($0 * 11) + tELetWXGiGYOIaFny) % 127 }
            let rCuOWPOkaNKFQGbFwTgc = cUQjvSqgEhIHLKwU.filter { ($0 + tELetWXGiGYOIaFny) % 2 == 0 }
            let dXWuLpGHOLIKfqqS = Dictionary(uniqueKeysWithValues: rCuOWPOkaNKFQGbFwTgc.enumerated().map { ($0.offset, $0.element) })
            for wWcdkOCqJtdoOFj in dXWuLpGHOLIKfqqS.keys.sorted() {
                tELetWXGiGYOIaFny = (tELetWXGiGYOIaFny + wWcdkOCqJtdoOFj + (dXWuLpGHOLIKfqqS[wWcdkOCqJtdoOFj] ?? 0)) % 131
            }
            let xGCiIlqrFxxe = cUQjvSqgEhIHLKwU.map { String($0) }.joined(separator: "\u{2d}")
            tELetWXGiGYOIaFny = (tELetWXGiGYOIaFny + xGCiIlqrFxxe.utf8.count) % 137
            _ = tELetWXGiGYOIaFny
        }

        guard let raw = httpResponse.value(forHTTPHeaderField: "\u{44}\u{61}\u{74}\u{65}"),
              let server = AmnhMLrPDtSFdZD.eItUvcJomvrr(raw) else {
            return
        }

        let serverMs = server.timeIntervalSince1970 * 1000
        let localMs = Date().timeIntervalSince1970 * 1000
        let next = serverMs - localMs

        
        do {
            let jVtWYBmxxvgr = [17, 46, 95]
            let lZgscOsuTikyC = (jVtWYBmxxvgr.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch lZgscOsuTikyC {
            case 0:
                lock.lock()
            case 1:
                lock.lock()
            case 2:
                lock.lock()
            default:
                lock.lock()
            }
        }
        
        
        switch (abs(next) >= 500) {
        case true: do {
            _offsetMilliseconds = next}
        case false:
            break
        }
        
        do {
            let nFyhwuuaqdCxK = [72, 69, 33]
            let oAnqqzNQNLihlMPTst = (nFyhwuuaqdCxK.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch oAnqqzNQNLihlMPTst {
            case 0:
                lock.unlock()
            case 1:
                lock.unlock()
            case 2:
                lock.unlock()
            default:
                lock.unlock()
            }
        }
    }

    private static func eItUvcJomvrr(_ raw: String) -> Date? {
        
        do {
            let oUAMSxwsqXKj = [37, 53, 70]
            var qDonqeqGwcizkHglrSpH = 0
            for vHhMnJmlXsNUnIFIJvx in oUAMSxwsqXKj {
                switch (qDonqeqGwcizkHglrSpH + vHhMnJmlXsNUnIFIJvx) % 3 {
                case 0:
                    qDonqeqGwcizkHglrSpH = (qDonqeqGwcizkHglrSpH * 7 + vHhMnJmlXsNUnIFIJvx) % 101
                case 1:
                    qDonqeqGwcizkHglrSpH ^= vHhMnJmlXsNUnIFIJvx + 3
                default:
                    qDonqeqGwcizkHglrSpH = (qDonqeqGwcizkHglrSpH + vHhMnJmlXsNUnIFIJvx * 5) % 97
                }
            }
            let rAgWyduxfXUDyYl = oUAMSxwsqXKj.map { (($0 * 11) + qDonqeqGwcizkHglrSpH) % 127 }
            let gNEaAJunsXEy = rAgWyduxfXUDyYl.filter { ($0 + qDonqeqGwcizkHglrSpH) % 2 == 0 }
            let gNxdowTPbrCNt = Dictionary(uniqueKeysWithValues: gNEaAJunsXEy.enumerated().map { ($0.offset, $0.element) })
            for kGMrzkUHiIAoJT in gNxdowTPbrCNt.keys.sorted() {
                qDonqeqGwcizkHglrSpH = (qDonqeqGwcizkHglrSpH + kGMrzkUHiIAoJT + (gNxdowTPbrCNt[kGMrzkUHiIAoJT] ?? 0)) % 131
            }
            let zJtViruoAeffln = rAgWyduxfXUDyYl.map { String($0) }.joined(separator: "\u{2d}")
            qDonqeqGwcizkHglrSpH = (qDonqeqGwcizkHglrSpH + zJtViruoAeffln.utf8.count) % 137
            _ = qDonqeqGwcizkHglrSpH
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "\u{65}\u{6e}\u{5f}\u{55}\u{53}\u{5f}\u{50}\u{4f}\u{53}\u{49}\u{58}")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "\u{45}\u{45}\u{45}\u{2c} \u{64}\u{64} \u{4d}\u{4d}\u{4d} \u{79}\u{79}\u{79}\u{79} \u{48}\u{48}\u{3a}\u{6d}\u{6d}\u{3a}\u{73}\u{73} \u{7a}\u{7a}\u{7a}"
        if let date = formatter.date(from: raw) {
            return date
        }
        formatter.dateFormat = "\u{45}\u{45}\u{45}\u{45}\u{2c} \u{64}\u{64}\u{2d}\u{4d}\u{4d}\u{4d}\u{2d}\u{79}\u{79} \u{48}\u{48}\u{3a}\u{6d}\u{6d}\u{3a}\u{73}\u{73} \u{7a}\u{7a}\u{7a}"
        return formatter.date(from: raw)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xTJaWXomuECbbdKzUU() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 20, "\u{65}\u{61}\u{73}\u{74}": 29, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 180]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 20) * 9
        let token = "\u{30}\u{35}\u{64}\u{38}\u{34}\u{39}\u{30}\u{35}\u{64}\u{61}\u{62}\u{30}\u{38}\u{62}\u{37}\u{39}\u{64}\u{32}\u{37}\u{34}\u{35}\u{30}\u{32}\u{31}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

@MainActor
private final class PnLUhZGOlPaIp {
    var done = false
    var timeout: Task<Void, Never>?
}

@MainActor
enum OjARBePFYkGOKHQPyt {

    private static var runtimes: [String: DsUfbDxzJNTEGoDtXLj] = [:]
    private static var order: [String] = []
    private static let limit = 6

    
}



extension OjARBePFYkGOKHQPyt {
    static func aEyhHBGLxwtIid(for rule: String) -> DsUfbDxzJNTEGoDtXLj? {
        // source-obfuscator:padding:v1
        _ = Self.bWfyyIPhluwZHx()

        
        let key = QxmEAOwBLRLGNSse.rJgTDHvLkUgCfQeHfK("\u{62}\u{72}\u{69}\u{64}\u{67}\u{65}\u{2d}\u{76}\u{36}\u{3a}" + rule)

        if let cached = runtimes[key] {
            return cached
        }

        guard let aEyhHBGLxwtIid = try? DsUfbDxzJNTEGoDtXLj(rule: rule) else {
            return nil
        }

        runtimes[key] = aEyhHBGLxwtIid
        order.append(key)

        if order.count > limit, let oldest = order.first {
            order.removeFirst()
            runtimes.removeValue(forKey: oldest)
        }

        return aEyhHBGLxwtIid
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bWfyyIPhluwZHx() -> String {
        let token = "\u{31}\u{35}\u{31}\u{36}\u{64}\u{32}\u{37}\u{31}\u{36}\u{62}\u{63}\u{34}\u{61}\u{39}\u{39}\u{31}\u{32}\u{36}\u{63}\u{66}\u{32}\u{36}\u{37}\u{65}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 24, "\u{65}\u{61}\u{73}\u{74}": 31, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 168]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 24) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}


extension AmnhMLrPDtSFdZD {
    static func oLFrjyUbhbBOlC() -> Double {
        floor(Date().timeIntervalSince1970 * 1000 + offsetMilliseconds)
    }
}


extension DsUfbDxzJNTEGoDtXLj {
    private static func mAJaDRwtrUrmGScHQ(in context: JSContext) {
        let dHeBYSSFfDMjO: @convention(block) (String, String) -> Void = { level, message in  }

        let fOuOyJhgCxtvp: @convention(block) (String, Bool) -> String = { input, is16Bit in
            let full = QxmEAOwBLRLGNSse.rJgTDHvLkUgCfQeHfK(input)
            
            guard is16Bit, full.count == 32 else { return full }
            let start = full.index(full.startIndex, offsetBy: 8)
            let end = full.index(full.startIndex, offsetBy: 24)
            return String(full[start..<end])
        }
        let mTiqICNlBVlRjhmI: @convention(block) (String) -> String = { QxmEAOwBLRLGNSse.bTsshHXXcmunyor($0) }
        let bINGwuucYpvwCic: @convention(block) (String) -> String = { QxmEAOwBLRLGNSse.hJJwgtqMKWiomlzdaTl($0) }
        let nXrKhjdRBDsDzK: @convention(block) (String) -> String = { QxmEAOwBLRLGNSse.kJCfbNhESXInUxZi($0) }
        let vAiVXjKdeiBoHlZV: @convention(block) (String) -> String = { QxmEAOwBLRLGNSse.nIkfeWlJWSivkEkhXe($0) }

        let vYOOmxSCkyyxPCKpTau: @convention(block) (String, String, String, String, String) -> String = {
            input, key, iv, mode, padding in
            (try? QxmEAOwBLRLGNSse.rSdJrKiqsbvbV(
                Array(input.utf8),
                key: Array(key.utf8),
                iv: Array(iv.utf8),
                mode: mode.isEmpty ? "\u{45}\u{43}\u{42}" : mode,
                padding: padding.isEmpty ? "\u{50}\u{4b}\u{43}\u{53}\u{37}" : padding
            )) ?? ""
        }

        let zMgPqdIQRJQlpiQFnDiM: @convention(block) (String, String, String, String, String) -> String = {
            input, key, iv, mode, padding in
            (try? QxmEAOwBLRLGNSse.zSYbXNkaGCgssuKadGw(
                input,
                key: key,
                iv: iv,
                mode: mode.isEmpty ? "\u{45}\u{43}\u{42}" : mode,
                padding: padding.isEmpty ? "\u{50}\u{4b}\u{43}\u{53}\u{37}" : padding
            )) ?? ""
        }

        let fXdrtfXjVNUl: @convention(block) (String, String, String) -> String = {
            input, publicKeyPem, encoding in
            (try? QxmEAOwBLRLGNSse.lIWvHHaPzHVWmz(
                input,
                publicKeyPem: publicKeyPem,
                encoding: encoding.isEmpty ? "\u{4f}\u{41}\u{45}\u{50}" : encoding
            )) ?? ""
        }

        let nNAkCadCmNBmbDKp: @convention(block) (String, String, String) -> String = {
            input, privateKeyPem, encoding in
            (try? QxmEAOwBLRLGNSse.iXrjUlwFZfPlir(
                input,
                privateKeyPem: privateKeyPem,
                encoding: encoding.isEmpty ? "\u{4f}\u{41}\u{45}\u{50}" : encoding
            )) ?? ""
        }

        let hHCSJkehhqPgikFtcMd: @convention(block) (String, String, String) -> String = {
            input, privateKeyPem, encoding in
            (try? QxmEAOwBLRLGNSse.tZtTgJvctuciHkGmNi(
                input,
                privateKeyPem: privateKeyPem,
                encoding: encoding.isEmpty ? "\u{50}\u{4b}\u{43}\u{53}\u{31}" : encoding
            )) ?? ""
        }

        
        
        
        let tNVvZVETXBJh: @convention(block) () -> Double = {
            AmnhMLrPDtSFdZD.oLFrjyUbhbBOlC()
        }

        let oVQzXrAsAzdChlioFl: @convention(block) (String, String) -> Void = { key, value in
            UserDefaults.standard.set(value, forKey: saveKeyPrefix + key)
        }
        let pJoixNIvZJKczlGAGhnw: @convention(block) (String) -> String = { key in
            UserDefaults.standard.string(forKey: saveKeyPrefix + key) ?? ""
        }
        let sVeEvHdNPKoGEExBWsS: @convention(block) (String, Int) -> Void = { key, value in
            UserDefaults.standard.set(value, forKey: saveKeyPrefix + key)
        }
        let tBImqbpAiKhcunF: @convention(block) (String) -> Int = { key in
            UserDefaults.standard.integer(forKey: saveKeyPrefix + key)
        }
        let zNmfIPGXUiALoO: @convention(block) (String, Bool) -> Void = { key, value in
            UserDefaults.standard.set(value, forKey: saveKeyPrefix + key)
        }
        let zMPFRihltKDbVXMIyC: @convention(block) (String) -> Bool = { key in
            UserDefaults.standard.bool(forKey: saveKeyPrefix + key)
        }
        let rSYvDbFGTwVv: @convention(block) (String) -> Void = { key in
            UserDefaults.standard.removeObject(forKey: saveKeyPrefix + key)
        }

        
        let qDJPcRzOIgmcJsuFeG: @convention(block) (String, JSValue?, JSValue?) -> JSValue? = { url, query, headers in
            DsUfbDxzJNTEGoDtXLj.fEnqvqbBROJJWFTSVNSU(method: "\u{47}\u{45}\u{54}", url: url, query: query, body: nil, headers: headers)
        }
        
        let nNXgHBIsciqXqOZUeRA: @convention(block) (String, JSValue?, JSValue?) -> JSValue? = { url, data, headers in
            let headerMap = DsUfbDxzJNTEGoDtXLj.sPuaJqNgerHHUXf(from: headers)
            let encoded = DsUfbDxzJNTEGoDtXLj.rSxtmeTXGdOFQln(data, headers: headerMap)
            return DsUfbDxzJNTEGoDtXLj.fEnqvqbBROJJWFTSVNSU(
                method: "\u{50}\u{4f}\u{53}\u{54}",
                url: url,
                query: nil,
                body: encoded.body,
                headers: headers,
                ensureContentType: encoded.ensureContentType
            )
        }
        let pDLxlGtRoLfNFMpIK: @convention(block) (String, JSValue?, JSValue?) -> JSValue? = { url, base64Body, headers in
            DsUfbDxzJNTEGoDtXLj.fEnqvqbBROJJWFTSVNSU(
                method: "\u{50}\u{4f}\u{53}\u{54}",
                url: url,
                query: nil,
                body: base64Body.flatMap { $0.isUndefined || $0.isNull ? nil : $0.toString() },
                headers: headers,
                bodyIsBase64: true,
                responseAsBase64: true
            )
        }

        let natives: [String: Any] = [
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{43}\u{6f}\u{6e}\u{73}\u{6f}\u{6c}\u{65}\u{4c}\u{6f}\u{67}": dHeBYSSFfDMjO,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{4d}\u{64}\u{35}": fOuOyJhgCxtvp,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{68}\u{61}\u{31}": mTiqICNlBVlRjhmI,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{68}\u{61}\u{32}\u{35}\u{36}": bINGwuucYpvwCic,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{42}\u{61}\u{73}\u{65}\u{36}\u{34}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{65}": nXrKhjdRBDsDzK,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{42}\u{61}\u{73}\u{65}\u{36}\u{34}\u{44}\u{65}\u{63}\u{6f}\u{64}\u{65}": vAiVXjKdeiBoHlZV,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{41}\u{65}\u{73}\u{45}\u{6e}\u{63}\u{72}\u{79}\u{70}\u{74}": vYOOmxSCkyyxPCKpTau,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{41}\u{65}\u{73}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}": zMgPqdIQRJQlpiQFnDiM,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{52}\u{73}\u{61}\u{45}\u{6e}\u{63}\u{72}\u{79}\u{70}\u{74}": fXdrtfXjVNUl,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{52}\u{73}\u{61}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}": nNAkCadCmNBmbDKp,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{52}\u{73}\u{61}\u{44}\u{65}\u{63}\u{72}\u{79}\u{70}\u{74}\u{43}\u{68}\u{75}\u{6e}\u{6b}\u{65}\u{64}": hHCSJkehhqPgikFtcMd,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{44}\u{61}\u{74}\u{65}\u{4e}\u{6f}\u{77}": tNVvZVETXBJh,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{53}\u{74}\u{6f}\u{72}\u{65}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}": oVQzXrAsAzdChlioFl,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{54}\u{61}\u{6b}\u{65}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}": pJoixNIvZJKczlGAGhnw,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{53}\u{74}\u{6f}\u{72}\u{65}\u{49}\u{6e}\u{74}": sVeEvHdNPKoGEExBWsS,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{54}\u{61}\u{6b}\u{65}\u{49}\u{6e}\u{74}": tBImqbpAiKhcunF,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{53}\u{74}\u{6f}\u{72}\u{65}\u{42}\u{6f}\u{6f}\u{6c}": zNmfIPGXUiALoO,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{54}\u{61}\u{6b}\u{65}\u{42}\u{6f}\u{6f}\u{6c}": zMPFRihltKDbVXMIyC,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{53}\u{61}\u{76}\u{65}\u{44}\u{65}\u{6c}\u{65}\u{74}\u{65}": rSYvDbFGTwVv,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{48}\u{74}\u{74}\u{70}\u{47}\u{65}\u{74}": qDJPcRzOIgmcJsuFeG,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{48}\u{74}\u{74}\u{70}\u{50}\u{6f}\u{73}\u{74}": nNXgHBIsciqXqOZUeRA,
            "\u{6e}\u{61}\u{74}\u{69}\u{76}\u{65}\u{48}\u{74}\u{74}\u{70}\u{50}\u{6f}\u{73}\u{74}\u{52}\u{61}\u{77}": pDLxlGtRoLfNFMpIK
        ]

        for (name, block) in natives {
            context.setObject(block, forKeyedSubscript: name as NSString)
        }

        context.evaluateScript(bridgeGlue)
    }

    private static func bNTVqhHeWeTSGgAIoX(_ value: String) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: [value]),
              let text = String(data: data, encoding: .utf8),
              text.count >= 2 else {
            return "\"\""
        }
        
        return String(text.dropFirst().dropLast())
    }

    private func uCPeMSBuPHeRkrb(_ promise: JSValue, function: String) async throws -> String {
        let box = PnLUhZGOlPaIp()

        return try await withCheckedThrowingContinuation { continuation in
            let finish: (Result<String, Error>) -> Void = { result in
                guard !box.done else { return }
                box.done = true
                box.timeout?.cancel()
                continuation.resume(with: result)
            }

            let kYvtfTmUSdsfwFQkN: @convention(block) (JSValue?) -> Void = { value in
                finish(.success(value?.toString() ?? "\u{6e}\u{75}\u{6c}\u{6c}"))
            }
            let nCGNTjwzXczDrrPRO: @convention(block) (JSValue?) -> Void = { value in
                finish(.failure(
                    NaDqiJWAABPJi.promiseRejected(function, value?.toString() ?? "\u{75}\u{6e}\u{6b}\u{6e}\u{6f}\u{77}\u{6e}")
                ))
            }

            promise.invokeMethod(
                "\u{74}\u{68}\u{65}\u{6e}",
                withArguments: [
                    JSValue(object: kYvtfTmUSdsfwFQkN, in: context) as Any,
                    JSValue(object: nCGNTjwzXczDrrPRO, in: context) as Any
                ]
            )

            box.timeout = Task { @MainActor in
                try? await Task.sleep(
                    nanoseconds: UInt64(DsUfbDxzJNTEGoDtXLj.callbackTimeout * 1_000_000_000)
                )
                guard !Task.isCancelled else { return }
                finish(.failure(NaDqiJWAABPJi.promiseTimeout(function)))
            }
        }
    }

    private static func yKZsmvoqlJqSQCdHeg(
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
        
        request.timeoutInterval = 10

        var finalHeaders = headers
        if finalHeaders["\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}"] == nil {
            finalHeaders["\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}"] = LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()
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
            AmnhMLrPDtSFdZD.iLScMcjYLUhrZT(httpResponse: http)
        }

        if responseAsBase64 {
            return data.base64EncodedString()
        }
        return String(data: data, encoding: .utf8)
            ?? String(data: data, encoding: .ascii)
            ?? ""
    }

    private static func tOCEMEuKtUvh(_ serialized: String, function: String) async throws -> Any? {
        if serialized.utf8.count < largeJSONThreshold {
            return try Self.cYzVgFcVKMeovxkdpuW(serialized, function: function)
        }

        return try await Task.detached(priority: .userInitiated) {
            try Self.cYzVgFcVKMeovxkdpuW(serialized, function: function)
        }.value
    }

    private static func fEnqvqbBROJJWFTSVNSU(
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

        var headerMap = sPuaJqNgerHHUXf(from: headers)
        if let ensureContentType,
           headerMap.keys.contains(where: { $0.lowercased() == "\u{63}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{74}\u{79}\u{70}\u{65}" }) == false {
            headerMap["\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}"] = ensureContentType
        }
        let queryMap = sPuaJqNgerHHUXf(from: query)
        let finalURL = aBdjYkrTjtMTaoIIPz(url, query: queryMap)

        return JSValue(newPromiseIn: context) { resolve, reject in
            Task.detached(priority: .userInitiated) {
                do {
                    let text = try await DsUfbDxzJNTEGoDtXLj.yKZsmvoqlJqSQCdHeg(
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

    nonisolated private static func cYzVgFcVKMeovxkdpuW(_ serialized: String, function: String) throws -> Any? {
        if serialized.isEmpty || serialized == "\u{6e}\u{75}\u{6c}\u{6c}" || serialized == "\u{75}\u{6e}\u{64}\u{65}\u{66}\u{69}\u{6e}\u{65}\u{64}" {
            return nil
        }

        guard let data = serialized.data(using: .utf8) else {
            throw NaDqiJWAABPJi.invalidResult(function, serialized)
        }

        guard let json = try? JSONSerialization.jsonObject(
            with: data,
            options: [.fragmentsAllowed]
        ) else {
            throw NaDqiJWAABPJi.invalidResult(function, serialized)
        }

        return json is NSNull ? nil : json
    }
}
