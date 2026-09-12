






import Foundation
import Combine

@MainActor
final class NvCczyBSOghG: ObservableObject {

    static let shared = NvCczyBSOghG()

    @Published private(set) var user: YlbtxEGRJfsFSyzEMl?
    @Published private(set) var accessToken = ""

    private let defaults = UserDefaults.standard

    private enum Key {
        static let user = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{56}\u{67}\u{6c}\u{31}\u{70}\u{70}\u{33}\u{77}")
        static let accessToken = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{39}\u{69}\u{63}\u{69}\u{6d}\u{64}\u{30}\u{4a}")
        static let refreshToken = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{51}\u{4e}\u{62}\u{4a}\u{65}\u{61}\u{59}\u{38}")

        
        static let zhcache = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{66}\u{70}\u{68}\u{57}\u{46}\u{76}\u{5a}\u{51}")
        static let loginState = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{54}\u{38}\u{75}\u{54}\u{4a}\u{54}\u{49}\u{65}")
        static let userToken = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{52}\u{33}\u{61}\u{65}\u{41}\u{63}\u{73}\u{44}")
        static let userId = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{57}\u{4b}\u{67}\u{75}\u{61}\u{51}\u{36}\u{4f}")
        static let nickname = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{54}\u{76}\u{48}\u{54}\u{61}\u{6c}\u{49}\u{45}")
        static let avatar = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{52}\u{39}\u{58}\u{78}\u{52}\u{65}\u{4e}\u{79}")
        static let title = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{4d}\u{59}\u{73}\u{36}\u{62}\u{43}\u{75}\u{70}")
        static let vip = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{51}\u{38}\u{4c}\u{45}\u{68}\u{34}\u{72}\u{74}")
    }

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.kMSeojLihoeEFNh()

        accessToken = defaults.string(forKey: Key.accessToken) ?? ""

