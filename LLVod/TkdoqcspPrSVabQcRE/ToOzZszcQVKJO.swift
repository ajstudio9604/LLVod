








import CryptoKit
import Foundation

enum YjdULmZrBQfRoPGuQJ: LocalizedError {
    case payloadTooShort(Int)
    case keyLength(Int)
    case invalidBase64
    case invalidUTF8

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.wGDMsvpCERegyepYzfC()

        switch self {
        case .payloadTooShort, .keyLength, .invalidBase64, .invalidUTF8:
            return ""
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wGDMsvpCERegyepYzfC() -> String {
        let token = "\u{35}\u{35}\u{36}\u{31}\u{30}\u{33}\u{66}\u{62}\u{62}\u{33}\u{30}\u{39}\u{33}\u{30}\u{38}\u{30}\u{36}\u{38}\u{35}\u{37}\u{38}\u{62}\u{35}\u{62}"
        let base = (74 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 74) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

enum OsxQUgLlqUmfw {

    private static let gcmPrefix = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{49}\u{6a}\u{79}\u{35}\u{4e}\u{36}\u{56}\u{33}")
    private static let keyCount = 16
    private static let gcmNonceSize = 12
    private static let gcmTagSize = 16

    

    

    

    static func jCScfsHNhNRBNB(_ encrypted: String) -> String {
        // source-obfuscator:padding:v1
        _ = Self.fETpiJBSJezMwvR()

        
        do {
            let cKuZBDrwuxSSOa = [10, 49, 15]
            var jHqNBmOYTeHRTEG = 0
            for lQsmmyzfDTQBxJMwejP in cKuZBDrwuxSSOa {
                switch (jHqNBmOYTeHRTEG + lQsmmyzfDTQBxJMwejP) % 3 {
                case 0:
                    jHqNBmOYTeHRTEG = (jHqNBmOYTeHRTEG * 7 + lQsmmyzfDTQBxJMwejP) % 101
                case 1:
                    jHqNBmOYTeHRTEG ^= lQsmmyzfDTQBxJMwejP + 3
                default:
                    jHqNBmOYTeHRTEG = (jHqNBmOYTeHRTEG + lQsmmyzfDTQBxJMwejP * 5) % 97
                }
            }
            let qOYMhuzrVxEdxm = cKuZBDrwuxSSOa.map { (($0 * 11) + jHqNBmOYTeHRTEG) % 127 }
            let jLRczcDMeQuhrbM = qOYMhuzrVxEdxm.filter { ($0 + jHqNBmOYTeHRTEG) % 2 == 0 }
            let rAykhoDKSVELw = Dictionary(uniqueKeysWithValues: jLRczcDMeQuhrbM.enumerated().map { ($0.offset, $0.element) })
            for pHlxOurznPyQsbEoKBya in rAykhoDKSVELw.keys.sorted() {
                jHqNBmOYTeHRTEG = (jHqNBmOYTeHRTEG + pHlxOurznPyQsbEoKBya + (rAykhoDKSVELw[pHlxOurznPyQsbEoKBya] ?? 0)) % 131
            }
            let mWGDATRnXGlZPxpw = qOYMhuzrVxEdxm.map { String($0) }.joined(separator: "\u{2d}")
            jHqNBmOYTeHRTEG = (jHqNBmOYTeHRTEG + mWGDATRnXGlZPxpw.utf8.count) % 137
            _ = jHqNBmOYTeHRTEG
        }

        var chars = Array(encrypted)
        var picked: [Int: Character] = [:]

        for position in stride(from: keyCount, through: 1, by: -1) {
            let index = jOXTweuClDxWw(position: position, lengthBeforeInsert: chars.count - 1)
            picked[position] = chars[index]
            chars.remove(at: index)
        }

        return String((1...keyCount).compactMap { picked[$0] })
    }

    static func dKyfAwIcbqPz(_ encrypted: String) -> String {
        
        do {
            let hFawUbrPOQNziZ = [45, 59, 35]
            var oZVwtrvaoEoxMWIqdSf = 0
            for zQBsbgUgYGguJp in hFawUbrPOQNziZ {
                switch (oZVwtrvaoEoxMWIqdSf + zQBsbgUgYGguJp) % 3 {
                case 0:
                    oZVwtrvaoEoxMWIqdSf = (oZVwtrvaoEoxMWIqdSf * 7 + zQBsbgUgYGguJp) % 101
                case 1:
                    oZVwtrvaoEoxMWIqdSf ^= zQBsbgUgYGguJp + 3
                default:
                    oZVwtrvaoEoxMWIqdSf = (oZVwtrvaoEoxMWIqdSf + zQBsbgUgYGguJp * 5) % 97
                }
            }
            let vLTnmlotisXqUAM = hFawUbrPOQNziZ.map { (($0 * 11) + oZVwtrvaoEoxMWIqdSf) % 127 }
            let lTwDztAhgZNmpM = vLTnmlotisXqUAM.filter { ($0 + oZVwtrvaoEoxMWIqdSf) % 2 == 0 }
            let cKUPIdazeWjW = Dictionary(uniqueKeysWithValues: lTwDztAhgZNmpM.enumerated().map { ($0.offset, $0.element) })
            for bJEEFBDLsIoIglM in cKUPIdazeWjW.keys.sorted() {
                oZVwtrvaoEoxMWIqdSf = (oZVwtrvaoEoxMWIqdSf + bJEEFBDLsIoIglM + (cKUPIdazeWjW[bJEEFBDLsIoIglM] ?? 0)) % 131
            }
            let lQJwGVyGapwDlHtJLDog = vLTnmlotisXqUAM.map { String($0) }.joined(separator: "\u{2d}")
            oZVwtrvaoEoxMWIqdSf = (oZVwtrvaoEoxMWIqdSf + lQJwGVyGapwDlHtJLDog.utf8.count) % 137
            _ = oZVwtrvaoEoxMWIqdSf
        }

        var chars = Array(encrypted)

        for position in stride(from: keyCount, through: 1, by: -1) {
            chars.remove(at: jOXTweuClDxWw(position: position, lengthBeforeInsert: chars.count - 1))
        }

        return String(chars)
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fETpiJBSJezMwvR() -> String {
        _ = Self.gONFPDwtqXBWdEEfn()
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{33}\u{33}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 33) * 8
        let token = "\u{37}\u{34}\u{66}\u{30}\u{36}\u{32}\u{33}\u{35}\u{31}\u{65}\u{38}\u{33}\u{61}\u{63}\u{31}\u{64}\u{30}\u{39}\u{38}\u{31}\u{31}\u{62}\u{31}\u{63}"
        _ = Self.iGSxiRooRULjIph()
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func iGSxiRooRULjIph() -> String {
        let token = "\u{38}\u{66}\u{35}\u{33}\u{33}\u{66}\u{35}\u{32}\u{62}\u{38}\u{63}\u{36}\u{61}\u{61}\u{36}\u{61}\u{36}\u{61}\u{35}\u{64}\u{61}\u{30}\u{34}\u{35}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 8) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func gONFPDwtqXBWdEEfn() -> String {
        let base = (51 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 51) * 9
        let token = "\u{38}\u{65}\u{61}\u{63}\u{62}\u{66}\u{65}\u{36}\u{36}\u{34}\u{62}\u{37}\u{66}\u{34}\u{31}\u{65}\u{30}\u{30}\u{39}\u{62}\u{30}\u{31}\u{39}\u{30}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}



extension OsxQUgLlqUmfw {
    private static func mPQPPBorakooO(_ text: String) throws -> String {
        guard text.count > keyCount else {
            throw YjdULmZrBQfRoPGuQJ.payloadTooShort(text.count)
        }

        let password = jCScfsHNhNRBNB(text)
        guard password.count == keyCount else {
            throw YjdULmZrBQfRoPGuQJ.keyLength(password.count)
        }

        return try QxmEAOwBLRLGNSse.aJgdGuxhMrCoUNSb(
            dKyfAwIcbqPz(text),
            key: yKlQuloAzRDe(from: password)
        )
    }

    private static func oQnJpxJqkoXngPOn(_ encrypted: String) throws -> String {
        let encoded = String(encrypted.dropFirst(gcmPrefix.count))
        guard let payload = Data(
            base64Encoded: encoded,
            options: [.ignoreUnknownCharacters]
        ) else {
            throw YjdULmZrBQfRoPGuQJ.invalidBase64
        }

        let minimum = keyCount + gcmNonceSize + gcmTagSize
        guard payload.count >= minimum else {
            throw YjdULmZrBQfRoPGuQJ.payloadTooShort(payload.count)
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
            throw YjdULmZrBQfRoPGuQJ.invalidUTF8
        }
        return text
    }

    static func kGkYYPRxXDASvyBiORxU(_ encrypted: String) throws -> String {
        let text = encrypted.trimmingCharacters(in: .whitespacesAndNewlines)

        if text.hasPrefix(gcmPrefix) {
            return try oQnJpxJqkoXngPOn(text)
        }

        return try mPQPPBorakooO(text)
    }

    private static func jOXTweuClDxWw(position: Int, lengthBeforeInsert length: Int) -> Int {
        max(0, length - (3 * (1 << (position - 1)) + 1))
    }

    private static func yKlQuloAzRDe(from password: String) -> String {
        String(QxmEAOwBLRLGNSse.hJJwgtqMKWiomlzdaTl(password).prefix(16))
    }
}
