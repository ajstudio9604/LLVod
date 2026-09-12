






import Foundation

final class RpOmwPsWgtwXT {

    static let shared = RpOmwPsWgtwXT()

    static let unlockDuration: TimeInterval = 24 * 60 * 60
    private static let unlockUntilKey = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{57}\u{43}\u{42}\u{61}\u{72}\u{6c}\u{47}\u{79}")

    private let advertising: any TADAdvertisingService
    private var waiting = false
    private var completion: ((Bool) -> Void)?

    init(advertising: any TADAdvertisingService = JwdeMDCMJuagGrOyBXy.shared) {
        // source-obfuscator:padding:v1
        _ = Self.yHdtKRqGCVRPa()

        self.advertising = advertising
    }

    var isUnlocked: Bool {
        Date().timeIntervalSince1970 < UserDefaults.standard.double(forKey: Self.unlockUntilKey)
    }

    func aHaqUoFUkuNODvav(_ completion: @escaping (Bool) -> Void) {
        
        do {
            let gWkLitWdgQcVIAc = [44, 51, 51]
            var zLZNhMjwGKMPO = 0
            for mOVVgulHtdqQThLbf in gWkLitWdgQcVIAc {
                switch (zLZNhMjwGKMPO + mOVVgulHtdqQThLbf) % 3 {
                case 0:
                    zLZNhMjwGKMPO = (zLZNhMjwGKMPO * 7 + mOVVgulHtdqQThLbf) % 101
                case 1:
                    zLZNhMjwGKMPO ^= mOVVgulHtdqQThLbf + 3
                default:
                    zLZNhMjwGKMPO = (zLZNhMjwGKMPO + mOVVgulHtdqQThLbf * 5) % 97
                }
            }
            let kJHLzURjdMsMCkfTwX = gWkLitWdgQcVIAc.map { (($0 * 11) + zLZNhMjwGKMPO) % 127 }
            let mWPoKKYDQUnHkL = kJHLzURjdMsMCkfTwX.filter { ($0 + zLZNhMjwGKMPO) % 2 == 0 }
            let uQcQGkIiCPIKcPISojR = Dictionary(uniqueKeysWithValues: mWPoKKYDQUnHkL.enumerated().map { ($0.offset, $0.element) })
            for wQDgsBFmislMTQTAneAt in uQcQGkIiCPIKcPISojR.keys.sorted() {
                zLZNhMjwGKMPO = (zLZNhMjwGKMPO + wQDgsBFmislMTQTAneAt + (uQcQGkIiCPIKcPISojR[wQDgsBFmislMTQTAneAt] ?? 0)) % 131
            }
            let iOzLZfYwJBbmQtavrz = kJHLzURjdMsMCkfTwX.map { String($0) }.joined(separator: "\u{2d}")
            zLZNhMjwGKMPO = (zLZNhMjwGKMPO + iOzLZfYwJBbmQtavrz.utf8.count) % 137
            _ = zLZNhMjwGKMPO
        }

        
        switch (isUnlocked) {
        case true: do {
            completion(true)
            return}
        case false:
            break
        }
        guard !waiting else { return }
        waiting = true
        self.completion = completion
        advertising.presentRewardedVideo(placementID: AxQkIqFofIHnj.rewardPlacementID) { [weak self] type in
            DispatchQueue.main.async {
                self?.mGPUkuoejekPv(type)
            }
        }
    }

