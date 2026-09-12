






import Foundation
import CryptoSwift
import Security

enum ZkcOnefvWTYHHnPMTt: LocalizedError {
    case invalidBase64
    case invalidKeyLength(Int)
    case decryptFailed(Error)
    case invalidUTF8

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.nRwfKLNaVNfmXjtyssw()

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

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func nRwfKLNaVNfmXjtyssw() -> String {
        let token = "\u{31}\u{35}\u{65}\u{30}\u{31}\u{34}\u{61}\u{37}\u{34}\u{63}\u{62}\u{30}\u{65}\u{64}\u{31}\u{65}\u{61}\u{63}\u{38}\u{30}\u{32}\u{36}\u{33}\u{38}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 55, "\u{65}\u{61}\u{73}\u{74}": 61, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 330]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 55) * 6
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

enum WmPQLPRIFpbedzrjIwaX: LocalizedError {
    case hmacSha1Failed(Error)
    case hmacSha256Failed(Error)
    case aesEncryptFailed(Error)
    case rsaFailed(String)

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.uRapLdBQPdwAtzMDgT()

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

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uRapLdBQPdwAtzMDgT() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 56, "\u{65}\u{61}\u{73}\u{74}": 64, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 448]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 56) * 8
        let token = "\u{39}\u{63}\u{66}\u{64}\u{35}\u{37}\u{33}\u{36}\u{37}\u{62}\u{31}\u{33}\u{37}\u{36}\u{65}\u{38}\u{34}\u{30}\u{37}\u{31}\u{32}\u{61}\u{36}\u{35}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

enum QxmEAOwBLRLGNSse {

    static func rJgTDHvLkUgCfQeHfK(_ input: String) -> String {
        // source-obfuscator:padding:v1
        _ = Self.dHxjzngnCyPPHkpt()

        return Array(input.utf8).md5().toHexString()
    }

    

    

    

    

    

    static func sIdWSDfAneSvMSNMES(
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
            throw WmPQLPRIFpbedzrjIwaX.hmacSha256Failed(error)
        }
    }

    

    

    static func kJCfbNhESXInUxZi(_ input: String) -> String {
        Data(input.utf8).base64EncodedString()
    }

    static func nIkfeWlJWSivkEkhXe(_ input: String) -> String {
        
        do {
            let gKHUldrjgvAhvPjlhgXW = [44, 54, 45]
            var gSGfduWMCOXaof = 0
            for aXptETZOXELZXoj in gKHUldrjgvAhvPjlhgXW {
                switch (gSGfduWMCOXaof + aXptETZOXELZXoj) % 3 {
                case 0:
                    gSGfduWMCOXaof = (gSGfduWMCOXaof * 7 + aXptETZOXELZXoj) % 101
                case 1:
                    gSGfduWMCOXaof ^= aXptETZOXELZXoj + 3
                default:
                    gSGfduWMCOXaof = (gSGfduWMCOXaof + aXptETZOXELZXoj * 5) % 97
                }
            }
            let bTJfwsDsBMjSuy = gKHUldrjgvAhvPjlhgXW.map { (($0 * 11) + gSGfduWMCOXaof) % 127 }
            let iPxNRZQkUxkbylaJJQ = bTJfwsDsBMjSuy.filter { ($0 + gSGfduWMCOXaof) % 2 == 0 }
            let sRtdcMkuBUGYPBBtL = Dictionary(uniqueKeysWithValues: iPxNRZQkUxkbylaJJQ.enumerated().map { ($0.offset, $0.element) })
            for nHmQldnARgIqqIT in sRtdcMkuBUGYPBBtL.keys.sorted() {
                gSGfduWMCOXaof = (gSGfduWMCOXaof + nHmQldnARgIqqIT + (sRtdcMkuBUGYPBBtL[nHmQldnARgIqqIT] ?? 0)) % 131
            }
            let gQXOdihxDWjYnj = bTJfwsDsBMjSuy.map { String($0) }.joined(separator: "\u{2d}")
            gSGfduWMCOXaof = (gSGfduWMCOXaof + gQXOdihxDWjYnj.utf8.count) % 137
            _ = gSGfduWMCOXaof
        }

        guard let data = Data(
            base64Encoded: lZnhiKhoUUEaBtkudYiZ(input),
            options: [.ignoreUnknownCharacters]
        ) else {
            return ""
        }
        return String(data: data, encoding: .utf8) ?? ""
    }

