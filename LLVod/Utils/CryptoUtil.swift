//
//  CryptoUtil.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import Foundation
import CryptoSwift
import Security

enum AESDecryptError: LocalizedError {
    case invalidBase64
    case invalidKeyLength(Int)
    case decryptFailed(Error)
    case invalidUTF8

    var errorDescription: String? {
        switch self {
        case .invalidBase64:
            return ""

        case .invalidKeyLength(let length):
            return ""

        case .decryptFailed(let error):
            return ""

        case .invalidUTF8:
            return ""
        }
    }
}

enum CryptoUtilError: LocalizedError {
    case hmacSha1Failed(Error)
    case hmacSha256Failed(Error)
    case aesEncryptFailed(Error)
    case rsaFailed(String)

    var errorDescription: String? {
        switch self {
        case .hmacSha1Failed(let error):
            return ""

        case .hmacSha256Failed(let error):
            return ""

        case .aesEncryptFailed(let error):
            return ""

        case .rsaFailed(let message):
            return message
        }
    }
}

enum CryptoUtil {

    static func md5Hex(_ input: String) -> String {
        Array(input.utf8).md5().toHexString()
    }

    static func sha1Hex(_ input: String) -> String {
        Array(input.utf8).sha1().toHexString()
    }

    static func hmacSha1(
        _ input: String,
        secret: String,
        outputBase64: Bool = false
    ) throws -> String {
        do {
            let inputBytes = Array(input.utf8)
            let secretBytes = Array(secret.utf8)

            let digest = try HMAC(
                key: secretBytes,
                variant: .sha1
            ).authenticate(inputBytes)

            if outputBase64 {
                return Data(digest).base64EncodedString()
            }

            return digest
                .map { String(format: "%02x", $0) }
                .joined()
        } catch {
            throw CryptoUtilError.hmacSha1Failed(error)
        }
    }

    static func sha256Bytes(_ input: [UInt8]) -> [UInt8] {
        input.sha256()
    }

    static func sha256Bytes(_ input: String) -> [UInt8] {
        Array(input.utf8).sha256()
    }

    static func sha256Hex(_ input: String) -> String {
        Array(input.utf8).sha256().toHexString()
    }

    static func hmacSha256(
        _ input: String,
        secret: String,
        outputBase64: Bool = false
    ) throws -> String {
        do {
            let digest = try HMAC(
                key: Array(secret.utf8),
                variant: .sha2(.sha256)
            ).authenticate(Array(input.utf8))

            if outputBase64 {
                return Data(digest).base64EncodedString()
            }

            return digest.toHexString()
        } catch {
            throw CryptoUtilError.hmacSha256Failed(error)
        }
    }

    static func aesEncryptBytes(
        _ input: [UInt8],
        key: [UInt8],
        iv: [UInt8],
        mode: String = "CBC",
        padding: String = "PKCS7"
    ) throws -> String {

        guard [16, 24, 32].contains(key.count) else {
            throw AESDecryptError.invalidKeyLength(key.count)
        }

        do {
            let blockMode: BlockMode = mode.uppercased() == "ECB" ? ECB() : CBC(iv: iv)
            let aes = try AES(
                key: key,
                blockMode: blockMode,
                padding: padding.uppercased() == "PKCS7" ? .pkcs7 : .noPadding
            )

            return Data(try aes.encrypt(input)).base64EncodedString()
        } catch {
            throw CryptoUtilError.aesEncryptFailed(error)
        }
    }

    static func aesEncrypt(
        _ input: String,
        key: String,
        iv: String = "",
        mode: String = "ECB",
        padding: String = "PKCS7"
    ) throws -> String {
        try aesEncryptBytes(
            Array(input.utf8),
            key: Array(key.utf8),
            iv: Array(iv.utf8),
            mode: mode,
            padding: padding
        )
    }

    static func base64Encode(_ input: String) -> String {
        Data(input.utf8).base64EncodedString()
    }

    static func base64Decode(_ input: String) -> String {
        guard let data = Data(
            base64Encoded: normalizeBase64(input),
            options: [.ignoreUnknownCharacters]
        ) else {
            return ""
        }
        return String(data: data, encoding: .utf8) ?? ""
    }

    static func aesDecrypt(
        _ encryptedText: String,
        key: String,
        iv: String = "",
        mode: String = "ECB",
        padding: String = "PKCS7"
    ) throws -> String {
        let keyBytes = Array(key.utf8)

        guard [16, 24, 32].contains(keyBytes.count) else {
            throw AESDecryptError.invalidKeyLength(keyBytes.count)
        }

        guard let encryptedData = Data(
            base64Encoded: normalizeBase64(encryptedText),
            options: [.ignoreUnknownCharacters]
        ) else {
            throw AESDecryptError.invalidBase64
        }

        do {
            let blockMode: BlockMode = mode.uppercased() == "ECB"
                ? ECB()
                : CBC(iv: Array(iv.utf8))

            let aes = try AES(
                key: keyBytes,
                blockMode: blockMode,
                padding: padding.uppercased() == "PKCS7" ? .pkcs7 : .noPadding
            )

            let decrypted = try aes.decrypt(Array(encryptedData))

            guard let result = String(bytes: decrypted, encoding: .utf8) else {
                throw AESDecryptError.invalidUTF8
            }
            return result
        } catch let error as AESDecryptError {
            throw error
        } catch {
            throw AESDecryptError.decryptFailed(error)
        }
    }