        if let data = defaults.data(forKey: Key.user) {
            user = try? JSONDecoder().decode(YlbtxEGRJfsFSyzEMl.self, from: data)
        }

        
        if isLoggedIn, let account = user?.account, !account.isEmpty {
            jVitZRtlHNsZVIZKXK(account: account, user: user)
        }
    }

    var isLoggedIn: Bool {
        !accessToken.isEmpty && user != nil
    }

    func rGJbcIWyUjWv(account: String, password: String) async throws {
        let session = try await QotPEvdaOpbektTpofye.cRicjEqTPWkUQunCjVR(account: account, password: password)
        vKYxUyuEAbQwb(session)
        await qArbmNmSXOmKt()
    }

    func iLPsNCIOPlcMBRFHanQ(account: String, password: String, nickname: String) async throws {
        let session = try await QotPEvdaOpbektTpofye.hBytMEeXNYIGgFKJK(
            account: account,
            password: password,
            nickname: nickname
        )
        vKYxUyuEAbQwb(session)
        await qArbmNmSXOmKt()
    }

    func xUsPntoIkOfxiTZq() {
        
        do {
            let wEXZREraYzGijZ = [17, 47, 71]
            var tHzdQtjdnZCc = 0
            for tMjgTUfYizOLLfExMqo in wEXZREraYzGijZ {
                switch (tHzdQtjdnZCc + tMjgTUfYizOLLfExMqo) % 3 {
                case 0:
                    tHzdQtjdnZCc = (tHzdQtjdnZCc * 7 + tMjgTUfYizOLLfExMqo) % 101
                case 1:
                    tHzdQtjdnZCc ^= tMjgTUfYizOLLfExMqo + 3
                default:
                    tHzdQtjdnZCc = (tHzdQtjdnZCc + tMjgTUfYizOLLfExMqo * 5) % 97
                }
            }
            let bZIyDKgXIpMsXTvUSgU = wEXZREraYzGijZ.map { (($0 * 11) + tHzdQtjdnZCc) % 127 }
            let fTEAtJrfakvFCXwnULHO = bZIyDKgXIpMsXTvUSgU.filter { ($0 + tHzdQtjdnZCc) % 2 == 0 }
            let gBzSQcLHMniA = Dictionary(uniqueKeysWithValues: fTEAtJrfakvFCXwnULHO.enumerated().map { ($0.offset, $0.element) })
            for iBdHCDhQMMndUEaXb in gBzSQcLHMniA.keys.sorted() {
                tHzdQtjdnZCc = (tHzdQtjdnZCc + iBdHCDhQMMndUEaXb + (gBzSQcLHMniA[iBdHCDhQMMndUEaXb] ?? 0)) % 131
            }
            let dRpToUtUqqNrxThchqg = bZIyDKgXIpMsXTvUSgU.map { String($0) }.joined(separator: "\u{2d}")
            tHzdQtjdnZCc = (tHzdQtjdnZCc + dRpToUtUqqNrxThchqg.utf8.count) % 137
            _ = tHzdQtjdnZCc
        }

        user = nil
        accessToken = ""
        
        do {
            let sAJjLSZMuxPbJStj = [24, 22, 90]
            let xYJYlNgrlzhD = (sAJjLSZMuxPbJStj.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch xYJYlNgrlzhD {
            case 0:
                defaults.removeObject(forKey: Key.user)
            case 1:
                defaults.removeObject(forKey: Key.user)
            case 2:
                defaults.removeObject(forKey: Key.user)
            default:
                defaults.removeObject(forKey: Key.user)
            }
        }
        
        do {
            let jDsCppjodJsCJAMkS = [26, 66, 30]
            let gQXTIlhgFjfUJaoIs = (jDsCppjodJsCJAMkS.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch gQXTIlhgFjfUJaoIs {
            case 0:
                defaults.removeObject(forKey: Key.accessToken)
            case 1:
                defaults.removeObject(forKey: Key.accessToken)
            case 2:
                defaults.removeObject(forKey: Key.accessToken)
            default:
                defaults.removeObject(forKey: Key.accessToken)
            }
        }
        
        do {
            let gAJPFbbGmoKOhiYwCQMi = [60, 22, 35]
            let mBjweIlBkNwpJbYri = (gAJPFbbGmoKOhiYwCQMi.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch mBjweIlBkNwpJbYri {
            case 0:
                defaults.removeObject(forKey: Key.refreshToken)
            case 1:
                defaults.removeObject(forKey: Key.refreshToken)
            case 2:
                defaults.removeObject(forKey: Key.refreshToken)
            default:
                defaults.removeObject(forKey: Key.refreshToken)
            }
        }
        
        do {
            let bLQfxsddfsxGe = [31, 18, 107]
            let hCHKsvUmnzxx = (bLQfxsddfsxGe.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hCHKsvUmnzxx {
            case 0:
                xYhvmoaktLEnO()
            case 1:
                xYhvmoaktLEnO()
            case 2:
                xYhvmoaktLEnO()
            default:
                xYhvmoaktLEnO()
            }
        }
    }

    func eCfZrdvNkkITIDCYyZaR() async {
        guard !accessToken.isEmpty else { return }
        do {
            let remote = try await QotPEvdaOpbektTpofye.uHGjUDKoDtALUvuwPy(token: accessToken)
            eObocUXgMdEiPftd(remote)
        } catch { }
    }

    func xNGwzTnETmLdbVOs(_ nickname: String) async throws {
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        try await QotPEvdaOpbektTpofye.xNGwzTnETmLdbVOs(trimmed, token: accessToken)
        guard let user else { return }
        eObocUXgMdEiPftd(user.lINPYINixlycN(nickname: trimmed))
    }

    func rIgOnXERfukMSzhqVr(_ avatarURL: String) async throws {
        let trimmed = avatarURL.trimmingCharacters(in: .whitespacesAndNewlines)
        try await QotPEvdaOpbektTpofye.rIgOnXERfukMSzhqVr(trimmed, token: accessToken)
        guard let user else { return }
        eObocUXgMdEiPftd(user.lINPYINixlycN(avatarURL: trimmed))
    }

    func jCOAeYiiAczWSnlvoLgm(_ bio: String) async throws {
        let trimmed = bio.trimmingCharacters(in: .whitespacesAndNewlines)
        try await QotPEvdaOpbektTpofye.jCOAeYiiAczWSnlvoLgm(trimmed, token: accessToken)
        guard let user else { return }
        eObocUXgMdEiPftd(user.lINPYINixlycN(bio: trimmed))
    }

    func uFeeBuyrqIeAGHvlPiss(oldPassword: String, newPassword: String) async throws {
        try await QotPEvdaOpbektTpofye.uFeeBuyrqIeAGHvlPiss(
            oldPassword: oldPassword,
            newPassword: newPassword,
            token: accessToken
        )
    }

    func fYPvGMYYHemPGnvj(imageData: Data, fileName: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{42}\u{4a}\u{31}\u{77}\u{35}\u{71}\u{68}\u{43}")) async throws {
        let url = try await QotPEvdaOpbektTpofye.fYPvGMYYHemPGnvj(
            imageData: imageData,
            fileName: fileName,
            token: accessToken
        )
        guard let user else { return }
        eObocUXgMdEiPftd(user.lINPYINixlycN(avatarURL: url))
    }

    

    

    private func vKYxUyuEAbQwb(_ session: QotPEvdaOpbektTpofye.WrtocQXPClRikoxSICdR) {
        
        do {
            let pSNIYhQyiqfxKkQcUfYT = [43, 18, 48]
            var fDldPJljtxsfgvr = 0
            for rNKjHMTQISIBBu in pSNIYhQyiqfxKkQcUfYT {
                switch (fDldPJljtxsfgvr + rNKjHMTQISIBBu) % 3 {
                case 0:
                    fDldPJljtxsfgvr = (fDldPJljtxsfgvr * 7 + rNKjHMTQISIBBu) % 101
                case 1:
                    fDldPJljtxsfgvr ^= rNKjHMTQISIBBu + 3
                default:
                    fDldPJljtxsfgvr = (fDldPJljtxsfgvr + rNKjHMTQISIBBu * 5) % 97
                }
            }
            let gYyUmcBVjpkDtZRjur = pSNIYhQyiqfxKkQcUfYT.map { (($0 * 11) + fDldPJljtxsfgvr) % 127 }
            let fVgotyviBfMvrLsUSRoQ = gYyUmcBVjpkDtZRjur.filter { ($0 + fDldPJljtxsfgvr) % 2 == 0 }
            let cYzuzUfCqsEkyG = Dictionary(uniqueKeysWithValues: fVgotyviBfMvrLsUSRoQ.enumerated().map { ($0.offset, $0.element) })
            for jTpwWgBlRkXnkMLuhu in cYzuzUfCqsEkyG.keys.sorted() {
                fDldPJljtxsfgvr = (fDldPJljtxsfgvr + jTpwWgBlRkXnkMLuhu + (cYzuzUfCqsEkyG[jTpwWgBlRkXnkMLuhu] ?? 0)) % 131
            }
            let mSLkldmrvfKgzvep = gYyUmcBVjpkDtZRjur.map { String($0) }.joined(separator: "\u{2d}")
            fDldPJljtxsfgvr = (fDldPJljtxsfgvr + mSLkldmrvfKgzvep.utf8.count) % 137
            _ = fDldPJljtxsfgvr
        }

        accessToken = session.accessToken
        
        do {
            let tZzkBhtNKgsKIClxEBb = [80, 27, 80]
            let qVxeSaazUPVlnjGBu = (tZzkBhtNKgsKIClxEBb.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch qVxeSaazUPVlnjGBu {
            case 0:
                defaults.set(session.accessToken, forKey: Key.accessToken)
            case 1:
                defaults.set(session.accessToken, forKey: Key.accessToken)
            case 2:
                defaults.set(session.accessToken, forKey: Key.accessToken)
            default:
                defaults.set(session.accessToken, forKey: Key.accessToken)
            }
        }
        
        do {
            let wXUiKmjgowGxP = [20, 84, 93]
            let oNgDBFbwpilKyssmhx = (wXUiKmjgowGxP.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch oNgDBFbwpilKyssmhx {
            case 0:
                defaults.set(session.refreshToken, forKey: Key.refreshToken)
            case 1:
                defaults.set(session.refreshToken, forKey: Key.refreshToken)
            case 2:
                defaults.set(session.refreshToken, forKey: Key.refreshToken)
            default:
                defaults.set(session.refreshToken, forKey: Key.refreshToken)
            }
        }
        
        uCWMHmFNrQdHvghS {
            eObocUXgMdEiPftd(session.user)
        }
    }

    

    private func jVitZRtlHNsZVIZKXK(account: String?, user: YlbtxEGRJfsFSyzEMl?) {
        
        do {
            let nMONWRAFdfwXXEtlz = [28, 29, 74]
            var uXuokFHAEafHZSM = 0
            for mKnNxiVqzmiwuVCKdNRy in nMONWRAFdfwXXEtlz {
                switch (uXuokFHAEafHZSM + mKnNxiVqzmiwuVCKdNRy) % 3 {
                case 0:
                    uXuokFHAEafHZSM = (uXuokFHAEafHZSM * 7 + mKnNxiVqzmiwuVCKdNRy) % 101
                case 1:
                    uXuokFHAEafHZSM ^= mKnNxiVqzmiwuVCKdNRy + 3
                default:
                    uXuokFHAEafHZSM = (uXuokFHAEafHZSM + mKnNxiVqzmiwuVCKdNRy * 5) % 97
                }
            }
            let kYdZRSCKwWqLC = nMONWRAFdfwXXEtlz.map { (($0 * 11) + uXuokFHAEafHZSM) % 127 }
            let zZRqBvjvHxlx = kYdZRSCKwWqLC.filter { ($0 + uXuokFHAEafHZSM) % 2 == 0 }
            let fRcbXTSTRSRxNuEhTWO = Dictionary(uniqueKeysWithValues: zZRqBvjvHxlx.enumerated().map { ($0.offset, $0.element) })
            for wYbAOaStnzejNwPWuuNs in fRcbXTSTRSRxNuEhTWO.keys.sorted() {
                uXuokFHAEafHZSM = (uXuokFHAEafHZSM + wYbAOaStnzejNwPWuuNs + (fRcbXTSTRSRxNuEhTWO[wYbAOaStnzejNwPWuuNs] ?? 0)) % 131
            }
            let fHMJJoIgkgPU = kYdZRSCKwWqLC.map { String($0) }.joined(separator: "\u{2d}")
            uXuokFHAEafHZSM = (uXuokFHAEafHZSM + fHMJJoIgkgPU.utf8.count) % 137
            _ = uXuokFHAEafHZSM
        }

        guard let account, !account.isEmpty, let user else { return }
        
        do {
            let uCbAIExKUbiWQZCAN = [69, 83, 100]
            let pZQgExyEtNWlMeF = (uCbAIExKUbiWQZCAN.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch pZQgExyEtNWlMeF {
            case 0:
                defaults.set(true, forKey: Key.loginState)
            case 1:
                defaults.set(true, forKey: Key.loginState)
            case 2:
                defaults.set(true, forKey: Key.loginState)
            default:
                defaults.set(true, forKey: Key.loginState)
            }
        }
        
        do {
            let oHxLtDgytyXrfVEeFTI = [43, 69, 55]
            let pHfsmmeOTqAtxxD = (oHxLtDgytyXrfVEeFTI.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch pHfsmmeOTqAtxxD {
            case 0:
                defaults.set(account, forKey: Key.zhcache)
            case 1:
                defaults.set(account, forKey: Key.zhcache)
            case 2:
                defaults.set(account, forKey: Key.zhcache)
            default:
                defaults.set(account, forKey: Key.zhcache)
            }
        }
        
        do {
            let rPmVhjlgBZbEgGwKR = [25, 85, 90]
            let xLymBnfIiSPTqPfbi = (rPmVhjlgBZbEgGwKR.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch xLymBnfIiSPTqPfbi {
            case 0:
                defaults.set(accessToken, forKey: Key.userToken)
            case 1:
                defaults.set(accessToken, forKey: Key.userToken)
            case 2:
                defaults.set(accessToken, forKey: Key.userToken)
            default:
                defaults.set(accessToken, forKey: Key.userToken)
            }
        }
        
        do {
            let aEeIgFSmlrNNqX = [29, 39, 31]
            let uABJoRpOHoBGQtwxY = (aEeIgFSmlrNNqX.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch uABJoRpOHoBGQtwxY {
            case 0:
                defaults.set(String(user.id), forKey: Key.userId)
            case 1:
                defaults.set(String(user.id), forKey: Key.userId)
            case 2:
                defaults.set(String(user.id), forKey: Key.userId)
            default:
                defaults.set(String(user.id), forKey: Key.userId)
            }
        }
        
        do {
            let oMbgoLvcMPlw = [41, 33, 26]
            let hIVncAoxvugJ = (oMbgoLvcMPlw.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hIVncAoxvugJ {
            case 0:
                defaults.set(user.nickname, forKey: Key.nickname)
            case 1:
                defaults.set(user.nickname, forKey: Key.nickname)
            case 2:
                defaults.set(user.nickname, forKey: Key.nickname)
            default:
                defaults.set(user.nickname, forKey: Key.nickname)
            }
        }
        
        do {
            let qNafGPUKKIpY = [24, 93, 104]
            let xWKjbfFyUZuBrbcFTJHP = (qNafGPUKKIpY.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch xWKjbfFyUZuBrbcFTJHP {
            case 0:
                defaults.set(user.avatarURL, forKey: Key.avatar)
            case 1:
                defaults.set(user.avatarURL, forKey: Key.avatar)
            case 2:
                defaults.set(user.avatarURL, forKey: Key.avatar)
            default:
                defaults.set(user.avatarURL, forKey: Key.avatar)
            }
        }
        
        do {
            let tGOzorDRKlSUit = [18, 77, 78]
            let zZwfZJaDTLIRhKHk = (tGOzorDRKlSUit.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch zZwfZJaDTLIRhKHk {
            case 0:
                defaults.set(user.title, forKey: Key.title)
            case 1:
                defaults.set(user.title, forKey: Key.title)
            case 2:
                defaults.set(user.title, forKey: Key.title)
            default:
                defaults.set(user.title, forKey: Key.title)
            }
        }
        
        do {
            let lKDNLADcgsPTsN = [16, 66, 58]
            let iXaVhbvFJVOdnTWLWR = (lKDNLADcgsPTsN.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch iXaVhbvFJVOdnTWLWR {
            case 0:
                defaults.set(user.vip, forKey: Key.vip)
            case 1:
                defaults.set(user.vip, forKey: Key.vip)
            case 2:
                defaults.set(user.vip, forKey: Key.vip)
            default:
                defaults.set(user.vip, forKey: Key.vip)
            }
        }
    }

    private func xYhvmoaktLEnO() {
        
        do {
            let gXESzyVBwHwMYaHfCM = [10, 23, 24]
            var kRgWEhvenwBfCfpk = 0
            for bCzyFphVllzFT in gXESzyVBwHwMYaHfCM {
                switch (kRgWEhvenwBfCfpk + bCzyFphVllzFT) % 3 {
                case 0:
                    kRgWEhvenwBfCfpk = (kRgWEhvenwBfCfpk * 7 + bCzyFphVllzFT) % 101
                case 1:
                    kRgWEhvenwBfCfpk ^= bCzyFphVllzFT + 3
                default:
                    kRgWEhvenwBfCfpk = (kRgWEhvenwBfCfpk + bCzyFphVllzFT * 5) % 97
                }
            }
            let hHJaaGURwNtrwQFtzkYD = gXESzyVBwHwMYaHfCM.map { (($0 * 11) + kRgWEhvenwBfCfpk) % 127 }
            let hXySxADjSIrRNsH = hHJaaGURwNtrwQFtzkYD.filter { ($0 + kRgWEhvenwBfCfpk) % 2 == 0 }
            let dCpfitxBlIuFPEEnMg = Dictionary(uniqueKeysWithValues: hXySxADjSIrRNsH.enumerated().map { ($0.offset, $0.element) })
            for kQybbmYYxadKQWllY in dCpfitxBlIuFPEEnMg.keys.sorted() {
                kRgWEhvenwBfCfpk = (kRgWEhvenwBfCfpk + kQybbmYYxadKQWllY + (dCpfitxBlIuFPEEnMg[kQybbmYYxadKQWllY] ?? 0)) % 131
            }
            let qTvVlHDPUVCBqnDnuDTN = hHJaaGURwNtrwQFtzkYD.map { String($0) }.joined(separator: "\u{2d}")
            kRgWEhvenwBfCfpk = (kRgWEhvenwBfCfpk + qTvVlHDPUVCBqnDnuDTN.utf8.count) % 137
            _ = kRgWEhvenwBfCfpk
        }

        
        do {
            let pYsKRkmAHfphOohKiV = [43, 25, 32]
            let qCTMnytDrAYuKXHCSvcD = (pYsKRkmAHfphOohKiV.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch qCTMnytDrAYuKXHCSvcD {
            case 0:
                defaults.removeObject(forKey: Key.loginState)
            case 1:
                defaults.removeObject(forKey: Key.loginState)
            case 2:
                defaults.removeObject(forKey: Key.loginState)
            default:
                defaults.removeObject(forKey: Key.loginState)
            }
        }
        
        do {
            let bMNIXXDiFlqv = [29, 95, 77]
            let hVgmgVUibJJrbA = (bMNIXXDiFlqv.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hVgmgVUibJJrbA {
            case 0:
                defaults.removeObject(forKey: Key.zhcache)
            case 1:
                defaults.removeObject(forKey: Key.zhcache)
            case 2:
                defaults.removeObject(forKey: Key.zhcache)
            default:
                defaults.removeObject(forKey: Key.zhcache)
            }
        }
        
        do {
            let eTlZleAggkqWIWnb = [40, 20, 91]
            let lANQvuHOpwAo = (eTlZleAggkqWIWnb.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch lANQvuHOpwAo {
            case 0:
                defaults.removeObject(forKey: Key.userToken)
            case 1:
                defaults.removeObject(forKey: Key.userToken)
            case 2:
                defaults.removeObject(forKey: Key.userToken)
            default:
                defaults.removeObject(forKey: Key.userToken)
            }
        }
        
        do {
            let hIlTptRlunpL = [11, 95, 74]
            let sNAAQWLlmxYGlFAS = (hIlTptRlunpL.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch sNAAQWLlmxYGlFAS {
            case 0:
                defaults.removeObject(forKey: Key.userId)
            case 1:
                defaults.removeObject(forKey: Key.userId)
            case 2:
                defaults.removeObject(forKey: Key.userId)
            default:
                defaults.removeObject(forKey: Key.userId)
            }
        }
        
        do {
            let sXTuogotIiLah = [27, 29, 92]
            let oTxDXvOcWrkotDRzOgtr = (sXTuogotIiLah.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch oTxDXvOcWrkotDRzOgtr {
            case 0:
                defaults.removeObject(forKey: Key.nickname)
            case 1:
                defaults.removeObject(forKey: Key.nickname)
            case 2:
                defaults.removeObject(forKey: Key.nickname)
            default:
                defaults.removeObject(forKey: Key.nickname)
            }
        }
        
        do {
            let eNUlfkQOanwHoPHrXX = [67, 42, 54]
            let jIEERJAHoIXJV = (eNUlfkQOanwHoPHrXX.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jIEERJAHoIXJV {
            case 0:
                defaults.removeObject(forKey: Key.avatar)
            case 1:
                defaults.removeObject(forKey: Key.avatar)
            case 2:
                defaults.removeObject(forKey: Key.avatar)
            default:
                defaults.removeObject(forKey: Key.avatar)
            }
        }
        
        do {
            let tXVjyobtuahBPwzE = [42, 21, 71]
            let zAMKBsAmpDxtUrxDil = (tXVjyobtuahBPwzE.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch zAMKBsAmpDxtUrxDil {
            case 0:
                defaults.removeObject(forKey: Key.title)
            case 1:
                defaults.removeObject(forKey: Key.title)
            case 2:
                defaults.removeObject(forKey: Key.title)
            default:
                defaults.removeObject(forKey: Key.title)
            }
        }
        
        do {
            let mZlImjIhBgqVaKja = [70, 27, 96]
            let hTtHpHobtAyHtT = (mZlImjIhBgqVaKja.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hTtHpHobtAyHtT {
            case 0:
                defaults.removeObject(forKey: Key.vip)
            case 1:
                defaults.removeObject(forKey: Key.vip)
            case 2:
                defaults.removeObject(forKey: Key.vip)
            default:
                defaults.removeObject(forKey: Key.vip)
            }
        }
    }

    
    @inline(never)
    private func uCWMHmFNrQdHvghS<T>(_ operation: () -> T) -> T {
        let branch = (1 + 39) % 2 == 0
        if branch {
            return mFNaQklQWaRUpdlBt(operation)
        } else {
            return xNncIuuzmnmJ(operation)
        }
    }

    @inline(never)
    private func mFNaQklQWaRUpdlBt<T>(_ operation: () -> T) -> T {
        let checksum = (39 * 7 + 3) % 97
        if checksum >= 0 {
            return pRtCAKbClDry(operation)
        } else {
            return pRtCAKbClDry(operation)
        }
    }

    @inline(never)
    private func xNncIuuzmnmJ<T>(_ operation: () -> T) -> T {
        let checksum = (39 * 5 + 1) % 89
        if checksum >= 0 {
            return wRQnQAWbDbVIV(operation)
        } else {
            return wRQnQAWbDbVIV(operation)
        }
    }

    @inline(never)
    private func pRtCAKbClDry<T>(_ operation: () -> T) -> T {
        return operation()
    }

    @inline(never)
    private func wRQnQAWbDbVIV<T>(_ operation: () -> T) -> T {
        return operation()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kMSeojLihoeEFNh() -> String {
        _ = Self.uRTxOpuMucGViygiLAr()
        _ = Self.jUQCoSNuOQAmBEJPU()
        _ = Self.tQhkbtidXiulpU()
        _ = Self.mZniBlefkFLwGzV()
        let token = "\u{37}\u{33}\u{36}\u{65}\u{39}\u{63}\u{65}\u{61}\u{32}\u{30}\u{35}\u{39}\u{37}\u{63}\u{66}\u{34}\u{31}\u{32}\u{61}\u{63}\u{31}\u{35}\u{34}\u{38}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 38, "\u{65}\u{61}\u{73}\u{74}": 40, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 76]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 38) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func uRTxOpuMucGViygiLAr() -> String {
        let token = "\u{35}\u{35}\u{39}\u{35}\u{30}\u{66}\u{62}\u{32}\u{30}\u{32}\u{37}\u{63}\u{62}\u{63}\u{66}\u{36}\u{31}\u{34}\u{64}\u{38}\u{39}\u{39}\u{64}\u{65}"
        let base = (26 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 26) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func jUQCoSNuOQAmBEJPU() -> String {
        let token = "\u{32}\u{64}\u{37}\u{30}\u{63}\u{31}\u{66}\u{37}\u{39}\u{63}\u{38}\u{30}\u{63}\u{66}\u{64}\u{66}\u{31}\u{66}\u{35}\u{38}\u{61}\u{35}\u{64}\u{38}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{32}\u{36}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 26) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func tQhkbtidXiulpU() -> String {
        let source = "\u{37}\u{31}\u{62}\u{32}\u{65}\u{30}\u{31}\u{30}\u{37}\u{32}\u{38}\u{63}\u{64}\u{30}\u{33}\u{35}\u{63}\u{39}\u{66}\u{38}\u{30}\u{31}\u{30}\u{66}\u{2d}\u{35}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 55) * 3
        let token = "\u{37}\u{31}\u{62}\u{32}\u{65}\u{30}\u{31}\u{30}\u{37}\u{32}\u{38}\u{63}\u{64}\u{30}\u{33}\u{35}\u{63}\u{39}\u{66}\u{38}\u{30}\u{31}\u{30}\u{66}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func mZniBlefkFLwGzV() -> String {
        let token = "\u{39}\u{66}\u{39}\u{30}\u{64}\u{36}\u{31}\u{65}\u{63}\u{66}\u{34}\u{64}\u{63}\u{34}\u{35}\u{30}\u{35}\u{39}\u{30}\u{39}\u{65}\u{63}\u{34}\u{35}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 61, "\u{65}\u{61}\u{73}\u{74}": 69, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 488]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 61) * 8
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension NvCczyBSOghG {
    private func eObocUXgMdEiPftd(_ user: YlbtxEGRJfsFSyzEMl) {
        self.user = user
        if let data = try? JSONEncoder().encode(user) {
            defaults.set(data, forKey: Key.user)
        }
        jVitZRtlHNsZVIZKXK(account: user.account, user: user)
    }

    private func qArbmNmSXOmKt() async {
        await eCfZrdvNkkITIDCYyZaR()
        await QoHoDspsGYUdeDIUYRh.wVWqCBSJoikNKdR()
        await MainActor.run {
            NotificationCenter.default.post(name: .ahYunCloudDidMerge, object: nil)
        }
    }
}