    static func zSYbXNkaGCgssuKadGw(
        _ encryptedText: String,
        key: String,
        iv: String = "",
        mode: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{63}\u{70}\u{43}\u{58}\u{4e}\u{44}\u{74}\u{70}"),
        padding: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{49}\u{36}\u{58}\u{53}\u{76}\u{4b}\u{46}\u{70}")
    ) throws -> String {
        let keyBytes = Array(key.utf8)

        guard [16, 24, 32].contains(keyBytes.count) else {
            throw ZkcOnefvWTYHHnPMTt.invalidKeyLength(keyBytes.count)
        }

        guard let encryptedData = Data(
            base64Encoded: lZnhiKhoUUEaBtkudYiZ(encryptedText),
            options: [.ignoreUnknownCharacters]
        ) else {
            throw ZkcOnefvWTYHHnPMTt.invalidBase64
        }

        do {
            let blockMode: BlockMode = mode.uppercased() == "\u{45}\u{43}\u{42}"
                ? ECB()
                : CBC(iv: Array(iv.utf8))

            let aes = try AES(
                key: keyBytes,
                blockMode: blockMode,
                padding: padding.uppercased() == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{49}\u{36}\u{58}\u{53}\u{76}\u{4b}\u{46}\u{70}") ? .pkcs7 : .noPadding
            )

            let decrypted = try aes.decrypt(Array(encryptedData))

            guard let result = String(bytes: decrypted, encoding: .utf8) else {
                throw ZkcOnefvWTYHHnPMTt.invalidUTF8
            }
            return result
        } catch let error as ZkcOnefvWTYHHnPMTt {
            throw error
        } catch {
            throw ZkcOnefvWTYHHnPMTt.decryptFailed(error)
        }
    }

    

    

    

    

    