    static func aesDecryptECB(
        _ encryptedText: String,
        key: String
    ) throws -> String {

        let keyBytes = Array(key.utf8)

        guard [16, 24, 32].contains(keyBytes.count) else {
            throw AESDecryptError.invalidKeyLength(keyBytes.count)
        }

        let cleanedBase64 = normalizeBase64(encryptedText)

        guard let encryptedData = Data(
            base64Encoded: cleanedBase64,
            options: [.ignoreUnknownCharacters]
        ) else {
            throw AESDecryptError.invalidBase64
        }

        do {
            let aes = try AES(
                key: keyBytes,
                blockMode: ECB(),
                padding: .pkcs7
            )

            let decryptedBytes = try aes.decrypt(
                Array(encryptedData)
            )

            guard let result = String(
                bytes: decryptedBytes,
                encoding: .utf8
            ) else { 
                throw AESDecryptError.invalidUTF8
            }

            return result
        } catch let error as AESDecryptError {
            throw error
        } catch {
            throw AESDecryptError.decryptFailed(error)
        }
    }

    // MARK: - RSA（对应 Flutter CryptoUtil.RsaEncrypt / RsaDecrypt）

    static func rsaEncrypt(
        _ input: String,
        publicKeyPem: String,
        encoding: String = "OAEP"
    ) throws -> String {
        guard let plain = input.data(using: .utf8) else {
            throw CryptoUtilError.rsaFailed("")
        }
        guard let key = rsaPublicKey(from: publicKeyPem) else {
            throw CryptoUtilError.rsaFailed("")
        }

        let maxPlain = rsaMaxEncryptBlockSize(key: key, encoding: encoding)
        guard maxPlain > 0 else {
            throw CryptoUtilError.rsaFailed("")
        }

        if plain.count <= maxPlain {
            return try rsaEncryptData(plain, key: key, encoding: encoding)
                .base64EncodedString()
        }

        var cipher = Data()
        var offset = 0
        while offset < plain.count {
            let end = min(offset + maxPlain, plain.count)
            cipher.append(
                try rsaEncryptData(plain.subdata(in: offset..<end), key: key, encoding: encoding)
            )
            offset = end
        }
        return cipher.base64EncodedString()
    }

    static func rsaDecrypt(
        _ input: String,
        privateKeyPem: String,
        encoding: String = "OAEP"
    ) throws -> String {
        guard let cipher = Data(
            base64Encoded: normalizeBase64(input),
            options: [.ignoreUnknownCharacters]
        ) else {
            throw CryptoUtilError.rsaFailed("")
        }
        guard let key = rsaPrivateKey(from: privateKeyPem) else {
            throw CryptoUtilError.rsaFailed("")
        }

        let plain = try rsaDecryptData(cipher, key: key, encoding: encoding)
        guard let text = String(data: plain, encoding: .utf8) else {
            throw CryptoUtilError.rsaFailed("")
        }
        return text
    }

    static func rsaDecryptChunked(
        _ input: String,
        privateKeyPem: String,
        encoding: String = "PKCS1"
    ) throws -> String {
        guard let cipher = Data(
            base64Encoded: normalizeBase64(input),
            options: [.ignoreUnknownCharacters]
        ) else {
            throw CryptoUtilError.rsaFailed("")
        }
        guard let key = rsaPrivateKey(from: privateKeyPem) else {
            throw CryptoUtilError.rsaFailed("")
        }

        let blockSize = SecKeyGetBlockSize(key)
        guard blockSize > 0 else {
            throw CryptoUtilError.rsaFailed("")
        }

        if cipher.count <= blockSize {
            let plain = try rsaDecryptData(cipher, key: key, encoding: encoding)
            guard let text = String(data: plain, encoding: .utf8) else {
                throw CryptoUtilError.rsaFailed("")
            }
            return text
        }

        var output = Data()
        var offset = 0
        while offset < cipher.count {
            let end = min(offset + blockSize, cipher.count)
            let chunk = cipher.subdata(in: offset..<end)
            output.append(try rsaDecryptData(chunk, key: key, encoding: encoding))
            offset = end
        }

        guard let text = String(data: output, encoding: .utf8) else {
            throw CryptoUtilError.rsaFailed("")
        }
        return text
    }

    private static func rsaEncryptData(
        _ plain: Data,
        key: SecKey,
        encoding: String
    ) throws -> Data {
        let algorithm = rsaAlgorithm(encoding)
        var error: Unmanaged<CFError>?
        guard let cipher = SecKeyCreateEncryptedData(
            key,
            algorithm,
            plain as CFData,
            &error
        ) as Data? else {
            let detail = error?.takeRetainedValue().localizedDescription ?? "unknown"
            throw CryptoUtilError.rsaFailed("")
        }
        return cipher
    }

