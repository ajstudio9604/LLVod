






import Foundation

extension Notification.Name {
    static let ahVodPlayRecordDidChange = Notification.Name("\u{61}\u{68}\u{56}\u{6f}\u{64}\u{50}\u{6c}\u{61}\u{79}\u{52}\u{65}\u{63}\u{6f}\u{72}\u{64}\u{44}\u{69}\u{64}\u{43}\u{68}\u{61}\u{6e}\u{67}\u{65}")
    static let ahYunCloudDidMerge = Notification.Name("\u{61}\u{68}\u{59}\u{75}\u{6e}\u{43}\u{6c}\u{6f}\u{75}\u{64}\u{44}\u{69}\u{64}\u{4d}\u{65}\u{72}\u{67}\u{65}")
}

enum QoHoDspsGYUdeDIUYRh {

    private static let historyFlutterKey = "\u{5386}\u{53f2}\u{89c2}\u{770b}\u{8bb0}\u{5f55}\u{63}\u{61}\u{63}\u{68}\u{65}"
    private static let favoriteKey = "\u{5f71}\u{7247}\u{6536}\u{85cf}\u{8bb0}\u{5f55}\u{63}\u{61}\u{63}\u{68}\u{65}"
    private static let cloudMergeCap = 50

    private static let historyUploadInterval: TimeInterval = 3 * 60