    private static func yVuLTRgnjgUsJ(
        _ plain: Data,
        key: SecKey,
        encoding: String
    ) throws -> Data {
        let algorithm = rXgDJayaITIHyKxwQk(encoding)
        var error: Unmanaged<CFError>?
        guard let cipher = SecKeyCreateEncryptedData(
            key,
            algorithm,
            plain as CFData,
            &error
        ) as Data? else {
            let detail = error?.takeRetainedValue().localizedDescription ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{38}\u{43}\u{66}\u{36}\u{38}\u{70}\u{58}\u{76}")
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        return cipher
    }

    private static func qPSDZUQRnptIBqrDDEG(
        _ cipher: Data,
        key: SecKey,
        encoding: String
    ) throws -> Data {
        let algorithm = rXgDJayaITIHyKxwQk(encoding)
        var error: Unmanaged<CFError>?
        guard let plain = SecKeyCreateDecryptedData(
            key,
            algorithm,
            cipher as CFData,
            &error
        ) as Data? else {
            let detail = error?.takeRetainedValue().localizedDescription ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{38}\u{43}\u{66}\u{36}\u{38}\u{70}\u{58}\u{76}")
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        return plain
    }

    private static func nSbvSPlmMFZgFQYtQ(key: SecKey, encoding: String) -> Int {
        
        do {
            let sCCEGhJOfUPdrAYSyOgM = [8, 52, 43]
            var lBNjljCgZBCabc = 0
            for jOUpeFMmfJVm in sCCEGhJOfUPdrAYSyOgM {
                switch (lBNjljCgZBCabc + jOUpeFMmfJVm) % 3 {
                case 0:
                    lBNjljCgZBCabc = (lBNjljCgZBCabc * 7 + jOUpeFMmfJVm) % 101
                case 1:
                    lBNjljCgZBCabc ^= jOUpeFMmfJVm + 3
                default:
                    lBNjljCgZBCabc = (lBNjljCgZBCabc + jOUpeFMmfJVm * 5) % 97
                }
            }
            let nQyVyfBozbGysnSQqvBm = sCCEGhJOfUPdrAYSyOgM.map { (($0 * 11) + lBNjljCgZBCabc) % 127 }
            let bAhzgcwhPkOxl = nQyVyfBozbGysnSQqvBm.filter { ($0 + lBNjljCgZBCabc) % 2 == 0 }
            let oNbriiNfQCZwNJQ = Dictionary(uniqueKeysWithValues: bAhzgcwhPkOxl.enumerated().map { ($0.offset, $0.element) })
            for bEHaSNcGNJZp in oNbriiNfQCZwNJQ.keys.sorted() {
                lBNjljCgZBCabc = (lBNjljCgZBCabc + bEHaSNcGNJZp + (oNbriiNfQCZwNJQ[bEHaSNcGNJZp] ?? 0)) % 131
            }
            let vCfBVVrjJTQgOPQjYFwZ = nQyVyfBozbGysnSQqvBm.map { String($0) }.joined(separator: "\u{2d}")
            lBNjljCgZBCabc = (lBNjljCgZBCabc + vCfBVVrjJTQgOPQjYFwZ.utf8.count) % 137
            _ = lBNjljCgZBCabc
        }

        let keySize = SecKeyGetBlockSize(key)
        switch encoding.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() {
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{46}\u{71}\u{46}\u{42}\u{37}\u{70}\u{33}\u{5a}"):
            return keySize - 11
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{55}\u{30}\u{57}\u{46}\u{66}\u{6d}\u{34}\u{4b}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{4c}\u{57}\u{4f}\u{70}\u{7a}\u{54}\u{48}"):
            return keySize - 66 
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{48}\u{34}\u{69}\u{4a}\u{4d}\u{76}\u{6e}\u{67}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{31}\u{61}\u{64}\u{59}\u{4d}\u{57}\u{7a}\u{43}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{63}\u{6c}\u{52}\u{6e}\u{39}\u{50}\u{63}\u{44}"):
            return keySize - 42 
        default:
            return keySize - 42
        }
    }

    

    private static func dRIHhESKfhKfDJx(from pem: String) -> SecKey? {
        
        do {
            let oYVlowxJeCzODkzynwD = [23, 15, 15]
            var bTjGmfYhhcIoFM = 0
            for bUETYTmueEpgvdpeplbM in oYVlowxJeCzODkzynwD {
                switch (bTjGmfYhhcIoFM + bUETYTmueEpgvdpeplbM) % 3 {
                case 0:
                    bTjGmfYhhcIoFM = (bTjGmfYhhcIoFM * 7 + bUETYTmueEpgvdpeplbM) % 101
                case 1:
                    bTjGmfYhhcIoFM ^= bUETYTmueEpgvdpeplbM + 3
                default:
                    bTjGmfYhhcIoFM = (bTjGmfYhhcIoFM + bUETYTmueEpgvdpeplbM * 5) % 97
                }
            }
            let bVSkBtXVNGWDB = oYVlowxJeCzODkzynwD.map { (($0 * 11) + bTjGmfYhhcIoFM) % 127 }
            let wMwzbeyuMrJODGOs = bVSkBtXVNGWDB.filter { ($0 + bTjGmfYhhcIoFM) % 2 == 0 }
            let rDCUjhMUaeegyk = Dictionary(uniqueKeysWithValues: wMwzbeyuMrJODGOs.enumerated().map { ($0.offset, $0.element) })
            for zAWgpmHXieOcexNDFTg in rDCUjhMUaeegyk.keys.sorted() {
                bTjGmfYhhcIoFM = (bTjGmfYhhcIoFM + zAWgpmHXieOcexNDFTg + (rDCUjhMUaeegyk[zAWgpmHXieOcexNDFTg] ?? 0)) % 131
            }
            let lGrKNyrZeVRUmfPuEx = bVSkBtXVNGWDB.map { String($0) }.joined(separator: "\u{2d}")
            bTjGmfYhhcIoFM = (bTjGmfYhhcIoFM + lGrKNyrZeVRUmfPuEx.utf8.count) % 137
            _ = bTjGmfYhhcIoFM
        }

        guard let data = hRZozkHldrirIsRbUFEo(from: pem) else { return nil }
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic
        ]
        var error: Unmanaged<CFError>?
        return SecKeyCreateWithData(data as CFData, attributes as CFDictionary, &error)
    }

    private static func fTBdBluvzrEaosR(from pem: String) -> SecKey? {
        
        do {
            let sEqlqNwvVHpxuhUTaw = [42, 59, 22]
            var hDcMGncGCSfAbbMLElS = 0
            for bPUCfVQGABeV in sEqlqNwvVHpxuhUTaw {
                switch (hDcMGncGCSfAbbMLElS + bPUCfVQGABeV) % 3 {
                case 0:
                    hDcMGncGCSfAbbMLElS = (hDcMGncGCSfAbbMLElS * 7 + bPUCfVQGABeV) % 101
                case 1:
                    hDcMGncGCSfAbbMLElS ^= bPUCfVQGABeV + 3
                default:
                    hDcMGncGCSfAbbMLElS = (hDcMGncGCSfAbbMLElS + bPUCfVQGABeV * 5) % 97
                }
            }
            let pAIOycxzpOAFFYHWjsvm = sEqlqNwvVHpxuhUTaw.map { (($0 * 11) + hDcMGncGCSfAbbMLElS) % 127 }
            let mBRNlEsxljiUncVU = pAIOycxzpOAFFYHWjsvm.filter { ($0 + hDcMGncGCSfAbbMLElS) % 2 == 0 }
            let fTwBXfuvocmzmweA = Dictionary(uniqueKeysWithValues: mBRNlEsxljiUncVU.enumerated().map { ($0.offset, $0.element) })
            for nJnzKPqLJEei in fTwBXfuvocmzmweA.keys.sorted() {
                hDcMGncGCSfAbbMLElS = (hDcMGncGCSfAbbMLElS + nJnzKPqLJEei + (fTwBXfuvocmzmweA[nJnzKPqLJEei] ?? 0)) % 131
            }
            let gAVOeKThxLQcxahjc = pAIOycxzpOAFFYHWjsvm.map { String($0) }.joined(separator: "\u{2d}")
            hDcMGncGCSfAbbMLElS = (hDcMGncGCSfAbbMLElS + gAVOeKThxLQcxahjc.utf8.count) % 137
            _ = hDcMGncGCSfAbbMLElS
        }

        guard let data = hRZozkHldrirIsRbUFEo(from: pem) else { return nil }
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate
        ]
        var error: Unmanaged<CFError>?
        if let key = SecKeyCreateWithData(data as CFData, attributes as CFDictionary, &error) {
            return key
        }
        
        
        do {
            let hTUymJerOdEMiRb = [26, 36, 66]
            let mTbqzBlumfXOqGkTEu = (hTUymJerOdEMiRb.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch mTbqzBlumfXOqGkTEu {
            case 0:
                error?.release()
            case 1:
                error?.release()
            case 2:
                error?.release()
            default:
                error?.release()
            }
        }
        guard let pkcs1 = nPCLoVwgbTRJAdOLuOb(fromPKCS8: data) else { return nil }
        var retryError: Unmanaged<CFError>?
        return SecKeyCreateWithData(pkcs1 as CFData, attributes as CFDictionary, &retryError)
    }

    

    private static func hRZozkHldrirIsRbUFEo(from pem: String) -> Data? {
        
        do {
            let gOqCHZDTgpzfXLHhl = [15, 29, 30]
            var gAGdhMtzgHyC = 0
            for vSKugtBRUrmXscUC in gOqCHZDTgpzfXLHhl {
                switch (gAGdhMtzgHyC + vSKugtBRUrmXscUC) % 3 {
                case 0:
                    gAGdhMtzgHyC = (gAGdhMtzgHyC * 7 + vSKugtBRUrmXscUC) % 101
                case 1:
                    gAGdhMtzgHyC ^= vSKugtBRUrmXscUC + 3
                default:
                    gAGdhMtzgHyC = (gAGdhMtzgHyC + vSKugtBRUrmXscUC * 5) % 97
                }
            }
            let gBYKPKJFMQPJJQ = gOqCHZDTgpzfXLHhl.map { (($0 * 11) + gAGdhMtzgHyC) % 127 }
            let bKgCymtzBOjyHRRvi = gBYKPKJFMQPJJQ.filter { ($0 + gAGdhMtzgHyC) % 2 == 0 }
            let xMLTmEsrdqkSX = Dictionary(uniqueKeysWithValues: bKgCymtzBOjyHRRvi.enumerated().map { ($0.offset, $0.element) })
            for dBRFSpYFvUvpro in xMLTmEsrdqkSX.keys.sorted() {
                gAGdhMtzgHyC = (gAGdhMtzgHyC + dBRFSpYFvUvpro + (xMLTmEsrdqkSX[dBRFSpYFvUvpro] ?? 0)) % 131
            }
            let pDPchAaglHWmKMdNzJR = gBYKPKJFMQPJJQ.map { String($0) }.joined(separator: "\u{2d}")
            gAGdhMtzgHyC = (gAGdhMtzgHyC + pDPchAaglHWmKMdNzJR.utf8.count) % 137
            _ = gAGdhMtzgHyC
        }

        var text = pem
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{33}\u{4d}\u{73}\u{6d}\u{39}\u{37}\u{62}\u{6a}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{61}\u{6e}\u{47}\u{33}\u{50}\u{4f}\u{48}\u{71}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{4a}\u{75}\u{7a}\u{65}\u{30}\u{61}\u{6f}\u{53}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{37}\u{49}\u{38}\u{64}\u{73}\u{58}\u{38}\u{4e}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{6e}\u{70}\u{4a}\u{68}\u{63}\u{54}\u{75}\u{4b}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{77}\u{62}\u{6d}\u{75}\u{53}\u{58}\u{65}\u{4e}\u{70}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{6a}\u{59}\u{46}\u{49}\u{47}\u{43}\u{64}\u{52}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{54}\u{69}\u{43}\u{55}\u{52}\u{63}\u{35}\u{52}"), with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")

        if let data = Data(base64Encoded: text, options: [.ignoreUnknownCharacters]) {
            return data
        }
        
        return Data(base64Encoded: lZnhiKhoUUEaBtkudYiZ(text), options: [.ignoreUnknownCharacters])
    }