    private static func rsaDecryptData(
        _ cipher: Data,
        key: SecKey,
        encoding: String
    ) throws -> Data {
        let algorithm = rsaAlgorithm(encoding)
        var error: Unmanaged<CFError>?
        guard let plain = SecKeyCreateDecryptedData(
            key,
            algorithm,
            cipher as CFData,
            &error
        ) as Data? else {
            let detail = error?.takeRetainedValue().localizedDescription ?? "unknown"
            throw CryptoUtilError.rsaFailed("")
        }
        return plain
    }

    private static func rsaMaxEncryptBlockSize(key: SecKey, encoding: String) -> Int {
        let keySize = SecKeyGetBlockSize(key)
        switch encoding.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() {
        case "PKCS1":
            return keySize - 11
        case "OAEP-SHA256", "OAEP_SHA256":
            return keySize - 66 // 2 + 2 * SHA-256 digest length
        case "OAEP", "OAEP-SHA1", "OAEP_SHA1":
            return keySize - 42 // 2 + 2 * SHA-1 digest length
        default:
            return keySize - 42
        }
    }

    private static func rsaAlgorithm(_ encoding: String) -> SecKeyAlgorithm {
        switch encoding.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() {
        case "PKCS1":
            return .rsaEncryptionPKCS1
        case "OAEP", "OAEP-SHA1", "OAEP_SHA1":
            return .rsaEncryptionOAEPSHA1
        case "OAEP-SHA256", "OAEP_SHA256":
            return .rsaEncryptionOAEPSHA256
        default:
            return .rsaEncryptionOAEPSHA1
        }
    }

    private static func rsaPublicKey(from pem: String) -> SecKey? {
        guard let data = rsaKeyData(from: pem) else { return nil }
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic
        ]
        var error: Unmanaged<CFError>?
        return SecKeyCreateWithData(data as CFData, attributes as CFDictionary, &error)
    }

    private static func rsaPrivateKey(from pem: String) -> SecKey? {
        guard let data = rsaKeyData(from: pem) else { return nil }
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate
        ]
        var error: Unmanaged<CFError>?
        if let key = SecKeyCreateWithData(data as CFData, attributes as CFDictionary, &error) {
            return key
        }
        // iOS/macOS SecKey 对部分 PKCS#8（BEGIN PRIVATE KEY）导入失败，需剥成 PKCS#1 再试
        error?.release()
        guard let pkcs1 = pkcs1PrivateKeyDER(fromPKCS8: data) else { return nil }
        var retryError: Unmanaged<CFError>?
        return SecKeyCreateWithData(pkcs1 as CFData, attributes as CFDictionary, &retryError)
    }

    private static func pkcs1PrivateKeyDER(fromPKCS8 data: Data) -> Data? {
        var offset = 0

        func readLength() -> Int? {
            guard offset < data.count else { return nil }
            let first = Int(data[offset])
            offset += 1
            if first & 0x80 == 0 { return first }
            let count = first & 0x7f
            guard count > 0, count <= 4, offset + count <= data.count else { return nil }
            var length = 0
            for _ in 0..<count {
                length = (length << 8) | Int(data[offset])
                offset += 1
            }
            return length
        }

        func expectTag(_ tag: UInt8) -> Int? {
            guard offset < data.count, data[offset] == tag else { return nil }
            offset += 1
            return readLength()
        }

        guard let _ = expectTag(0x30) else { return nil } // PrivateKeyInfo
        guard let versionLen = expectTag(0x02), offset + versionLen <= data.count else { return nil }
        offset += versionLen
        guard let algorithmLen = expectTag(0x30), offset + algorithmLen <= data.count else { return nil }
        offset += algorithmLen
        guard let keyLen = expectTag(0x04), offset + keyLen <= data.count else { return nil }
        let pkcs1 = data.subdata(in: offset..<(offset + keyLen))
        guard pkcs1.first == 0x30 else { return nil }
        return pkcs1
    }

    private static func rsaKeyData(from pem: String) -> Data? {
        var text = pem
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----BEGIN RSA PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----BEGIN PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----BEGIN RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")

        if let data = Data(base64Encoded: text, options: [.ignoreUnknownCharacters]) {
            return data
        }
        // 部分规则可能直接传裸 Base64 / 已清洗过的 PEM body
        return Data(base64Encoded: normalizeBase64(text), options: [.ignoreUnknownCharacters])
    }

    private static func normalizeBase64(
        _ input: String
    ) -> String {
        var text = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")

        /*
         部分接口可能把纯文本包装成 JSON 字符串：

         "SGVsbG8..."

         需要去除首尾双引号。
         */
        if text.count >= 2,
           text.first == "\"",
           text.last == "\"" {
            text.removeFirst()
            text.removeLast()
        }

        /*
         如果响应经过 JSON 字符串转义，恢复常见字符。
         */
        text = text
            .replacingOccurrences(of: "\\/", with: "/")
            .replacingOccurrences(of: "\\n", with: "")
            .replacingOccurrences(of: "\\r", with: "")

        return text
    }
}