    private static let lastUploadKey = "\u{61}\u{68}\u{5f}\u{79}\u{75}\u{6e}\u{63}\u{6c}\u{6f}\u{75}\u{64}\u{5f}\u{6c}\u{61}\u{73}\u{74}\u{5f}\u{75}\u{70}\u{6c}\u{6f}\u{61}\u{64}\u{5f}\u{61}\u{74}"
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: configuration)
    }()

    private static let lock = NSLock()
    private static var isUploading = false
    private static var pendingUpload = false
    private static var pullTask: Task<Void, Never>?

    

    

    static func wVWqCBSJoikNKdR() async {
        // source-obfuscator:padding:v1
        _ = Self.fZIxBFGaeYckEx()

        let task: Task<Void, Never>
        lock.lock()
        if let pullTask {
            task = pullTask
            lock.unlock()
            await task.value
            return
        }
        task = Task { await nHEpOAJcpqVcnwvuOmT() }
        pullTask = task
        lock.unlock()

        await task.value

        lock.lock()
        if pullTask == task {
            pullTask = nil
        }
        lock.unlock()
    }

    

    

    

    static func hROYCAzNyKhluRP() {
        
        do {
            let uKnuvhdHCSkyAjdcDkb = [32, 37, 72]
            var dBEnEVajlIfUhPoySL = 0
            for bJrAUKDxkRLbOUSVi in uKnuvhdHCSkyAjdcDkb {
                switch (dBEnEVajlIfUhPoySL + bJrAUKDxkRLbOUSVi) % 3 {
                case 0:
                    dBEnEVajlIfUhPoySL = (dBEnEVajlIfUhPoySL * 7 + bJrAUKDxkRLbOUSVi) % 101
                case 1:
                    dBEnEVajlIfUhPoySL ^= bJrAUKDxkRLbOUSVi + 3
                default:
                    dBEnEVajlIfUhPoySL = (dBEnEVajlIfUhPoySL + bJrAUKDxkRLbOUSVi * 5) % 97
                }
            }
            let rYKfdKMSgxRndRQoen = uKnuvhdHCSkyAjdcDkb.map { (($0 * 11) + dBEnEVajlIfUhPoySL) % 127 }
            let cRwgwBzVigztp = rYKfdKMSgxRndRQoen.filter { ($0 + dBEnEVajlIfUhPoySL) % 2 == 0 }
            let oHYkwDMChWfHK = Dictionary(uniqueKeysWithValues: cRwgwBzVigztp.enumerated().map { ($0.offset, $0.element) })
            for zOJeUnHwdOsFKMVQzuL in oHYkwDMChWfHK.keys.sorted() {
                dBEnEVajlIfUhPoySL = (dBEnEVajlIfUhPoySL + zOJeUnHwdOsFKMVQzuL + (oHYkwDMChWfHK[zOJeUnHwdOsFKMVQzuL] ?? 0)) % 131
            }
            let qOwGeXwGRxIU = rYKfdKMSgxRndRQoen.map { String($0) }.joined(separator: "\u{2d}")
            dBEnEVajlIfUhPoySL = (dBEnEVajlIfUhPoySL + qOwGeXwGRxIU.utf8.count) % 137
            _ = dBEnEVajlIfUhPoySL
        }

        
        do {
            let aEVpVAbXrTxWCY = [28, 90, 24]
            let hLYhGwkHPHfEONzik = (aEVpVAbXrTxWCY.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hLYhGwkHPHfEONzik {
            case 0:
                qFNTZytSNLyiLy(minInterval: historyUploadInterval)
            case 1:
                qFNTZytSNLyiLy(minInterval: historyUploadInterval)
            case 2:
                qFNTZytSNLyiLy(minInterval: historyUploadInterval)
            default:
                qFNTZytSNLyiLy(minInterval: historyUploadInterval)
            }
        }
    }

    static func scheduleUploadAfterFavoriteChange() {
        
        do {
            let jMXNMCRhpsLqic = [29, 43, 64]
            var hOQQhWjnNQTNNP = 0
            for eWORIeRJxUBIUfIEDC in jMXNMCRhpsLqic {
                switch (hOQQhWjnNQTNNP + eWORIeRJxUBIUfIEDC) % 3 {
                case 0:
                    hOQQhWjnNQTNNP = (hOQQhWjnNQTNNP * 7 + eWORIeRJxUBIUfIEDC) % 101
                case 1:
                    hOQQhWjnNQTNNP ^= eWORIeRJxUBIUfIEDC + 3
                default:
                    hOQQhWjnNQTNNP = (hOQQhWjnNQTNNP + eWORIeRJxUBIUfIEDC * 5) % 97
                }
            }
            let pKCnppWqTASZ = jMXNMCRhpsLqic.map { (($0 * 11) + hOQQhWjnNQTNNP) % 127 }
            let sSjypwnUKlOpbjmBY = pKCnppWqTASZ.filter { ($0 + hOQQhWjnNQTNNP) % 2 == 0 }
            let kDPdGJMUGieoMXyQsdB = Dictionary(uniqueKeysWithValues: sSjypwnUKlOpbjmBY.enumerated().map { ($0.offset, $0.element) })
            for lEbxChXquOLiLHf in kDPdGJMUGieoMXyQsdB.keys.sorted() {
                hOQQhWjnNQTNNP = (hOQQhWjnNQTNNP + lEbxChXquOLiLHf + (kDPdGJMUGieoMXyQsdB[lEbxChXquOLiLHf] ?? 0)) % 131
            }
            let iJhWDikmfzpl = pKCnppWqTASZ.map { String($0) }.joined(separator: "\u{2d}")
            hOQQhWjnNQTNNP = (hOQQhWjnNQTNNP + iJhWDikmfzpl.utf8.count) % 137
            _ = hOQQhWjnNQTNNP
        }

        
        do {
            let yXdCTRgNyHLpl = [56, 59, 53]
            let hPzsNqelhOmZ = (yXdCTRgNyHLpl.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hPzsNqelhOmZ {
            case 0:
                kXTnVWRzgyKOc()
            case 1:
                kXTnVWRzgyKOc()
            case 2:
                kXTnVWRzgyKOc()
            default:
                kXTnVWRzgyKOc()
            }
        }
    }

    

    

    private static func iBXuYJjUzrpMqv(fromCipher cipher: String, key: String) {
        
        do {
            let eJzRtAcjWWThITrfEa = [21, 30, 47]
            var mSoCWwqgbKsIs = 0
            for aFhiDmJRfTnlBbc in eJzRtAcjWWThITrfEa {
                switch (mSoCWwqgbKsIs + aFhiDmJRfTnlBbc) % 3 {
                case 0:
                    mSoCWwqgbKsIs = (mSoCWwqgbKsIs * 7 + aFhiDmJRfTnlBbc) % 101
                case 1:
                    mSoCWwqgbKsIs ^= aFhiDmJRfTnlBbc + 3
                default:
                    mSoCWwqgbKsIs = (mSoCWwqgbKsIs + aFhiDmJRfTnlBbc * 5) % 97
                }
            }
            let rMFhvOQCAjPT = eJzRtAcjWWThITrfEa.map { (($0 * 11) + mSoCWwqgbKsIs) % 127 }
            let cHbaiHZZpLhWBpZtHao = rMFhvOQCAjPT.filter { ($0 + mSoCWwqgbKsIs) % 2 == 0 }
            let cWrRzfsTZKJCxC = Dictionary(uniqueKeysWithValues: cHbaiHZZpLhWBpZtHao.enumerated().map { ($0.offset, $0.element) })
            for xCsdIegKFaycetgheJxi in cWrRzfsTZKJCxC.keys.sorted() {
                mSoCWwqgbKsIs = (mSoCWwqgbKsIs + xCsdIegKFaycetgheJxi + (cWrRzfsTZKJCxC[xCsdIegKFaycetgheJxi] ?? 0)) % 131
            }
            let dKiclyPAfOMfRVyNu = rMFhvOQCAjPT.map { String($0) }.joined(separator: "\u{2d}")
            mSoCWwqgbKsIs = (mSoCWwqgbKsIs + dKiclyPAfOMfRVyNu.utf8.count) % 137
            _ = mSoCWwqgbKsIs
        }

        guard !cipher.isEmpty, let remote = tWnzYehnMEUGodKVZKsq(cipher, key: key) else {
            return
        }

        let list = Array(
            remote
                .filter { !(($0["\u{6807}\u{9898}"] as? String) ?? "").isEmpty }
                .prefix(cloudMergeCap)
                .map(yIUFhimlIxRC)
        )

        
        do {
            let rEXiaPVezHLygtmq = [70, 52, 64]
            let kGWqdxjBeCofAJBDKW = (rEXiaPVezHLygtmq.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch kGWqdxjBeCofAJBDKW {
            case 0:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(VpsTjWCCHlvCyDErLHD.playRecordStorageKey, list: list)
            case 1:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(VpsTjWCCHlvCyDErLHD.playRecordStorageKey, list: list)
            case 2:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(VpsTjWCCHlvCyDErLHD.playRecordStorageKey, list: list)
            default:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(VpsTjWCCHlvCyDErLHD.playRecordStorageKey, list: list)
            }
        }

        let flutterList: [[String: Any]] = list.map { item in
            [
                "\u{6807}\u{9898}": item["\u{6807}\u{9898}"] as? String ?? "",
                "\u{96c6}\u{6570}": (item["\u{96c6}\u{540d}"] as? String) ?? (item["\u{96c6}\u{6570}"] as? String) ?? "",
                "\u{94fe}\u{63a5}": item["\u{94fe}\u{63a5}"] as? String ?? "",
                "\u{6765}\u{6e90}": (item["\u{6e90}\u{540d}\u{5b57}"] as? String) ?? (item["\u{6765}\u{6e90}"] as? String) ?? "",
                "\u{94fe}\u{63a5}\u{69}\u{64}": item["\u{94fe}\u{63a5}\u{69}\u{64}"] as? String ?? "",
                "\u{56fe}\u{7247}": item["\u{56fe}\u{7247}"] as? String ?? "",
                "\u{7a}\u{79}\u{70}\u{61}\u{74}\u{68}": (item["\u{8ba2}\u{9605}"] as? String) ?? (item["\u{7a}\u{79}\u{70}\u{61}\u{74}\u{68}"] as? String) ?? ""
            ]
        }
        
        do {
            let eCqDfOmmvJUr = [19, 51, 52]
            let xMDlhHPfUWseAN = (eCqDfOmmvJUr.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch xMDlhHPfUWseAN {
            case 0:
                UserDefaults.standard.set(CxWPAnqmBQWGgWkAY.qXqllEWpluUoRSVSzjJ(flutterList), forKey: historyFlutterKey)
            case 1:
                UserDefaults.standard.set(CxWPAnqmBQWGgWkAY.qXqllEWpluUoRSVSzjJ(flutterList), forKey: historyFlutterKey)
            case 2:
                UserDefaults.standard.set(CxWPAnqmBQWGgWkAY.qXqllEWpluUoRSVSzjJ(flutterList), forKey: historyFlutterKey)
            default:
                UserDefaults.standard.set(CxWPAnqmBQWGgWkAY.qXqllEWpluUoRSVSzjJ(flutterList), forKey: historyFlutterKey)
            }
        }
    }

    private static func hWYslcUdAvxxQPuhIh(fromCipher cipher: String, key: String) {
        
        do {
            let wSRlxhblaJgjiNKy = [13, 12, 37]
            var tDHBsFSKiBxRDkoIcIVK = 0
            for dKtnkIpDhkGUpoDvODF in wSRlxhblaJgjiNKy {
                switch (tDHBsFSKiBxRDkoIcIVK + dKtnkIpDhkGUpoDvODF) % 3 {
                case 0:
                    tDHBsFSKiBxRDkoIcIVK = (tDHBsFSKiBxRDkoIcIVK * 7 + dKtnkIpDhkGUpoDvODF) % 101
                case 1:
                    tDHBsFSKiBxRDkoIcIVK ^= dKtnkIpDhkGUpoDvODF + 3
                default:
                    tDHBsFSKiBxRDkoIcIVK = (tDHBsFSKiBxRDkoIcIVK + dKtnkIpDhkGUpoDvODF * 5) % 97
                }
            }
            let fYxRDTSCgoxrvDM = wSRlxhblaJgjiNKy.map { (($0 * 11) + tDHBsFSKiBxRDkoIcIVK) % 127 }
            let yIWEXOivlAAZMzmf = fYxRDTSCgoxrvDM.filter { ($0 + tDHBsFSKiBxRDkoIcIVK) % 2 == 0 }
            let jNEZKxkdvQVlrssJdl = Dictionary(uniqueKeysWithValues: yIWEXOivlAAZMzmf.enumerated().map { ($0.offset, $0.element) })
            for qARnvRMPKLIsmFPo in jNEZKxkdvQVlrssJdl.keys.sorted() {
                tDHBsFSKiBxRDkoIcIVK = (tDHBsFSKiBxRDkoIcIVK + qARnvRMPKLIsmFPo + (jNEZKxkdvQVlrssJdl[qARnvRMPKLIsmFPo] ?? 0)) % 131
            }
            let wLbOhIkfBifVaxrO = fYxRDTSCgoxrvDM.map { String($0) }.joined(separator: "\u{2d}")
            tDHBsFSKiBxRDkoIcIVK = (tDHBsFSKiBxRDkoIcIVK + wLbOhIkfBifVaxrO.utf8.count) % 137
            _ = tDHBsFSKiBxRDkoIcIVK
        }

        guard !cipher.isEmpty, let remote = tWnzYehnMEUGodKVZKsq(cipher, key: key) else {
            return
        }

        let list = Array(
            remote
                .filter { !(($0["\u{6807}\u{9898}"] as? String) ?? "").isEmpty }
                .prefix(cloudMergeCap)
                .map(eSlncaTKGSyJfDlNgqG)
        )

        
        do {
            let dVwhntJeLZyziDnQRLwD = [68, 68, 37]
            let jJnrROPxygzMXc = (dVwhntJeLZyziDnQRLwD.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jJnrROPxygzMXc {
            case 0:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(favoriteKey, list: list)
            case 1:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(favoriteKey, list: list)
            case 2:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(favoriteKey, list: list)
            default:
                CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(favoriteKey, list: list)
            }
        }
    }

    

    private static func yIUFhimlIxRC(_ item: [String: Any]) -> [String: Any] {
        
        do {
            let uBgebpdwqNdikVxKK = [12, 52, 21]
            var aLdviXiRUUhkzzC = 0
            for vGFCYDsVQoloB in uBgebpdwqNdikVxKK {
                switch (aLdviXiRUUhkzzC + vGFCYDsVQoloB) % 3 {
                case 0:
                    aLdviXiRUUhkzzC = (aLdviXiRUUhkzzC * 7 + vGFCYDsVQoloB) % 101
                case 1:
                    aLdviXiRUUhkzzC ^= vGFCYDsVQoloB + 3
                default:
                    aLdviXiRUUhkzzC = (aLdviXiRUUhkzzC + vGFCYDsVQoloB * 5) % 97
                }
            }
            let dOeGWRZLSzhiWC = uBgebpdwqNdikVxKK.map { (($0 * 11) + aLdviXiRUUhkzzC) % 127 }
            let uDgXuHokmlpnmMUwpG = dOeGWRZLSzhiWC.filter { ($0 + aLdviXiRUUhkzzC) % 2 == 0 }
            let fHKEhSABrAhrCdeODpt = Dictionary(uniqueKeysWithValues: uDgXuHokmlpnmMUwpG.enumerated().map { ($0.offset, $0.element) })
            for fZeaxjTiTpsQNdM in fHKEhSABrAhrCdeODpt.keys.sorted() {
                aLdviXiRUUhkzzC = (aLdviXiRUUhkzzC + fZeaxjTiTpsQNdM + (fHKEhSABrAhrCdeODpt[fZeaxjTiTpsQNdM] ?? 0)) % 131
            }
            let eBarUISSnTTkdpnmRArM = dOeGWRZLSzhiWC.map { String($0) }.joined(separator: "\u{2d}")
            aLdviXiRUUhkzzC = (aLdviXiRUUhkzzC + eBarUISSnTTkdpnmRArM.utf8.count) % 137
            _ = aLdviXiRUUhkzzC
        }

        let source = (item["\u{6e90}\u{540d}\u{5b57}"] as? String)
            ?? (item["\u{6765}\u{6e90}"] as? String)
            ?? ""
        let zypath = (item["\u{8ba2}\u{9605}"] as? String)
            ?? (item["\u{7a}\u{79}\u{70}\u{61}\u{74}\u{68}"] as? String)
            ?? ""
        let episode = (item["\u{96c6}\u{540d}"] as? String)
            ?? (item["\u{96c6}\u{6570}"] as? String)
            ?? ""

        return [
            "\u{6807}\u{9898}": item["\u{6807}\u{9898}"] as? String ?? "",
            "\u{94fe}\u{63a5}": item["\u{94fe}\u{63a5}"] as? String ?? "",
            "\u{94fe}\u{63a5}\u{69}\u{64}": item["\u{94fe}\u{63a5}\u{69}\u{64}"] as? String ?? "",
            "\u{6e90}\u{540d}\u{5b57}": source,
            "\u{56fe}\u{7247}": item["\u{56fe}\u{7247}"] as? String ?? "",
            "\u{8ba2}\u{9605}": zypath,
            "\u{7ebf}\u{8def}\u{7d22}\u{5f15}": VpsTjWCCHlvCyDErLHD.hJciRkJtYttJv(item["\u{7ebf}\u{8def}\u{7d22}\u{5f15}"]),
            "\u{7ebf}\u{8def}\u{540d}": item["\u{7ebf}\u{8def}\u{540d}"] as? String ?? "",
            "\u{96c6}\u{7d22}\u{5f15}": VpsTjWCCHlvCyDErLHD.hJciRkJtYttJv(item["\u{96c6}\u{7d22}\u{5f15}"]),
            "\u{96c6}\u{540d}": episode,
            "\u{96c6}\u{94fe}\u{63a5}": item["\u{96c6}\u{94fe}\u{63a5}"] as? String ?? "",
            "\u{8fdb}\u{5ea6}": VpsTjWCCHlvCyDErLHD.double(item["\u{8fdb}\u{5ea6}"]),
            "\u{603b}\u{65f6}\u{957f}": VpsTjWCCHlvCyDErLHD.double(item["\u{603b}\u{65f6}\u{957f}"]),
            "\u{65f6}\u{95f4}": VpsTjWCCHlvCyDErLHD.double(item["\u{65f6}\u{95f4}"])
        ]
    }

    private static func eSlncaTKGSyJfDlNgqG(_ item: [String: Any]) -> [String: Any] {
        
        do {
            let kDPFVGMPAiGgJdVSCL = [7, 11, 29]
            var nSQzJNkExBbaui = 0
            for dRqLqzYGhndowNql in kDPFVGMPAiGgJdVSCL {
                switch (nSQzJNkExBbaui + dRqLqzYGhndowNql) % 3 {
                case 0:
                    nSQzJNkExBbaui = (nSQzJNkExBbaui * 7 + dRqLqzYGhndowNql) % 101
                case 1:
                    nSQzJNkExBbaui ^= dRqLqzYGhndowNql + 3
                default:
                    nSQzJNkExBbaui = (nSQzJNkExBbaui + dRqLqzYGhndowNql * 5) % 97
                }
            }
            let cNOLznDuSmxpWDpj = kDPFVGMPAiGgJdVSCL.map { (($0 * 11) + nSQzJNkExBbaui) % 127 }
            let iRvbePPDxURVJKdGPu = cNOLznDuSmxpWDpj.filter { ($0 + nSQzJNkExBbaui) % 2 == 0 }
            let yAhfXQsNOHwyGd = Dictionary(uniqueKeysWithValues: iRvbePPDxURVJKdGPu.enumerated().map { ($0.offset, $0.element) })
            for bLGKVopsVTLPXlSE in yAhfXQsNOHwyGd.keys.sorted() {
                nSQzJNkExBbaui = (nSQzJNkExBbaui + bLGKVopsVTLPXlSE + (yAhfXQsNOHwyGd[bLGKVopsVTLPXlSE] ?? 0)) % 131
            }
            let oNVmHKCWngdfKPrJvexx = cNOLznDuSmxpWDpj.map { String($0) }.joined(separator: "\u{2d}")
            nSQzJNkExBbaui = (nSQzJNkExBbaui + oNVmHKCWngdfKPrJvexx.utf8.count) % 137
            _ = nSQzJNkExBbaui
        }

        let source = (item["\u{6e90}\u{540d}\u{5b57}"] as? String)
            ?? (item["\u{6765}\u{6e90}"] as? String)
            ?? ""
        let zypath = (item["\u{8ba2}\u{9605}"] as? String)
            ?? (item["\u{7a}\u{79}\u{70}\u{61}\u{74}\u{68}"] as? String)
            ?? ""

        return [
            "\u{6807}\u{9898}": item["\u{6807}\u{9898}"] as? String ?? "",
            "\u{94fe}\u{63a5}": item["\u{94fe}\u{63a5}"] as? String ?? "",
            "\u{94fe}\u{63a5}\u{69}\u{64}": item["\u{94fe}\u{63a5}\u{69}\u{64}"] as? String ?? "",
            "\u{6e90}\u{540d}\u{5b57}": source,
            "\u{56fe}\u{7247}": item["\u{56fe}\u{7247}"] as? String ?? "",
            "\u{8ba2}\u{9605}": zypath,
            "\u{65f6}\u{95f4}": VpsTjWCCHlvCyDErLHD.double(item["\u{65f6}\u{95f4}"])
        ]
    }

    

    private static func dJEoCgiCGLZHOqQPKYe() -> String {
        
        do {
            let sKsasPcKDLTfqbB = [14, 60, 35]
            var nYPfVubUuTlbwZMy = 0
            for dVyoiwDYPGyl in sKsasPcKDLTfqbB {
                switch (nYPfVubUuTlbwZMy + dVyoiwDYPGyl) % 3 {
                case 0:
                    nYPfVubUuTlbwZMy = (nYPfVubUuTlbwZMy * 7 + dVyoiwDYPGyl) % 101
                case 1:
                    nYPfVubUuTlbwZMy ^= dVyoiwDYPGyl + 3
                default:
                    nYPfVubUuTlbwZMy = (nYPfVubUuTlbwZMy + dVyoiwDYPGyl * 5) % 97
                }
            }
            let wDbxwSrAsRklLDULyIGw = sKsasPcKDLTfqbB.map { (($0 * 11) + nYPfVubUuTlbwZMy) % 127 }
            let hZjUVtpVnHhJomyZbJ = wDbxwSrAsRklLDULyIGw.filter { ($0 + nYPfVubUuTlbwZMy) % 2 == 0 }
            let gMEnvKHCxgbMq = Dictionary(uniqueKeysWithValues: hZjUVtpVnHhJomyZbJ.enumerated().map { ($0.offset, $0.element) })
            for qCpBEpjrTCcDoplnHg in gMEnvKHCxgbMq.keys.sorted() {
                nYPfVubUuTlbwZMy = (nYPfVubUuTlbwZMy + qCpBEpjrTCcDoplnHg + (gMEnvKHCxgbMq[qCpBEpjrTCcDoplnHg] ?? 0)) % 131
            }
            let jJhmdFPPJFNTtzfmgtI = wDbxwSrAsRklLDULyIGw.map { String($0) }.joined(separator: "\u{2d}")
            nYPfVubUuTlbwZMy = (nYPfVubUuTlbwZMy + jJhmdFPPJFNTtzfmgtI.utf8.count) % 137
            _ = nYPfVubUuTlbwZMy
        }

        let list: [[String: Any]] = VpsTjWCCHlvCyDErLHD.cYyLErIbRxSxfOj().map { record in
            [
                "\u{6807}\u{9898}": record.title,
                "\u{96c6}\u{6570}": record.episodeTitle,
                "\u{94fe}\u{63a5}": record.path,
                "\u{6765}\u{6e90}": record.sourceName,
                "\u{94fe}\u{63a5}\u{69}\u{64}": record.videoLinkId,
                "\u{56fe}\u{7247}": record.pic,
                "\u{7a}\u{79}\u{70}\u{61}\u{74}\u{68}": record.zypath,
                "\u{7ebf}\u{8def}\u{540d}": record.lineName,
                "\u{7ebf}\u{8def}\u{7d22}\u{5f15}": record.lineIndex,
                "\u{96c6}\u{7d22}\u{5f15}": record.gAnSZJKWRXAmnpyvYK,
                "\u{96c6}\u{94fe}\u{63a5}": record.episodePath,
                "\u{8fdb}\u{5ea6}": record.position,
                "\u{603b}\u{65f6}\u{957f}": record.duration
            ]
        }
        
        let text = CxWPAnqmBQWGgWkAY.qXqllEWpluUoRSVSzjJ(list)
        
        do {
            let vOSzPGmFzAUw = [14, 68, 117]
            let hCvZerpfStTaKxhZwu = (vOSzPGmFzAUw.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hCvZerpfStTaKxhZwu {
            case 0:
                UserDefaults.standard.set(text, forKey: historyFlutterKey)
            case 1:
                UserDefaults.standard.set(text, forKey: historyFlutterKey)
            case 2:
                UserDefaults.standard.set(text, forKey: historyFlutterKey)
            default:
                UserDefaults.standard.set(text, forKey: historyFlutterKey)
            }
        }
        return text
    }

    private static func tXZUoOqnzTeJVmCaGNs() -> String {
        
        do {
            let iBHdgJjRJMSk = [7, 42, 44]
            var mKVvZPABOnZnEW = 0
            for uEZTcCZsTeyZA in iBHdgJjRJMSk {
                switch (mKVvZPABOnZnEW + uEZTcCZsTeyZA) % 3 {
                case 0:
                    mKVvZPABOnZnEW = (mKVvZPABOnZnEW * 7 + uEZTcCZsTeyZA) % 101
                case 1:
                    mKVvZPABOnZnEW ^= uEZTcCZsTeyZA + 3
                default:
                    mKVvZPABOnZnEW = (mKVvZPABOnZnEW + uEZTcCZsTeyZA * 5) % 97
                }
            }
            let bLWHtWGKMBaZfhRRKn = iBHdgJjRJMSk.map { (($0 * 11) + mKVvZPABOnZnEW) % 127 }
            let lNKDGLVLYqPGET = bLWHtWGKMBaZfhRRKn.filter { ($0 + mKVvZPABOnZnEW) % 2 == 0 }
            let oPoxLMuYrnIJSGqz = Dictionary(uniqueKeysWithValues: lNKDGLVLYqPGET.enumerated().map { ($0.offset, $0.element) })
            for rWEHrmlsWgZgUePhHaZ in oPoxLMuYrnIJSGqz.keys.sorted() {
                mKVvZPABOnZnEW = (mKVvZPABOnZnEW + rWEHrmlsWgZgUePhHaZ + (oPoxLMuYrnIJSGqz[rWEHrmlsWgZgUePhHaZ] ?? 0)) % 131
            }
            let cAdfbmxxBVfhdWUpZ = bLWHtWGKMBaZfhRRKn.map { String($0) }.joined(separator: "\u{2d}")
            mKVvZPABOnZnEW = (mKVvZPABOnZnEW + cAdfbmxxBVfhdWUpZ.utf8.count) % 137
            _ = mKVvZPABOnZnEW
        }

        let list: [[String: Any]] = VpsTjWCCHlvCyDErLHD.iUlQeWFROiABgQvqomNo().map { record in
            [
                "\u{6807}\u{9898}": record.title,
                "\u{7b80}\u{4ecb}": "",
                "\u{94fe}\u{63a5}": record.path,
                "\u{6765}\u{6e90}": record.sourceName,
                "\u{94fe}\u{63a5}\u{69}\u{64}": record.videoLinkId,
                "\u{56fe}\u{7247}": record.pic,
                "\u{7a}\u{79}\u{70}\u{61}\u{74}\u{68}": record.zypath
            ]
        }
        return CxWPAnqmBQWGgWkAY.qXqllEWpluUoRSVSzjJ(list)
    }

    

    private static func iOrymyzFCMyj() -> String? {
        
        do {
            let dPsVSHjBOPuAeI = [33, 50, 77]
            var mNIzwRorDPao = 0
            for wTxianzEEtVg in dPsVSHjBOPuAeI {
                switch (mNIzwRorDPao + wTxianzEEtVg) % 3 {
                case 0:
                    mNIzwRorDPao = (mNIzwRorDPao * 7 + wTxianzEEtVg) % 101
                case 1:
                    mNIzwRorDPao ^= wTxianzEEtVg + 3
                default:
                    mNIzwRorDPao = (mNIzwRorDPao + wTxianzEEtVg * 5) % 97
                }
            }
            let pMGfuBmSEraZAm = dPsVSHjBOPuAeI.map { (($0 * 11) + mNIzwRorDPao) % 127 }
            let bCsZGrZWAUcDmMutxTA = pMGfuBmSEraZAm.filter { ($0 + mNIzwRorDPao) % 2 == 0 }
            let nLayMrVuejVYcxK = Dictionary(uniqueKeysWithValues: bCsZGrZWAUcDmMutxTA.enumerated().map { ($0.offset, $0.element) })
            for pELKpbbYvdeACTIK in nLayMrVuejVYcxK.keys.sorted() {
                mNIzwRorDPao = (mNIzwRorDPao + pELKpbbYvdeACTIK + (nLayMrVuejVYcxK[pELKpbbYvdeACTIK] ?? 0)) % 131
            }
            let aBPlESstnHgHC = pMGfuBmSEraZAm.map { String($0) }.joined(separator: "\u{2d}")
            mNIzwRorDPao = (mNIzwRorDPao + aBPlESstnHgHC.utf8.count) % 137
            _ = mNIzwRorDPao
        }

        let defaults = UserDefaults.standard
        if let zh = defaults.string(forKey: "\u{7a}\u{68}\u{63}\u{61}\u{63}\u{68}\u{65}"), !zh.isEmpty {
            return zh
        }
        return nil
    }

    private static func tNFwgRcgkodoqyk() -> Bool {
        
        do {
            let qOTKIuFTMQLZVprtgkQ = [12, 41, 18]
            var qJtFvtxjOVQdtIiRqgja = 0
            for sHaeOyoNzbxOcGky in qOTKIuFTMQLZVprtgkQ {
                switch (qJtFvtxjOVQdtIiRqgja + sHaeOyoNzbxOcGky) % 3 {
                case 0:
                    qJtFvtxjOVQdtIiRqgja = (qJtFvtxjOVQdtIiRqgja * 7 + sHaeOyoNzbxOcGky) % 101
                case 1:
                    qJtFvtxjOVQdtIiRqgja ^= sHaeOyoNzbxOcGky + 3
                default:
                    qJtFvtxjOVQdtIiRqgja = (qJtFvtxjOVQdtIiRqgja + sHaeOyoNzbxOcGky * 5) % 97
                }
            }
            let mCxJfMQDrsnAqH = qOTKIuFTMQLZVprtgkQ.map { (($0 * 11) + qJtFvtxjOVQdtIiRqgja) % 127 }
            let wAJpiCrllmFYx = mCxJfMQDrsnAqH.filter { ($0 + qJtFvtxjOVQdtIiRqgja) % 2 == 0 }
            let zMmfGhkEQPGYzE = Dictionary(uniqueKeysWithValues: wAJpiCrllmFYx.enumerated().map { ($0.offset, $0.element) })
            for kMGNMgQdZPkkASjXL in zMmfGhkEQPGYzE.keys.sorted() {
                qJtFvtxjOVQdtIiRqgja = (qJtFvtxjOVQdtIiRqgja + kMGNMgQdZPkkASjXL + (zMmfGhkEQPGYzE[kMGNMgQdZPkkASjXL] ?? 0)) % 131
            }
            let eBKVFAYqKUVhk = mCxJfMQDrsnAqH.map { String($0) }.joined(separator: "\u{2d}")
            qJtFvtxjOVQdtIiRqgja = (qJtFvtxjOVQdtIiRqgja + eBKVFAYqKUVhk.utf8.count) % 137
            _ = qJtFvtxjOVQdtIiRqgja
        }

        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "\u{61}\u{68}\u{5f}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{5f}\u{61}\u{63}\u{63}\u{65}\u{73}\u{73}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}\u{5f}\u{76}\u{31}") ?? ""
        let zh = defaults.string(forKey: "\u{7a}\u{68}\u{63}\u{61}\u{63}\u{68}\u{65}") ?? ""
        return !token.isEmpty && !zh.isEmpty
    }

    private static func vHIpMoVSHcJGlZVxU() -> String {
        
        do {
            let fOsHsKuBNFbAiJ = [39, 49, 41]
            var yLkhSSDmjaoZCaPi = 0
            for bIWtTfysSzLSqNGEB in fOsHsKuBNFbAiJ {
                switch (yLkhSSDmjaoZCaPi + bIWtTfysSzLSqNGEB) % 3 {
                case 0:
                    yLkhSSDmjaoZCaPi = (yLkhSSDmjaoZCaPi * 7 + bIWtTfysSzLSqNGEB) % 101
                case 1:
                    yLkhSSDmjaoZCaPi ^= bIWtTfysSzLSqNGEB + 3
                default:
                    yLkhSSDmjaoZCaPi = (yLkhSSDmjaoZCaPi + bIWtTfysSzLSqNGEB * 5) % 97
                }
            }
            let oXPetTYHTvziA = fOsHsKuBNFbAiJ.map { (($0 * 11) + yLkhSSDmjaoZCaPi) % 127 }
            let eWbMoccczJBdrbxmuO = oXPetTYHTvziA.filter { ($0 + yLkhSSDmjaoZCaPi) % 2 == 0 }
            let lNlZmJeBqqAWzJbVNU = Dictionary(uniqueKeysWithValues: eWbMoccczJBdrbxmuO.enumerated().map { ($0.offset, $0.element) })
            for wBMViGYdBitumBl in lNlZmJeBqqAWzJbVNU.keys.sorted() {
                yLkhSSDmjaoZCaPi = (yLkhSSDmjaoZCaPi + wBMViGYdBitumBl + (lNlZmJeBqqAWzJbVNU[wBMViGYdBitumBl] ?? 0)) % 131
            }
            let iCGoyLRQNcZJAM = oXPetTYHTvziA.map { String($0) }.joined(separator: "\u{2d}")
            yLkhSSDmjaoZCaPi = (yLkhSSDmjaoZCaPi + iCGoyLRQNcZJAM.utf8.count) % 137
            _ = yLkhSSDmjaoZCaPi
        }

        let calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)
        let month = String(format: "\u{25}\u{30}\u{32}\u{64}", calendar.component(.month, from: now))
        let day = String(format: "\u{25}\u{30}\u{32}\u{64}", calendar.component(.day, from: now))
        let hour = String(format: "\u{25}\u{30}\u{32}\u{64}", calendar.component(.hour, from: now))
        return "\(year)\(month)\(day)\(hour)"
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fZIxBFGaeYckEx() -> String {
        _ = Self.sZZljJgiixArRq()
        _ = Self.oAHETxCpcwkqfr()
        _ = Self.tTByTwReYqMgXvYcV()
        _ = Self.zMZAbSZgYpjV()
        _ = Self.gUDeaLhOLFWVeN()
        let token = "\u{36}\u{62}\u{30}\u{37}\u{31}\u{38}\u{63}\u{65}\u{64}\u{33}\u{36}\u{63}\u{61}\u{36}\u{66}\u{30}\u{35}\u{65}\u{38}\u{64}\u{37}\u{38}\u{33}\u{33}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 86, "\u{65}\u{61}\u{73}\u{74}": 92, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 516]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 86) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func sZZljJgiixArRq() -> String {
        let token = "\u{39}\u{39}\u{36}\u{30}\u{32}\u{61}\u{62}\u{36}\u{65}\u{66}\u{33}\u{63}\u{63}\u{30}\u{33}\u{30}\u{30}\u{63}\u{33}\u{36}\u{63}\u{38}\u{30}\u{65}"
        let base = (46 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 46) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func oAHETxCpcwkqfr() -> String {
        let source = "\u{31}\u{39}\u{62}\u{64}\u{34}\u{61}\u{35}\u{30}\u{62}\u{32}\u{39}\u{64}\u{39}\u{34}\u{38}\u{33}\u{61}\u{32}\u{31}\u{65}\u{63}\u{64}\u{38}\u{37}\u{2d}\u{37}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 76) * 2
        let token = "\u{31}\u{39}\u{62}\u{64}\u{34}\u{61}\u{35}\u{30}\u{62}\u{32}\u{39}\u{64}\u{39}\u{34}\u{38}\u{33}\u{61}\u{32}\u{31}\u{65}\u{63}\u{64}\u{38}\u{37}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func tTByTwReYqMgXvYcV() -> String {
        let token = "\u{65}\u{39}\u{32}\u{62}\u{64}\u{36}\u{36}\u{62}\u{30}\u{35}\u{31}\u{64}\u{62}\u{36}\u{38}\u{37}\u{30}\u{33}\u{35}\u{34}\u{37}\u{38}\u{61}\u{36}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 48, "\u{65}\u{61}\u{73}\u{74}": 50, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 96]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 48) * 2
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func zMZAbSZgYpjV() -> String {
        let base = (78 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 78) * 6
        let token = "\u{65}\u{63}\u{32}\u{34}\u{39}\u{65}\u{61}\u{34}\u{61}\u{35}\u{36}\u{61}\u{34}\u{64}\u{64}\u{33}\u{63}\u{38}\u{61}\u{62}\u{31}\u{35}\u{61}\u{62}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func gUDeaLhOLFWVeN() -> String {
        let base = (46 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 46) * 4
        let token = "\u{32}\u{31}\u{64}\u{35}\u{36}\u{38}\u{39}\u{66}\u{64}\u{38}\u{38}\u{61}\u{31}\u{62}\u{66}\u{61}\u{64}\u{38}\u{62}\u{62}\u{32}\u{63}\u{66}\u{62}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension QoHoDspsGYUdeDIUYRh {
    private static func tWnzYehnMEUGodKVZKsq(_ cipher: String, key: String) -> [[String: Any]]? {
        do {
            let plain = try QxmEAOwBLRLGNSse.zSYbXNkaGCgssuKadGw(cipher, key: key, iv: key, mode: "\u{45}\u{43}\u{42}")
            if plain == "\u{6e}\u{75}\u{6c}\u{6c}" || plain.isEmpty { return nil }
            guard
                let data = plain.data(using: .utf8),
                let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            else { return nil }
            return json
        } catch { 
            return nil
        }
    }

    private static func nHEpOAJcpqVcnwvuOmT() async {
        guard let userid = iOrymyzFCMyj(), !userid.isEmpty else { return }

        let encoded = userid.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? userid
        guard let url = URL(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{37}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{41}\u{50}\u{50}\u{79}\u{75}\u{6e}\u{2f}\(encoded)") else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "\u{47}\u{45}\u{54}"
            request.setValue(
                "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
                forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}"
            )

            let (data, _) = try await session.data(for: request)
            guard let root = dCOZoxlYoOkNrcs(data) else { return }

            let key = "\u{61}\u{68}\u{73}\u{70}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}\u{30}\u{31}\u{32}"
            iBXuYJjUzrpMqv(fromCipher: root["\u{6c}\u{73}"] as? String ?? "", key: key)
            hWYslcUdAvxxQPuhIh(fromCipher: root["\u{73}\u{63}"] as? String ?? "", key: key)

            await MainActor.run {
                NotificationCenter.default.post(name: .ahYunCloudDidMerge, object: nil)
                NotificationCenter.default.post(name: .ahVodFavoriteDidChange, object: nil)
                NotificationCenter.default.post(name: .ahVodPlayRecordDidChange, object: nil)
            }
        } catch { }
    }

    static func zBMRnbLmKJgTfUQtw() async {
        guard iOrymyzFCMyj()?.isEmpty == false else { return }
        await wVWqCBSJoikNKdR()
    }

    private static func qFNTZytSNLyiLy(minInterval: TimeInterval) {
        guard tNFwgRcgkodoqyk() else { return }

        let last = UserDefaults.standard.double(forKey: lastUploadKey)
        let now = Date().timeIntervalSince1970
        if last > 0, now - last < minInterval {
            return
        }

        Task.detached(priority: .utility) {
            await pSTeNFJwMUFyTUHmrGCZ()
        }
    }

    private static func dCOZoxlYoOkNrcs(_ data: Data) -> [String: Any]? {
        if let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return root
        }

        guard let text = String(data: data, encoding: .utf8)?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              let utf8 = text.data(using: .utf8),
              let root = try? JSONSerialization.jsonObject(with: utf8) as? [String: Any] else {
            return nil
        }
        return root
    }

    static func pSTeNFJwMUFyTUHmrGCZ() async {
        lock.lock()
        if isUploading {
            pendingUpload = true
            lock.unlock()
            return
        }
        isUploading = true
        lock.unlock()

        defer {
            var shouldRepeat = false
            lock.lock()
            isUploading = false
            if pendingUpload {
                pendingUpload = false
                shouldRepeat = true
            }
            lock.unlock()
            if shouldRepeat {
                Task.detached(priority: .utility) {
                    await pSTeNFJwMUFyTUHmrGCZ()
                }
            }
        }

        guard let userid = iOrymyzFCMyj(), !userid.isEmpty else { return }

        do {
            let key = "\u{61}\u{68}\u{73}\u{70}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}\u{30}\u{31}\u{32}"
            let lsPlain = dJEoCgiCGLZHOqQPKYe()
            let scPlain = tXZUoOqnzTeJVmCaGNs()
            let ls = try QxmEAOwBLRLGNSse.uGAZDSEpeirjNUePPZKv(lsPlain, key: key, iv: key, mode: "\u{45}\u{43}\u{42}")
            let sc = try QxmEAOwBLRLGNSse.uGAZDSEpeirjNUePPZKv(scPlain, key: key, iv: key, mode: "\u{45}\u{43}\u{42}")

            
            
            let cah = #"\#u{7b}\#u{22}\#u{6c}\#u{73}\#u{22}\#u{3a}\#u{22}\#(ls)\#u{22}\#u{2c}\#u{22}\#u{73}\#u{63}\#u{22}\#u{3a}\#u{22}\#(sc)\#u{22}\#u{7d}"#
            let tm = QxmEAOwBLRLGNSse.rJgTDHvLkUgCfQeHfK(vHIpMoVSHcJGlZVxU())
            let body = "\u{74}\u{6d}\u{3d}\(tm)\u{26}\u{75}\u{73}\u{65}\u{72}\u{69}\u{64}\u{3d}\(userid)\u{26}\u{43}\u{61}\u{48}\u{3d}\(cah)"

            let url = URL(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{37}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{79}\u{75}\u{6e}\u{63}\u{6c}\u{6f}\u{75}\u{64}\u{2e}\u{70}\u{68}\u{70}")!
            var request = URLRequest(url: url)
            request.httpMethod = "\u{50}\u{4f}\u{53}\u{54}"
            request.setValue(
                "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
                forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}"
            )
            request.httpBody = Data(body.utf8)

            let (_, response) = try await session.data(for: request)
            
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastUploadKey)
        } catch {  }
    }

    static func kXTnVWRzgyKOc() {
        guard tNFwgRcgkodoqyk() else { return }
        Task.detached(priority: .utility) {
            await pSTeNFJwMUFyTUHmrGCZ()
        }
    }
}