    private func mGPUkuoejekPv(_ type: BndqBgFZaslilqbS) {
        
        do {
            let cZImvTIokmuxLrdngmPL = [19, 50, 77]
            var wHHPWotkcvRFF = 0
            for xMjxqyLULIxKxcDtFLS in cZImvTIokmuxLrdngmPL {
                switch (wHHPWotkcvRFF + xMjxqyLULIxKxcDtFLS) % 3 {
                case 0:
                    wHHPWotkcvRFF = (wHHPWotkcvRFF * 7 + xMjxqyLULIxKxcDtFLS) % 101
                case 1:
                    wHHPWotkcvRFF ^= xMjxqyLULIxKxcDtFLS + 3
                default:
                    wHHPWotkcvRFF = (wHHPWotkcvRFF + xMjxqyLULIxKxcDtFLS * 5) % 97
                }
            }
            let pIUjXAHtObvBk = cZImvTIokmuxLrdngmPL.map { (($0 * 11) + wHHPWotkcvRFF) % 127 }
            let xZOvBClWkhnFQ = pIUjXAHtObvBk.filter { ($0 + wHHPWotkcvRFF) % 2 == 0 }
            let fUXbUodtswUPE = Dictionary(uniqueKeysWithValues: xZOvBClWkhnFQ.enumerated().map { ($0.offset, $0.element) })
            for hAhicVFekPPJG in fUXbUodtswUPE.keys.sorted() {
                wHHPWotkcvRFF = (wHHPWotkcvRFF + hAhicVFekPPJG + (fUXbUodtswUPE[hAhicVFekPPJG] ?? 0)) % 131
            }
            let rQHDlHNHVYqUZSFI = pIUjXAHtObvBk.map { String($0) }.joined(separator: "\u{2d}")
            wHHPWotkcvRFF = (wHHPWotkcvRFF + rQHDlHNHVYqUZSFI.utf8.count) % 137
            _ = wHHPWotkcvRFF
        }

        guard waiting else { return }

        switch type {
        case .success:
            let until = Date().timeIntervalSince1970 + Self.unlockDuration
            UserDefaults.standard.set(until, forKey: Self.unlockUntilKey)
            fCBnTVRkGITlqrSgIKS(granted: true)
        case .loadFail, .didClose:
            fCBnTVRkGITlqrSgIKS(granted: false)
        }
    }

    private func fCBnTVRkGITlqrSgIKS(granted: Bool) {
        
        do {
            let rPlGczFDGmJiXRZoh = [37, 19, 23]
            var mOtfyjcAnGemizkI = 0
            for qZZIdqymuKOYauVdUUve in rPlGczFDGmJiXRZoh {
                switch (mOtfyjcAnGemizkI + qZZIdqymuKOYauVdUUve) % 3 {
                case 0:
                    mOtfyjcAnGemizkI = (mOtfyjcAnGemizkI * 7 + qZZIdqymuKOYauVdUUve) % 101
                case 1:
                    mOtfyjcAnGemizkI ^= qZZIdqymuKOYauVdUUve + 3
                default:
                    mOtfyjcAnGemizkI = (mOtfyjcAnGemizkI + qZZIdqymuKOYauVdUUve * 5) % 97
                }
            }
            let iWqPXuIoADeOKrtNXay = rPlGczFDGmJiXRZoh.map { (($0 * 11) + mOtfyjcAnGemizkI) % 127 }
            let fDOqtiVGnaRlwijzsz = iWqPXuIoADeOKrtNXay.filter { ($0 + mOtfyjcAnGemizkI) % 2 == 0 }
            let dYHvMsdsOhIkGTLaDiW = Dictionary(uniqueKeysWithValues: fDOqtiVGnaRlwijzsz.enumerated().map { ($0.offset, $0.element) })
            for aRVoTqpQPRqBSUgitl in dYHvMsdsOhIkGTLaDiW.keys.sorted() {
                mOtfyjcAnGemizkI = (mOtfyjcAnGemizkI + aRVoTqpQPRqBSUgitl + (dYHvMsdsOhIkGTLaDiW[aRVoTqpQPRqBSUgitl] ?? 0)) % 131
            }
            let jQkFOLqhASAL = iWqPXuIoADeOKrtNXay.map { String($0) }.joined(separator: "\u{2d}")
            mOtfyjcAnGemizkI = (mOtfyjcAnGemizkI + jQkFOLqhASAL.utf8.count) % 137
            _ = mOtfyjcAnGemizkI
        }

        waiting = false
        let callback = completion
        completion = nil
        callback?(granted)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yHdtKRqGCVRPa() -> String {
        let source = "\u{64}\u{36}\u{30}\u{39}\u{34}\u{61}\u{61}\u{66}\u{64}\u{38}\u{61}\u{35}\u{35}\u{35}\u{35}\u{33}\u{64}\u{63}\u{61}\u{63}\u{37}\u{35}\u{36}\u{63}\u{2d}\u{36}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 66) * 9
        let token = "\u{64}\u{36}\u{30}\u{39}\u{34}\u{61}\u{61}\u{66}\u{64}\u{38}\u{61}\u{35}\u{35}\u{35}\u{35}\u{33}\u{64}\u{63}\u{61}\u{63}\u{37}\u{35}\u{36}\u{63}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}