    private static func lZnhiKhoUUEaBtkudYiZ(
        _ input: String
    ) -> String {
        
        do {
            let pQrWKxMOCIrxGfskNkOu = [18, 22, 66]
            var rLuBrviansyKsIvHKy = 0
            for ySxhyvIEdFvEQYm in pQrWKxMOCIrxGfskNkOu {
                switch (rLuBrviansyKsIvHKy + ySxhyvIEdFvEQYm) % 3 {
                case 0:
                    rLuBrviansyKsIvHKy = (rLuBrviansyKsIvHKy * 7 + ySxhyvIEdFvEQYm) % 101
                case 1:
                    rLuBrviansyKsIvHKy ^= ySxhyvIEdFvEQYm + 3
                default:
                    rLuBrviansyKsIvHKy = (rLuBrviansyKsIvHKy + ySxhyvIEdFvEQYm * 5) % 97
                }
            }
            let uRfWSvcTVcYXEbLw = pQrWKxMOCIrxGfskNkOu.map { (($0 * 11) + rLuBrviansyKsIvHKy) % 127 }
            let cYDZdlTFIRNmH = uRfWSvcTVcYXEbLw.filter { ($0 + rLuBrviansyKsIvHKy) % 2 == 0 }
            let dELUOfGnJgLRVRlofKn = Dictionary(uniqueKeysWithValues: cYDZdlTFIRNmH.enumerated().map { ($0.offset, $0.element) })
            for jBahxDPdKbCrDPAqVe in dELUOfGnJgLRVRlofKn.keys.sorted() {
                rLuBrviansyKsIvHKy = (rLuBrviansyKsIvHKy + jBahxDPdKbCrDPAqVe + (dELUOfGnJgLRVRlofKn[jBahxDPdKbCrDPAqVe] ?? 0)) % 131
            }
            let lXxByokVqRVRpUPQQ = uRfWSvcTVcYXEbLw.map { String($0) }.joined(separator: "\u{2d}")
            rLuBrviansyKsIvHKy = (rLuBrviansyKsIvHKy + lXxByokVqRVRpUPQQ.utf8.count) % 137
            _ = rLuBrviansyKsIvHKy
        }

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
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{6c}\u{71}\u{52}\u{41}\u{34}\u{6b}\u{6f}\u{51}"), with: "\u{2f}")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{52}\u{67}\u{54}\u{39}\u{4c}\u{54}\u{4d}\u{50}"), with: "")
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{68}\u{67}\u{30}\u{6d}\u{4f}\u{66}\u{39}\u{54}"), with: "")

        return text
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dHxjzngnCyPPHkpt() -> String {
        _ = Self.gUFgKMXyJresF()
        _ = Self.cGfzQlYyMFpj()
        _ = Self.aNcjYTuaNoxpxYAiY()
        _ = Self.rZvXARtpXEcQTQF()
        _ = Self.kNNDZpplSFUFC()
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{35}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 59) * 7
        let token = "\u{63}\u{33}\u{65}\u{35}\u{34}\u{36}\u{30}\u{63}\u{35}\u{65}\u{35}\u{63}\u{62}\u{37}\u{38}\u{62}\u{38}\u{63}\u{37}\u{38}\u{39}\u{32}\u{64}\u{39}"
        _ = Self.gVDoNHTVKCptnRwHsR()
        _ = Self.mJvzQOrdFsumriFa()
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func aNcjYTuaNoxpxYAiY() -> String {
        let base = (94 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 94) * 3
        let token = "\u{30}\u{31}\u{61}\u{37}\u{39}\u{39}\u{38}\u{65}\u{61}\u{62}\u{35}\u{63}\u{63}\u{39}\u{37}\u{61}\u{61}\u{64}\u{32}\u{66}\u{31}\u{30}\u{36}\u{38}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
    @inline(never)
    private nonisolated static func gVDoNHTVKCptnRwHsR() -> String {
        let values = [24, 30, 144, 41]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 24) * 6
        let token = "\u{31}\u{30}\u{64}\u{35}\u{66}\u{66}\u{65}\u{63}\u{65}\u{36}\u{35}\u{63}\u{34}\u{30}\u{30}\u{64}\u{31}\u{39}\u{30}\u{35}\u{39}\u{65}\u{61}\u{32}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func gUFgKMXyJresF() -> String {
        let token = "\u{39}\u{30}\u{62}\u{61}\u{35}\u{33}\u{33}\u{35}\u{37}\u{38}\u{61}\u{35}\u{31}\u{37}\u{66}\u{30}\u{37}\u{37}\u{34}\u{63}\u{66}\u{35}\u{36}\u{65}"
        let base = (86 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 86) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func kNNDZpplSFUFC() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 6, "\u{65}\u{61}\u{73}\u{74}": 9, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 18]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 6) * 3
        let token = "\u{33}\u{38}\u{64}\u{62}\u{65}\u{37}\u{35}\u{63}\u{66}\u{62}\u{61}\u{36}\u{61}\u{32}\u{62}\u{62}\u{65}\u{63}\u{63}\u{65}\u{32}\u{64}\u{35}\u{66}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
    @inline(never)
    private nonisolated static func rZvXARtpXEcQTQF() -> String {
        let source = "\u{65}\u{63}\u{66}\u{61}\u{66}\u{39}\u{66}\u{39}\u{31}\u{65}\u{63}\u{61}\u{34}\u{32}\u{39}\u{32}\u{39}\u{32}\u{34}\u{31}\u{38}\u{36}\u{37}\u{36}\u{2d}\u{33}\u{33}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 33) * 8
        let token = "\u{65}\u{63}\u{66}\u{61}\u{66}\u{39}\u{66}\u{39}\u{31}\u{65}\u{63}\u{61}\u{34}\u{32}\u{39}\u{32}\u{39}\u{32}\u{34}\u{31}\u{38}\u{36}\u{37}\u{36}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
    @inline(never)
    private nonisolated static func mJvzQOrdFsumriFa() -> String {
        let token = "\u{39}\u{65}\u{33}\u{39}\u{66}\u{35}\u{35}\u{37}\u{66}\u{39}\u{37}\u{65}\u{66}\u{30}\u{61}\u{39}\u{63}\u{61}\u{66}\u{30}\u{65}\u{32}\u{33}\u{37}"
        let values = [13, 17, 52, 30]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 13) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func cGfzQlYyMFpj() -> String {
        let token = "\u{33}\u{34}\u{38}\u{31}\u{35}\u{31}\u{39}\u{64}\u{39}\u{64}\u{63}\u{62}\u{65}\u{37}\u{38}\u{37}\u{38}\u{36}\u{33}\u{37}\u{64}\u{39}\u{32}\u{31}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{35}\u{36}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 56) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension QxmEAOwBLRLGNSse {
    private static func rXgDJayaITIHyKxwQk(_ encoding: String) -> SecKeyAlgorithm {
        switch encoding.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() {
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{46}\u{71}\u{46}\u{42}\u{37}\u{70}\u{33}\u{5a}"):
            return .rsaEncryptionPKCS1
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{48}\u{34}\u{69}\u{4a}\u{4d}\u{76}\u{6e}\u{67}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{31}\u{61}\u{64}\u{59}\u{4d}\u{57}\u{7a}\u{43}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{63}\u{6c}\u{52}\u{6e}\u{39}\u{50}\u{63}\u{44}"):
            return .rsaEncryptionOAEPSHA1
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{55}\u{30}\u{57}\u{46}\u{66}\u{6d}\u{34}\u{4b}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{4c}\u{57}\u{4f}\u{70}\u{7a}\u{54}\u{48}"):
            return .rsaEncryptionOAEPSHA256
        default:
            return .rsaEncryptionOAEPSHA1
        }
    }

    static func rSdJrKiqsbvbV(
        _ input: [UInt8],
        key: [UInt8],
        iv: [UInt8],
        mode: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{61}\u{48}\u{31}\u{6c}\u{71}\u{73}\u{4d}\u{45}"),
        padding: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{49}\u{36}\u{58}\u{53}\u{76}\u{4b}\u{46}\u{70}")
    ) throws -> String {

        guard [16, 24, 32].contains(key.count) else {
            throw ZkcOnefvWTYHHnPMTt.invalidKeyLength(key.count)
        }

        do {
            let blockMode: BlockMode = mode.uppercased() == "\u{45}\u{43}\u{42}" ? ECB() : CBC(iv: iv)
            let aes = try AES(
                key: key,
                blockMode: blockMode,
                padding: padding.uppercased() == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{49}\u{36}\u{58}\u{53}\u{76}\u{4b}\u{46}\u{70}") ? .pkcs7 : .noPadding
            )

            return Data(try aes.encrypt(input)).base64EncodedString()
        } catch {
            throw WmPQLPRIFpbedzrjIwaX.aesEncryptFailed(error)
        }
    }

    static func tZtTgJvctuciHkGmNi(
        _ input: String,
        privateKeyPem: String,
        encoding: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{46}\u{71}\u{46}\u{42}\u{37}\u{70}\u{33}\u{5a}")
    ) throws -> String {
        guard let cipher = Data(
            base64Encoded: lZnhiKhoUUEaBtkudYiZ(input),
            options: [.ignoreUnknownCharacters]
        ) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        guard let key = fTBdBluvzrEaosR(from: privateKeyPem) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }

        let blockSize = SecKeyGetBlockSize(key)
        guard blockSize > 0 else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }

        if cipher.count <= blockSize {
            let plain = try qPSDZUQRnptIBqrDDEG(cipher, key: key, encoding: encoding)
            guard let text = String(data: plain, encoding: .utf8) else {
                throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
            }
            return text
        }

        var output = Data()
        var offset = 0
        while offset < cipher.count {
            let end = min(offset + blockSize, cipher.count)
            let chunk = cipher.subdata(in: offset..<end)
            output.append(try qPSDZUQRnptIBqrDDEG(chunk, key: key, encoding: encoding))
            offset = end
        }

        guard let text = String(data: output, encoding: .utf8) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        return text
    }

    static func yIlQYAonEKZxzuQytLBM(_ input: [UInt8]) -> [UInt8] {
        input.sha256()
    }

    static func hJJwgtqMKWiomlzdaTl(_ input: String) -> String {
        Array(input.utf8).sha256().toHexString()
    }

    static func uGAZDSEpeirjNUePPZKv(
        _ input: String,
        key: String,
        iv: String = "",
        mode: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{63}\u{70}\u{43}\u{58}\u{4e}\u{44}\u{74}\u{70}"),
        padding: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{49}\u{36}\u{58}\u{53}\u{76}\u{4b}\u{46}\u{70}")
    ) throws -> String {
        try rSdJrKiqsbvbV(
            Array(input.utf8),
            key: Array(key.utf8),
            iv: Array(iv.utf8),
            mode: mode,
            padding: padding
        )
    }

    static func yIlQYAonEKZxzuQytLBM(_ input: String) -> [UInt8] {
        Array(input.utf8).sha256()
    }

    static func oGIWvvvfdhBliJGHfm(
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
                .map { String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{32}\u{63}\u{41}\u{54}\u{48}\u{68}\u{75}\u{4d}"), $0) }
                .joined()
        } catch {
            throw WmPQLPRIFpbedzrjIwaX.hmacSha1Failed(error)
        }
    }

    static func iXrjUlwFZfPlir(
        _ input: String,
        privateKeyPem: String,
        encoding: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{48}\u{34}\u{69}\u{4a}\u{4d}\u{76}\u{6e}\u{67}")
    ) throws -> String {
        guard let cipher = Data(
            base64Encoded: lZnhiKhoUUEaBtkudYiZ(input),
            options: [.ignoreUnknownCharacters]
        ) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        guard let key = fTBdBluvzrEaosR(from: privateKeyPem) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }

        let plain = try qPSDZUQRnptIBqrDDEG(cipher, key: key, encoding: encoding)
        guard let text = String(data: plain, encoding: .utf8) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        return text
    }

    static func bTsshHXXcmunyor(_ input: String) -> String {
        Array(input.utf8).sha1().toHexString()
    }

    static func lIWvHHaPzHVWmz(
        _ input: String,
        publicKeyPem: String,
        encoding: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{48}\u{34}\u{69}\u{4a}\u{4d}\u{76}\u{6e}\u{67}")
    ) throws -> String {
        guard let plain = input.data(using: .utf8) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }
        guard let key = dRIHhESKfhKfDJx(from: publicKeyPem) else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }

        let maxPlain = nSbvSPlmMFZgFQYtQ(key: key, encoding: encoding)
        guard maxPlain > 0 else {
            throw WmPQLPRIFpbedzrjIwaX.rsaFailed("")
        }

        if plain.count <= maxPlain {
            return try yVuLTRgnjgUsJ(plain, key: key, encoding: encoding)
                .base64EncodedString()
        }

        var cipher = Data()
        var offset = 0
        while offset < plain.count {
            let end = min(offset + maxPlain, plain.count)
            cipher.append(
                try yVuLTRgnjgUsJ(plain.subdata(in: offset..<end), key: key, encoding: encoding)
            )
            offset = end
        }
        return cipher.base64EncodedString()
    }

    static func aJgdGuxhMrCoUNSb(
        _ encryptedText: String,
        key: String
    ) throws -> String {

        let keyBytes = Array(key.utf8)

        guard [16, 24, 32].contains(keyBytes.count) else {
            throw ZkcOnefvWTYHHnPMTt.invalidKeyLength(keyBytes.count)
        }

        let cleanedBase64 = lZnhiKhoUUEaBtkudYiZ(encryptedText)

        guard let encryptedData = Data(
            base64Encoded: cleanedBase64,
            options: [.ignoreUnknownCharacters]
        ) else {
            throw ZkcOnefvWTYHHnPMTt.invalidBase64
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
                throw ZkcOnefvWTYHHnPMTt.invalidUTF8
            }

            return result
        } catch let error as ZkcOnefvWTYHHnPMTt {
            throw error
        } catch {
            throw ZkcOnefvWTYHHnPMTt.decryptFailed(error)
        }
    }

    private static func nPCLoVwgbTRJAdOLuOb(fromPKCS8 data: Data) -> Data? {
        var offset = 0

        func fPGySxqeitLq() -> Int? {
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

        func wYqUJkqKDQmEhmg(_ tag: UInt8) -> Int? {
            guard offset < data.count, data[offset] == tag else { return nil }
            offset += 1
            return fPGySxqeitLq()
        }

        guard let _ = wYqUJkqKDQmEhmg(0x30) else { return nil } 
        guard let versionLen = wYqUJkqKDQmEhmg(0x02), offset + versionLen <= data.count else { return nil }
        offset += versionLen
        guard let algorithmLen = wYqUJkqKDQmEhmg(0x30), offset + algorithmLen <= data.count else { return nil }
        offset += algorithmLen
        guard let keyLen = wYqUJkqKDQmEhmg(0x04), offset + keyLen <= data.count else { return nil }
        let pkcs1 = data.subdata(in: offset..<(offset + keyLen))
        guard pkcs1.first == 0x30 else { return nil }
        return pkcs1
    }
}
