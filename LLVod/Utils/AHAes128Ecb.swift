//
//  AHAes128Ecb.swift
//  LLVod
//
//  对应 Flutter Aes128EcbDecrypt：
//  - 新数据 GCM1. 前缀：AES-256-GCM（SHA256(16 位密码) 当密钥，12 字节 nonce + 16 字节 tag）
//  - 旧数据：16 位密码按位置公式插在 Base64 密文里，抠出来后取 SHA256 hex 前 16 位，AES-128-ECB + PKCS7
//

import CryptoKit
import Foundation

enum AHAes128EcbError: LocalizedError {
    case payloadTooShort(Int)
    case keyLength(Int)
    case invalidBase64
    case invalidUTF8

    var errorDescription: String? {
        switch self {
        case .payloadTooShort, .keyLength, .invalidBase64, .invalidUTF8:
            return ""
        }
    }
}

enum AHAes128Ecb {

    private static let gcmPrefix = "GCM1."
    private static let keyCount = 16
    private static let gcmNonceSize = 12
    private static let gcmTagSize = 16

    static func decrypt(_ encrypted: String) throws -> String {
        let text = encrypted.trimmingCharacters(in: .whitespacesAndNewlines)

        if text.hasPrefix(gcmPrefix) {
            return try decryptGCM(text)
        }

        return try decryptECB(text)
    }

    private static func decryptGCM(_ encrypted: String) throws -> String {
        let encoded = String(encrypted.dropFirst(gcmPrefix.count))
        guard let payload = Data(
            base64Encoded: encoded,
            options: [.ignoreUnknownCharacters]
        ) else {
            throw AHAes128EcbError.invalidBase64
        }

        let minimum = keyCount + gcmNonceSize + gcmTagSize
        guard payload.count >= minimum else {
            throw AHAes128EcbError.payloadTooShort(payload.count)
        }

        let keyBytes = payload.prefix(keyCount)
        let nonceStart = keyCount
        let nonceEnd = keyCount + gcmNonceSize
        let nonceData = payload.subdata(in: nonceStart..<nonceEnd)
        let rest = payload.subdata(in: nonceEnd..<payload.count)
        let ciphertext = rest.dropLast(gcmTagSize)
        let tag = rest.suffix(gcmTagSize)

        let key = SymmetricKey(data: SHA256.hash(data: keyBytes))
        let nonce = try AES.GCM.Nonce(data: nonceData)
        let box = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag)
        let plain = try AES.GCM.open(box, using: key)

        guard let text = String(data: plain, encoding: .utf8) else {
            throw AHAes128EcbError.invalidUTF8
        }
        return text
    }

    private static func decryptECB(_ text: String) throws -> String {
        guard text.count > keyCount else {
            throw AHAes128EcbError.payloadTooShort(text.count)
        }

        let password = extractKey(text)
        guard password.count == keyCount else {
            throw AHAes128EcbError.keyLength(password.count)
        }

        return try CryptoUtil.aesDecryptECB(
            removeKey(text),
            key: aesKey(from: password)
        )
    }

    static func extractKey(_ encrypted: String) -> String {
        var chars = Array(encrypted)
        var picked: [Int: Character] = [:]

        for position in stride(from: keyCount, through: 1, by: -1) {
            let index = insertIndex(position: position, lengthBeforeInsert: chars.count - 1)
            picked[position] = chars[index]
            chars.remove(at: index)
        }

        return String((1...keyCount).compactMap { picked[$0] })
    }

    static func removeKey(_ encrypted: String) -> String {
        var chars = Array(encrypted)

        for position in stride(from: keyCount, through: 1, by: -1) {
            chars.remove(at: insertIndex(position: position, lengthBeforeInsert: chars.count - 1))
        }

        return String(chars)
    }

    private static func insertIndex(position: Int, lengthBeforeInsert length: Int) -> Int {
        max(0, length - (3 * (1 << (position - 1)) + 1))
    }

    private static func aesKey(from password: String) -> String {
        String(CryptoUtil.sha256Hex(password).prefix(16))
    }
}
