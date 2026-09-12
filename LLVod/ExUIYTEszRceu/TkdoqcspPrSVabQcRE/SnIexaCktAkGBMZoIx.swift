






import Foundation

enum OuXdUjLJRmBbgUhANKSu {

    static func buildRequestParams(
        sources: [[String: Any]],
        keyword: String
    ) async -> [KlkwtQJcDoqqkNfKrkYt] {
        // source-obfuscator:padding:v1
        _ = Self.kYjTuGtYHjWsfept()

        var params: [KlkwtQJcDoqqkNfKrkYt] = []
        for (index, factory) in vATdenvjmOKRC(sources: sources, keyword: keyword).enumerated() {
            if let built = await factory() {
                params.append(
                    KlkwtQJcDoqqkNfKrkYt(
                        url: built.url,
                        method: built.method,
                        data: built.data,
                        headers: built.headers,
                        sourceIndex: built.sourceIndex ?? index
                    )
                )
            }
        }
        return params
    }

    static func vATdenvjmOKRC(
        sources: [[String: Any]],
        keyword: String
    ) -> [() async -> KlkwtQJcDoqqkNfKrkYt?] {
        sources.enumerated().map { index, source in
            {
                await Self.iOjrmVOUPhrreRsiQ(source: source, keyword: keyword, sourceIndex: index)
            }
        }
    }

    

    static func zTKVgCqCvJuuiHrXpmJ(
        source: [String: Any],
        response: String,
        realURI: String
    ) async -> [PzPGBfDtzkHPSRROQs] {
        if bKcBSmRoPulWMeulc(source) {
            return await iIfipxVYOgyp(source: source, response: response)
        }

        let sourceType = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6d}\u{42}\u{39}\u{54}\u{65}\u{4e}\u{38}\u{68}\u{46}")] as? String ?? ""

        if sourceType == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{71}\u{74}\u{4f}\u{39}\u{38}\u{44}\u{46}\u{37}") {
            return mRYVLhSqARkRvoKo(source: source, response: response, realURI: realURI)
        }

        return tMqVpoftNgbkiupaXopq(source: source, response: response, realURI: realURI)
    }

    

    

    private static func mPhFSkOmJUaGjTf(
        source: [String: Any],
        keyword: String
    ) -> KlkwtQJcDoqqkNfKrkYt? {
        
        do {
            let pLrLeVKxftTfdhMKrNoC = [8, 21, 27]
            var rBwQonJKbPrTEGxNoC = 0
            for xIUDdeZRUpzolrXwaufi in pLrLeVKxftTfdhMKrNoC {
                switch (rBwQonJKbPrTEGxNoC + xIUDdeZRUpzolrXwaufi) % 3 {
                case 0:
                    rBwQonJKbPrTEGxNoC = (rBwQonJKbPrTEGxNoC * 7 + xIUDdeZRUpzolrXwaufi) % 101
                case 1:
                    rBwQonJKbPrTEGxNoC ^= xIUDdeZRUpzolrXwaufi + 3
                default:
                    rBwQonJKbPrTEGxNoC = (rBwQonJKbPrTEGxNoC + xIUDdeZRUpzolrXwaufi * 5) % 97
                }
            }
            let aSzuxfajCXPKy = pLrLeVKxftTfdhMKrNoC.map { (($0 * 11) + rBwQonJKbPrTEGxNoC) % 127 }
            let dHFFzjYxcQnDTcLWZ = aSzuxfajCXPKy.filter { ($0 + rBwQonJKbPrTEGxNoC) % 2 == 0 }
            let wTmcdLqAhNHrbMonjkl = Dictionary(uniqueKeysWithValues: dHFFzjYxcQnDTcLWZ.enumerated().map { ($0.offset, $0.element) })
            for cMIlzOCbkUDiNIZ in wTmcdLqAhNHrbMonjkl.keys.sorted() {
                rBwQonJKbPrTEGxNoC = (rBwQonJKbPrTEGxNoC + cMIlzOCbkUDiNIZ + (wTmcdLqAhNHrbMonjkl[cMIlzOCbkUDiNIZ] ?? 0)) % 131
            }
            let vEJayWFgqMGLerOjABK = aSzuxfajCXPKy.map { String($0) }.joined(separator: "\u{2d}")
            rBwQonJKbPrTEGxNoC = (rBwQonJKbPrTEGxNoC + vEJayWFgqMGLerOjABK.utf8.count) % 137
            _ = rBwQonJKbPrTEGxNoC
        }

        let searchAPI = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{30}\u{76}\u{45}\u{41}\u{54}\u{6b}\u{59}\u{6f}")] as? String ?? ""

        
        switch (searchAPI.isEmpty) {
        case true: do {
            
            let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
            let searchURL = (source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{4a}\u{44}\u{5a}\u{76}\u{51}\u{51}\u{6b}\u{46}")] as? String ?? "")
                .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{4d}\u{45}\u{42}\u{73}\u{46}\u{4d}\u{71}\u{43}"), with: encodedKeyword)
            let postBody = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{38}\u{33}\u{4a}\u{65}\u{78}\u{42}\u{6f}\u{39}")] as? String

            var headers: [String: String] = [
                "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}": "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
                "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}": "\u{67}\u{7a}\u{69}\u{70}",
                "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}": LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()
            ]

            if let referer = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{61}\u{51}\u{67}\u{64}\u{64}\u{64}\u{4a}\u{74}")] as? String, !referer.isEmpty {
                headers[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{48}\u{79}\u{45}\u{38}\u{44}\u{6e}\u{30}\u{54}")] = referer
            }

            if postBody?.isEmpty ?? true {
                return KlkwtQJcDoqqkNfKrkYt(
                    url: searchURL,
                    method: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{38}\u{58}\u{41}\u{42}\u{72}\u{4c}\u{62}\u{30}"),
                    headers: headers
                )
            }

            return KlkwtQJcDoqqkNfKrkYt(
                url: source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{4a}\u{44}\u{5a}\u{76}\u{51}\u{51}\u{6b}\u{46}")] as? String ?? searchURL,
                method: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{43}\u{66}\u{59}\u{39}\u{52}\u{51}\u{68}\u{30}"),
                data: postBody?.replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{4d}\u{45}\u{42}\u{73}\u{46}\u{4d}\u{71}\u{43}"), with: keyword),
                headers: headers
            )}
        case false:
            break
        }

        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
        let url = searchAPI + AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{42}\u{38}\u{52}\u{56}\u{55}\u{31}\u{4a}\u{47}") + encodedKeyword
        return KlkwtQJcDoqqkNfKrkYt(
            url: url,
            method: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{38}\u{58}\u{41}\u{42}\u{72}\u{4c}\u{62}\u{30}"),
            headers: [
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{5a}\u{65}\u{32}\u{66}\u{71}\u{69}\u{48}\u{78}"): AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{69}\u{76}\u{72}\u{48}\u{45}\u{34}\u{37}\u{76}"),
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{6e}\u{64}\u{48}\u{69}\u{56}\u{4c}\u{61}\u{47}"): AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{33}\u{68}\u{4c}\u{75}\u{5a}\u{48}\u{76}\u{51}"),
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{38}\u{32}\u{68}\u{4b}\u{37}\u{64}\u{4d}\u{36}"): LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()
            ]
        )
    }

    private static func vOFUDzlLMujRwpvPQXBK(
        source: [String: Any],
        keyword: String
    ) -> KlkwtQJcDoqqkNfKrkYt? {
        
        do {
            let aXQUFTcempWtuwbB = [7, 55, 34]
            var nMwAqHtktOWgJLgT = 0
            for sRlzuXRosJYUtlQBCcD in aXQUFTcempWtuwbB {
                switch (nMwAqHtktOWgJLgT + sRlzuXRosJYUtlQBCcD) % 3 {
                case 0:
                    nMwAqHtktOWgJLgT = (nMwAqHtktOWgJLgT * 7 + sRlzuXRosJYUtlQBCcD) % 101
                case 1:
                    nMwAqHtktOWgJLgT ^= sRlzuXRosJYUtlQBCcD + 3
                default:
                    nMwAqHtktOWgJLgT = (nMwAqHtktOWgJLgT + sRlzuXRosJYUtlQBCcD * 5) % 97
                }
            }
            let oPYvOyJzEdIqi = aXQUFTcempWtuwbB.map { (($0 * 11) + nMwAqHtktOWgJLgT) % 127 }
            let bFQJNjIeYQqhhISbQkjX = oPYvOyJzEdIqi.filter { ($0 + nMwAqHtktOWgJLgT) % 2 == 0 }
            let oFTVhIOkXSUFeUGqcI = Dictionary(uniqueKeysWithValues: bFQJNjIeYQqhhISbQkjX.enumerated().map { ($0.offset, $0.element) })
            for aFUwwNpFISbrG in oFTVhIOkXSUFeUGqcI.keys.sorted() {
                nMwAqHtktOWgJLgT = (nMwAqHtktOWgJLgT + aFUwwNpFISbrG + (oFTVhIOkXSUFeUGqcI[aFUwwNpFISbrG] ?? 0)) % 131
            }
            let sNnDGxyopYWbMNBrM = oPYvOyJzEdIqi.map { String($0) }.joined(separator: "\u{2d}")
            nMwAqHtktOWgJLgT = (nMwAqHtktOWgJLgT + sNnDGxyopYWbMNBrM.utf8.count) % 137
            _ = nMwAqHtktOWgJLgT
        }

        let baseURL = (source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{6a}\u{73}\u{4b}\u{67}\u{54}\u{43}\u{49}\u{51}")] as? String ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard !baseURL.isEmpty else { return nil }

        let url = hOLftiGfXrytDr(baseURL: baseURL, keyword: keyword)
        var headers: [String: String] = [:]

        if let searchUA = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{78}\u{75}\u{6a}\u{6b}\u{47}\u{79}\u{68}\u{43}")] as? String, !searchUA.isEmpty {
            headers = TtDfizBQZfgNxud.aVsCZqLjzAieKnJ(searchUA)
        }

        return KlkwtQJcDoqqkNfKrkYt(url: url, method: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{38}\u{58}\u{41}\u{42}\u{72}\u{4c}\u{62}\u{30}"), headers: headers)
    }

    private static func hOLftiGfXrytDr(baseURL: String, keyword: String) -> String {
        
        do {
            let rQCjjNrlpszGOScga = [46, 58, 60]
            var dLMCUiFWraubi = 0
            for mDeDKKUdPLQFbJd in rQCjjNrlpszGOScga {
                switch (dLMCUiFWraubi + mDeDKKUdPLQFbJd) % 3 {
                case 0:
                    dLMCUiFWraubi = (dLMCUiFWraubi * 7 + mDeDKKUdPLQFbJd) % 101
                case 1:
                    dLMCUiFWraubi ^= mDeDKKUdPLQFbJd + 3
                default:
                    dLMCUiFWraubi = (dLMCUiFWraubi + mDeDKKUdPLQFbJd * 5) % 97
                }
            }
            let sUxqfzkjQfhAJeRCFb = rQCjjNrlpszGOScga.map { (($0 * 11) + dLMCUiFWraubi) % 127 }
            let aHDMamnyvRkXC = sUxqfzkjQfhAJeRCFb.filter { ($0 + dLMCUiFWraubi) % 2 == 0 }
            let uLuZjEVmhzPlw = Dictionary(uniqueKeysWithValues: aHDMamnyvRkXC.enumerated().map { ($0.offset, $0.element) })
            for kOTYMjfVcfOrOhhnPImu in uLuZjEVmhzPlw.keys.sorted() {
                dLMCUiFWraubi = (dLMCUiFWraubi + kOTYMjfVcfOrOhhnPImu + (uLuZjEVmhzPlw[kOTYMjfVcfOrOhhnPImu] ?? 0)) % 131
            }
            let yJCcLTrQdmzBBInt = sUxqfzkjQfhAJeRCFb.map { String($0) }.joined(separator: "\u{2d}")
            dLMCUiFWraubi = (dLMCUiFWraubi + yJCcLTrQdmzBBInt.utf8.count) % 137
            _ = dLMCUiFWraubi
        }

        let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword

        
        switch (baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{69}\u{6e}\u{49}\u{74}\u{54}\u{4b}\u{54}\u{37}"))) {
        case true: do {
            return "\(baseURL)\u{2f}\u{73}\u{65}\u{61}\u{72}\u{63}\u{68}\u{3f}\u{70}\u{67}\u{3d}\u{31}\u{26}\u{74}\u{65}\u{78}\u{74}\u{3d}\(encoded)"}
        case false:
            break
        }
        
        switch (baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{30}\u{44}\u{7a}\u{72}\u{6e}\u{74}\u{76}\u{64}"))) {
        case true: do {
            return "\(baseURL)\u{3f}\u{61}\u{63}\u{3d}\u{76}\u{69}\u{64}\u{65}\u{6f}\u{6c}\u{69}\u{73}\u{74}\u{26}\u{77}\u{64}\u{3d}\(encoded)"}
        case false:
            break
        }
        
        switch (baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{4f}\u{55}\u{59}\u{75}\u{44}\u{68}\u{55}\u{52}"))) {
        case true: do {
            return "\(baseURL)\u{2f}\u{73}\u{65}\u{61}\u{72}\u{63}\u{68}\u{3f}\u{70}\u{67}\u{3d}\u{31}\u{26}\u{74}\u{65}\u{78}\u{74}\u{3d}\(encoded)"}
        case false:
            break
        }
        
        switch (baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{6f}\u{76}\u{57}\u{51}\u{64}\u{34}\u{71}\u{44}")) || baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{67}\u{58}\u{33}\u{34}\u{4b}\u{30}\u{7a}\u{42}"))) {
        case true: do {
            return "\(baseURL)\u{2f}\u{73}\u{65}\u{61}\u{72}\u{63}\u{68}\u{3f}\u{70}\u{67}\u{3d}\u{31}\u{26}\u{74}\u{65}\u{78}\u{74}\u{3d}\(encoded)"}
        case false:
            break
        }
        
        switch (baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{6e}\u{34}\u{57}\u{32}\u{76}\u{75}\u{62}\u{32}")) || baseURL.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{37}\u{6b}\u{73}\u{37}\u{62}\u{74}\u{6b}\u{6f}"))) {
        case true: do {
            return "\(baseURL)\u{3f}\u{77}\u{64}\u{3d}\(encoded)"}
        case false:
            break
        }
        
        switch (baseURL.contains("\u{2c}")) {
        case true: do {
            let parts = baseURL.split(separator: "\u{2c}", maxSplits: 1).map(String.init)
            if let first = parts.first {
                return first.replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{4d}\u{45}\u{42}\u{73}\u{46}\u{4d}\u{71}\u{43}"), with: encoded)
            }}
        case false:
            break
        }
        return "\(baseURL)\u{2f}\u{73}\u{65}\u{61}\u{72}\u{63}\u{68}\u{3f}\u{70}\u{67}\u{3d}\u{31}\u{26}\u{74}\u{65}\u{78}\u{74}\u{3d}\(encoded)"
    }

    

    

    

    private static func lRRELUZIrxxb(
        source: [String: Any],
        response: String
    ) -> [PzPGBfDtzkHPSRROQs] {
        
        do {
            let vOTTQAezKsxOLENS = [7, 31, 28]
            var xZnfZjJqVbOffMplu = 0
            for pUebbpTkKaRVJmH in vOTTQAezKsxOLENS {
                switch (xZnfZjJqVbOffMplu + pUebbpTkKaRVJmH) % 3 {
                case 0:
                    xZnfZjJqVbOffMplu = (xZnfZjJqVbOffMplu * 7 + pUebbpTkKaRVJmH) % 101
                case 1:
                    xZnfZjJqVbOffMplu ^= pUebbpTkKaRVJmH + 3
                default:
                    xZnfZjJqVbOffMplu = (xZnfZjJqVbOffMplu + pUebbpTkKaRVJmH * 5) % 97
                }
            }
            let lORgTuPWVIywKKbcsNMM = vOTTQAezKsxOLENS.map { (($0 * 11) + xZnfZjJqVbOffMplu) % 127 }
            let qKEkhVZoOpaTwcbEWvD = lORgTuPWVIywKKbcsNMM.filter { ($0 + xZnfZjJqVbOffMplu) % 2 == 0 }
            let hQGchfxnbZVcExTcXqKL = Dictionary(uniqueKeysWithValues: qKEkhVZoOpaTwcbEWvD.enumerated().map { ($0.offset, $0.element) })
            for qWCYVHpCVrOhhOLT in hQGchfxnbZVcExTcXqKL.keys.sorted() {
                xZnfZjJqVbOffMplu = (xZnfZjJqVbOffMplu + qWCYVHpCVrOhhOLT + (hQGchfxnbZVcExTcXqKL[qWCYVHpCVrOhhOLT] ?? 0)) % 131
            }
            let kOXctwEcTgGRMwUtsw = lORgTuPWVIywKKbcsNMM.map { String($0) }.joined(separator: "\u{2d}")
            xZnfZjJqVbOffMplu = (xZnfZjJqVbOffMplu + kOXctwEcTgGRMwUtsw.utf8.count) % 137
            _ = xZnfZjJqVbOffMplu
        }

        guard let posterRule = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{71}\u{37}\u{32}\u{68}\u{34}\u{48}\u{74}\u{31}")] as? String,
              let linkRule = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{43}\u{4d}\u{57}\u{66}\u{54}\u{79}\u{41}\u{68}")] as? String,
              let nameRule = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{35}\u{6a}\u{52}\u{57}\u{51}\u{77}\u{57}\u{59}")] as? String,
              let statusRule = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{33}\u{73}\u{41}\u{55}\u{6c}\u{76}\u{52}\u{4f}")] as? String else {
            return []
        }

        let images = WgMQRoSLMyWqz.select(html: response, xpath: posterRule)
        let links = WgMQRoSLMyWqz.select(html: response, xpath: linkRule)
        let names = WgMQRoSLMyWqz.select(html: response, xpath: nameRule)
        let statuses = WgMQRoSLMyWqz.select(html: response, xpath: statusRule)

        guard !links.isEmpty else { return [] }

        let sourceName = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{53}\u{6b}\u{32}\u{70}\u{6a}\u{36}\u{62}\u{45}")
        let searchURL = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{4a}\u{44}\u{5a}\u{76}\u{51}\u{51}\u{6b}\u{46}")] as? String ?? ""
        var items: [PzPGBfDtzkHPSRROQs] = []

        for index in 0..<links.count {
            
            var title = index < names.count ? names[index] : ""
            if title.isEmpty {
                title = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{55}\u{73}\u{48}\u{38}\u{56}\u{76}\u{70}\u{36}")
            }

            var status = index < statuses.count ? statuses[index] : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}")
            if status.isEmpty { status = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}") }

            var imageURL = index < images.count ? images[index] : ""
            imageURL = GepYCtjqcrNDt.cImAPetFHcWTFVDzMCv(from: imageURL) ?? imageURL
            imageURL = jBGappuhSRhgyKOcq(imageURL, searchURL: searchURL)

            let detailURL = cOyTKFKCrQAwPZxWzhS(links[index], searchURL: searchURL)

            items.append(
                PzPGBfDtzkHPSRROQs(
                    id: "\(sourceName)\u{2d}\(detailURL)\u{2d}\(title)",
                    title: title,
                    sourceName: sourceName,
                    status: status,
                    imageURL: imageURL,
                    pathId: "",
                    path: detailURL
                )
            )
        }

        return items
    }

    

    

    

    private static func cOyTKFKCrQAwPZxWzhS(_ detailURL: String, searchURL: String) -> String {
        
        do {
            let uFkkgxbUjAUPISqgD = [24, 18, 63]
            var pGUvfyxFuGABhT = 0
            for wGyXMvewPKWJv in uFkkgxbUjAUPISqgD {
                switch (pGUvfyxFuGABhT + wGyXMvewPKWJv) % 3 {
                case 0:
                    pGUvfyxFuGABhT = (pGUvfyxFuGABhT * 7 + wGyXMvewPKWJv) % 101
                case 1:
                    pGUvfyxFuGABhT ^= wGyXMvewPKWJv + 3
                default:
                    pGUvfyxFuGABhT = (pGUvfyxFuGABhT + wGyXMvewPKWJv * 5) % 97
                }
            }
            let dGaxvPhFAIqjTQvDRhg = uFkkgxbUjAUPISqgD.map { (($0 * 11) + pGUvfyxFuGABhT) % 127 }
            let hFqcroftKmMWsIxd = dGaxvPhFAIqjTQvDRhg.filter { ($0 + pGUvfyxFuGABhT) % 2 == 0 }
            let pOChFYRPJzOvvMUI = Dictionary(uniqueKeysWithValues: hFqcroftKmMWsIxd.enumerated().map { ($0.offset, $0.element) })
            for tOvKGuFjRHFbKNhv in pOChFYRPJzOvvMUI.keys.sorted() {
                pGUvfyxFuGABhT = (pGUvfyxFuGABhT + tOvKGuFjRHFbKNhv + (pOChFYRPJzOvvMUI[tOvKGuFjRHFbKNhv] ?? 0)) % 131
            }
            let qNrTVAixpDgcpAXpf = dGaxvPhFAIqjTQvDRhg.map { String($0) }.joined(separator: "\u{2d}")
            pGUvfyxFuGABhT = (pGUvfyxFuGABhT + qNrTVAixpDgcpAXpf.utf8.count) % 137
            _ = pGUvfyxFuGABhT
        }

        
        switch (detailURL.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{4d}\u{41}\u{67}\u{61}\u{64}\u{6f}\u{72}\u{30}"))) {
        case true: do {
            return detailURL}
        case false:
            break
        }

        let isHTTPS = searchURL.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{70}\u{62}\u{4a}\u{43}\u{41}\u{58}\u{74}\u{78}"))
        let protocolPrefix = isHTTPS ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{44}\u{70}\u{42}\u{58}\u{6f}\u{63}\u{5a}\u{58}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{56}\u{36}\u{43}\u{70}\u{66}\u{4c}\u{52}\u{7a}")

        guard let schemeRange = searchURL.range(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{4e}\u{36}\u{6b}\u{44}\u{53}\u{61}\u{51}\u{77}")),
              let slashRange = searchURL[schemeRange.upperBound...].firstIndex(of: "\u{2f}") else {
            return detailURL
        }

        let domain = String(searchURL[schemeRange.upperBound..<slashRange])
        return "\(protocolPrefix)\(domain)\(detailURL)"
    }

    

    private static func qLUpRjqRysIo(
        response: String,
        requestURL: String
    ) -> [String: Any]? {
        
        do {
            let jEAfohSVVEwMiKgu = [20, 61, 61]
            var pVIhfDQasXLTeavMa = 0
            for uINvDJpPmPvCCqwpLpcZ in jEAfohSVVEwMiKgu {
                switch (pVIhfDQasXLTeavMa + uINvDJpPmPvCCqwpLpcZ) % 3 {
                case 0:
                    pVIhfDQasXLTeavMa = (pVIhfDQasXLTeavMa * 7 + uINvDJpPmPvCCqwpLpcZ) % 101
                case 1:
                    pVIhfDQasXLTeavMa ^= uINvDJpPmPvCCqwpLpcZ + 3
                default:
                    pVIhfDQasXLTeavMa = (pVIhfDQasXLTeavMa + uINvDJpPmPvCCqwpLpcZ * 5) % 97
                }
            }
            let nHHNRPIoVRJr = jEAfohSVVEwMiKgu.map { (($0 * 11) + pVIhfDQasXLTeavMa) % 127 }
            let jMcsnLqzpdaBvl = nHHNRPIoVRJr.filter { ($0 + pVIhfDQasXLTeavMa) % 2 == 0 }
            let hIUIlRiwazIwiApo = Dictionary(uniqueKeysWithValues: jMcsnLqzpdaBvl.enumerated().map { ($0.offset, $0.element) })
            for fOiOdorRSATFTluxgWuY in hIUIlRiwazIwiApo.keys.sorted() {
                pVIhfDQasXLTeavMa = (pVIhfDQasXLTeavMa + fOiOdorRSATFTluxgWuY + (hIUIlRiwazIwiApo[fOiOdorRSATFTluxgWuY] ?? 0)) % 131
            }
            let kJOneOBCppQi = nHHNRPIoVRJr.map { String($0) }.joined(separator: "\u{2d}")
            pVIhfDQasXLTeavMa = (pVIhfDQasXLTeavMa + kJOneOBCppQi.utf8.count) % 137
            _ = pVIhfDQasXLTeavMa
        }

        if let domain = xOxlxZJmzibcV(from: requestURL), domain.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{6c}\u{6d}\u{64}\u{37}\u{53}\u{4a}\u{4c}\u{77}")) {
            if let decrypted = TtDfizBQZfgNxud.fWClHevSqKPRfpyyJ(response) {
                return decrypted
            }
        }

        return TtDfizBQZfgNxud.kKMMvkwqoOpRnt(response)
    }

    private static func kLHlzanZqcklpEimj(url: String, realURI: String) -> Bool {
        
        do {
            let xDahtjiIaYMuGWBAV = [47, 17, 66]
            var xKPdXiqQxVLfS = 0
            for kQKmtQEQFCGLluixNW in xDahtjiIaYMuGWBAV {
                switch (xKPdXiqQxVLfS + kQKmtQEQFCGLluixNW) % 3 {
                case 0:
                    xKPdXiqQxVLfS = (xKPdXiqQxVLfS * 7 + kQKmtQEQFCGLluixNW) % 101
                case 1:
                    xKPdXiqQxVLfS ^= kQKmtQEQFCGLluixNW + 3
                default:
                    xKPdXiqQxVLfS = (xKPdXiqQxVLfS + kQKmtQEQFCGLluixNW * 5) % 97
                }
            }
            let uFjnlIMQdoqApL = xDahtjiIaYMuGWBAV.map { (($0 * 11) + xKPdXiqQxVLfS) % 127 }
            let mIAChndgiEYoUuGca = uFjnlIMQdoqApL.filter { ($0 + xKPdXiqQxVLfS) % 2 == 0 }
            let hJDjWTPIHkFd = Dictionary(uniqueKeysWithValues: mIAChndgiEYoUuGca.enumerated().map { ($0.offset, $0.element) })
            for gJEdeuSrzxGDWB in hJDjWTPIHkFd.keys.sorted() {
                xKPdXiqQxVLfS = (xKPdXiqQxVLfS + gJEdeuSrzxGDWB + (hJDjWTPIHkFd[gJEdeuSrzxGDWB] ?? 0)) % 131
            }
            let tPzwKECXlKKOzcCnEm = uFjnlIMQdoqApL.map { String($0) }.joined(separator: "\u{2d}")
            xKPdXiqQxVLfS = (xKPdXiqQxVLfS + tPzwKECXlKKOzcCnEm.utf8.count) % 137
            _ = xKPdXiqQxVLfS
        }

        guard let domain = xOxlxZJmzibcV(from: url), !domain.isEmpty else {
            return false
        }
        return realURI.contains(domain)
    }

    

    private static func bKcBSmRoPulWMeulc(_ source: [String: Any]) -> Bool {
        
        do {
            let dGybpApBJNNgQWE = [46, 52, 15]
            var lVkvRZCDctiZK = 0
            for mVsZBgkBAmUWnMmZ in dGybpApBJNNgQWE {
                switch (lVkvRZCDctiZK + mVsZBgkBAmUWnMmZ) % 3 {
                case 0:
                    lVkvRZCDctiZK = (lVkvRZCDctiZK * 7 + mVsZBgkBAmUWnMmZ) % 101
                case 1:
                    lVkvRZCDctiZK ^= mVsZBgkBAmUWnMmZ + 3
                default:
                    lVkvRZCDctiZK = (lVkvRZCDctiZK + mVsZBgkBAmUWnMmZ * 5) % 97
                }
            }
            let fGzsLkLsuZylYBcmzj = dGybpApBJNNgQWE.map { (($0 * 11) + lVkvRZCDctiZK) % 127 }
            let bTgbWFLLaiRi = fGzsLkLsuZylYBcmzj.filter { ($0 + lVkvRZCDctiZK) % 2 == 0 }
            let jRmFqNjTMDKAUsaz = Dictionary(uniqueKeysWithValues: bTgbWFLLaiRi.enumerated().map { ($0.offset, $0.element) })
            for aAtxIZJlzYCNzxp in jRmFqNjTMDKAUsaz.keys.sorted() {
                lVkvRZCDctiZK = (lVkvRZCDctiZK + aAtxIZJlzYCNzxp + (jRmFqNjTMDKAUsaz[aAtxIZJlzYCNzxp] ?? 0)) % 131
            }
            let rTpDDwLrjaYbXYABn = fGzsLkLsuZylYBcmzj.map { String($0) }.joined(separator: "\u{2d}")
            lVkvRZCDctiZK = (lVkvRZCDctiZK + rTpDDwLrjaYbXYABn.utf8.count) % 137
            _ = lVkvRZCDctiZK
        }

        
        switch (source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6d}\u{42}\u{39}\u{54}\u{65}\u{4e}\u{38}\u{68}\u{46}")] as? String == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{58}\u{66}\u{69}\u{51}\u{30}\u{43}\u{63}\u{77}")) {
        case true: do {
            return true}
        case false:
            break
        }
        if let enabled = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{49}\u{56}\u{43}\u{66}\u{38}\u{67}\u{6f}\u{68}")] as? Bool {
            return enabled
        }
        if let enabled = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{49}\u{56}\u{43}\u{66}\u{38}\u{67}\u{6f}\u{68}")] as? String {
            return enabled == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{56}\u{6b}\u{6b}\u{56}\u{4b}\u{71}\u{59}\u{47}")
        }
        return false
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kYjTuGtYHjWsfept() -> String {
        _ = Self.rEvTASuYFxoaGXoybo()
        _ = Self.eIyXizEFePpSV()
        _ = Self.fBLKbTyQhEqdqjWpRDRB()
        _ = Self.xYcBmeJmDBMcfoubKIP()
        let base = (82 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 82) * 7
        let token = "\u{65}\u{36}\u{34}\u{39}\u{64}\u{38}\u{36}\u{63}\u{65}\u{33}\u{61}\u{31}\u{36}\u{63}\u{39}\u{39}\u{36}\u{62}\u{62}\u{61}\u{64}\u{30}\u{62}\u{65}"
        _ = Self.dNPKFPjhuVtYj()
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func dNPKFPjhuVtYj() -> String {
        let values = [70, 72, 140, 87]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 70) * 2
        let token = "\u{32}\u{65}\u{63}\u{37}\u{33}\u{61}\u{38}\u{61}\u{36}\u{64}\u{33}\u{61}\u{37}\u{34}\u{64}\u{35}\u{39}\u{34}\u{62}\u{33}\u{34}\u{62}\u{62}\u{30}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func xYcBmeJmDBMcfoubKIP() -> String {
        let token = "\u{34}\u{36}\u{33}\u{36}\u{30}\u{65}\u{64}\u{65}\u{36}\u{63}\u{64}\u{66}\u{33}\u{66}\u{35}\u{35}\u{38}\u{63}\u{32}\u{33}\u{34}\u{65}\u{31}\u{66}"
        let base = (48 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 48) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func eIyXizEFePpSV() -> String {
        let token = "\u{61}\u{38}\u{65}\u{62}\u{66}\u{61}\u{32}\u{31}\u{38}\u{30}\u{61}\u{32}\u{30}\u{63}\u{62}\u{65}\u{37}\u{33}\u{61}\u{61}\u{30}\u{34}\u{65}\u{65}"
        let source = "\u{61}\u{38}\u{65}\u{62}\u{66}\u{61}\u{32}\u{31}\u{38}\u{30}\u{61}\u{32}\u{30}\u{63}\u{62}\u{65}\u{37}\u{33}\u{61}\u{61}\u{30}\u{34}\u{65}\u{65}\u{2d}\u{34}\u{34}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 44) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func rEvTASuYFxoaGXoybo() -> String {
        let token = "\u{38}\u{62}\u{39}\u{32}\u{63}\u{64}\u{31}\u{31}\u{62}\u{32}\u{31}\u{36}\u{37}\u{36}\u{65}\u{34}\u{36}\u{37}\u{36}\u{65}\u{34}\u{37}\u{61}\u{34}"
        let base = (62 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 62) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func fBLKbTyQhEqdqjWpRDRB() -> String {
        let token = "\u{32}\u{33}\u{39}\u{34}\u{39}\u{38}\u{34}\u{65}\u{38}\u{61}\u{34}\u{34}\u{61}\u{64}\u{35}\u{35}\u{34}\u{62}\u{66}\u{33}\u{61}\u{66}\u{32}\u{30}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 9) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension OuXdUjLJRmBbgUhANKSu {
    private static func tMqVpoftNgbkiupaXopq(
        source: [String: Any],
        response: String,
        realURI: String
    ) -> [PzPGBfDtzkHPSRROQs] {
        let requestURL = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{6a}\u{73}\u{4b}\u{67}\u{54}\u{43}\u{49}\u{51}")] as? String ?? ""
        guard kLHlzanZqcklpEimj(url: requestURL, realURI: realURI) else {
            return []
        }

        let sourceName = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{53}\u{6b}\u{32}\u{70}\u{6a}\u{36}\u{62}\u{45}")
        let jsonObject = qLUpRjqRysIo(response: response, requestURL: requestURL)
        guard let jsjx = jsonObject else { return [] }

        let webpageSourceCode = (try? String(data: JSONSerialization.data(withJSONObject: jsjx), encoding: .utf8)) ?? ""
        let jxlist: [[String: Any]]

        if webpageSourceCode.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{50}\u{79}\u{31}\u{69}\u{63}\u{55}\u{75}\u{34}")) && webpageSourceCode.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{6b}\u{4c}\u{48}\u{38}\u{35}\u{62}\u{4b}\u{45}")),
           let data = jsjx[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{59}\u{59}\u{46}\u{6d}\u{63}\u{30}\u{4d}")] as? [[String: Any]] {
            jxlist = data
        } else if webpageSourceCode.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{59}\u{59}\u{46}\u{6d}\u{63}\u{30}\u{4d}")) && webpageSourceCode.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{34}\u{41}\u{79}\u{67}\u{54}\u{64}\u{62}\u{52}")),
                  let data = jsjx[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{59}\u{59}\u{46}\u{6d}\u{63}\u{30}\u{4d}")] as? [String: Any],
                  let list = data[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{34}\u{41}\u{79}\u{67}\u{54}\u{64}\u{62}\u{52}")] as? [[String: Any]] {
            jxlist = list
        } else if let data = jsjx[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{59}\u{59}\u{46}\u{6d}\u{63}\u{30}\u{4d}")] as? [[String: Any]] {
            jxlist = data
        } else if let list = jsjx[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{34}\u{41}\u{79}\u{67}\u{54}\u{64}\u{62}\u{52}")] as? [[String: Any]] {
            jxlist = list
        } else {
            return []
        }

        if jxlist.isEmpty { return [] }

        return jxlist.compactMap { item in
            let title = (item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{69}\u{58}\u{73}\u{69}\u{70}\u{61}\u{69}\u{79}")] ?? item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{50}\u{79}\u{31}\u{69}\u{63}\u{55}\u{75}\u{34}")]).map { String(describing: $0) } ?? ""
            let imageRaw = (item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{65}\u{72}\u{38}\u{46}\u{52}\u{58}\u{43}\u{77}")] ?? item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{47}\u{54}\u{49}\u{37}\u{35}\u{7a}\u{7a}\u{72}")]).map { String(describing: $0) } ?? ""
            let imageURL = GepYCtjqcrNDt.cImAPetFHcWTFVDzMCv(from: imageRaw) ?? imageRaw
            var status = (item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{65}\u{77}\u{6d}\u{41}\u{69}\u{44}\u{4a}\u{41}")] ?? item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{67}\u{73}\u{32}\u{6f}\u{52}\u{37}\u{51}\u{4c}")]).map { String(describing: $0) } ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}")
            if status.isEmpty { status = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}") }

            let pathId = (item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{65}\u{31}\u{4c}\u{51}\u{54}\u{34}\u{46}\u{53}")] ?? item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{78}\u{67}\u{50}\u{6b}\u{56}\u{33}\u{33}")]).map { String(describing: $0) } ?? ""
            let path = requestURL

            guard !title.isEmpty else { return nil }

            return PzPGBfDtzkHPSRROQs(
                id: "\(sourceName)\u{2d}\(pathId)\u{2d}\(title)",
                title: title,
                sourceName: sourceName,
                status: status,
                imageURL: imageURL,
                pathId: pathId,
                path: path
            )
        }
    }

    private static func iOjrmVOUPhrreRsiQ(
        source: [String: Any],
        keyword: String,
        sourceIndex: Int
    ) async -> KlkwtQJcDoqqkNfKrkYt? {
        let built: KlkwtQJcDoqqkNfKrkYt?
        if bKcBSmRoPulWMeulc(source) {
            built = await yYTBJBuamoTvsaf(source: source, keyword: keyword)
        } else if (source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6d}\u{42}\u{39}\u{54}\u{65}\u{4e}\u{38}\u{68}\u{46}")] as? String) == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{71}\u{74}\u{4f}\u{39}\u{38}\u{44}\u{46}\u{37}") {
            built = mPhFSkOmJUaGjTf(source: source, keyword: keyword)
        } else {
            built = vOFUDzlLMujRwpvPQXBK(source: source, keyword: keyword)
        }
        guard let built else { return nil }
        return KlkwtQJcDoqqkNfKrkYt(
            url: built.url,
            method: built.method,
            data: built.data,
            headers: built.headers,
            sourceIndex: sourceIndex
        )
    }

    private static func iIfipxVYOgyp(
        source: [String: Any],
        response: String
    ) async -> [PzPGBfDtzkHPSRROQs] {
        guard let rule = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{4c}\u{6b}\u{55}\u{51}\u{30}\u{6f}\u{35}\u{75}")] as? String else { return [] }

        let sourceName = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{53}\u{6b}\u{32}\u{70}\u{6a}\u{36}\u{62}\u{45}")
        let requestURL = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{6a}\u{73}\u{4b}\u{67}\u{54}\u{43}\u{49}\u{51}")] as? String ?? ""
        let rows = await FuxFtdCxEOVcXv.hVEJiyJQMufvhF(rule: rule, response: response)

        return rows.compactMap { row in
            guard row.count >= 4 else { return nil }

            let title = row[0]
            guard !title.isEmpty else { return nil }

            var status = row[1]
            if status.isEmpty { status = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}") }

            let imageRaw = row[2]
            let imageURL = GepYCtjqcrNDt.cImAPetFHcWTFVDzMCv(from: imageRaw) ?? imageRaw
            let pathId = row[3]

            return PzPGBfDtzkHPSRROQs(
                id: "\(sourceName)\u{2d}\(pathId)\u{2d}\(title)",
                title: title,
                sourceName: sourceName,
                status: status,
                imageURL: imageURL,
                pathId: pathId,
                path: requestURL
            )
        }
    }

    private static func mRYVLhSqARkRvoKo(
        source: [String: Any],
        response: String,
        realURI: String
    ) -> [PzPGBfDtzkHPSRROQs] {
        let searchAPI = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{30}\u{76}\u{45}\u{41}\u{54}\u{6b}\u{59}\u{6f}")] as? String ?? ""
        let matchURL = searchAPI.isEmpty
            ? (source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{4a}\u{44}\u{5a}\u{76}\u{51}\u{51}\u{6b}\u{46}")] as? String ?? "")
            : searchAPI

        guard kLHlzanZqcklpEimj(url: matchURL, realURI: realURI) else {
            return []
        }

        if searchAPI.isEmpty {
            return lRRELUZIrxxb(source: source, response: response)
        }

        guard let data = response.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return []
        }

        if (json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{67}\u{73}\u{32}\u{6f}\u{52}\u{37}\u{51}\u{4c}")] as? String) == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{35}\u{30}\u{77}\u{77}\u{67}\u{39}\u{65}\u{46}") {
            return []
        }

        guard let list = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{34}\u{41}\u{79}\u{67}\u{54}\u{64}\u{62}\u{52}")] as? [[String: Any]] else {
            return []
        }

        let sourceName = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{53}\u{6b}\u{32}\u{70}\u{6a}\u{36}\u{62}\u{45}")
        let pageLinkTemplate = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{35}\u{6d}\u{51}\u{78}\u{78}\u{50}\u{63}\u{43}")] as? String ?? ""

        return list.compactMap { item in
            let title = item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{30}\u{4b}\u{72}\u{57}\u{33}\u{6c}\u{48}\u{4f}")] as? String ?? ""
            let webID = item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{78}\u{67}\u{50}\u{6b}\u{56}\u{33}\u{33}")]
            let webIDText = webID.map { String(describing: $0) } ?? ""
            let pic = item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{68}\u{41}\u{51}\u{57}\u{4c}\u{4e}\u{57}\u{4d}")] as? String ?? ""
            let imageURL = GepYCtjqcrNDt.cImAPetFHcWTFVDzMCv(from: pic) ?? pic
            let detailURL = pageLinkTemplate.replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{5a}\u{47}\u{73}\u{43}\u{73}\u{39}\u{34}\u{76}"), with: webIDText)

            guard !title.isEmpty else { return nil }

            return PzPGBfDtzkHPSRROQs(
                id: "\(sourceName)\u{2d}\(webIDText)\u{2d}\(title)",
                title: title,
                sourceName: sourceName,
                status: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}"),
                imageURL: imageURL,
                pathId: webIDText,
                path: detailURL
            )
        }
    }

    private static func jBGappuhSRhgyKOcq(_ image: String, searchURL: String) -> String {
        if image.contains("\u{3d}"),
           let regex = try? NSRegularExpression(pattern: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{79}\u{7a}\u{56}\u{39}\u{33}\u{66}\u{61}\u{56}")),
           let match = regex.firstMatch(
               in: image,
               range: NSRange(image.startIndex..<image.endIndex, in: image)
           ),
           let range = Range(match.range(at: 1), in: image) {
            return String(image[range])
        }

        if image.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{4d}\u{41}\u{67}\u{61}\u{64}\u{6f}\u{72}\u{30}")) {
            return image
        }

        guard let protocolPart = jMkWIjNlQwSyOIkWFoo(searchURL, pattern: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{6c}\u{4b}\u{47}\u{4b}\u{6f}\u{37}\u{57}\u{39}")),
              let domainPart = jMkWIjNlQwSyOIkWFoo(searchURL, pattern: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{4b}\u{35}\u{71}\u{79}\u{58}\u{6f}\u{57}\u{57}")) else {
            return image
        }

        return "\u{68}\u{74}\u{74}\u{70}\(protocolPart)\u{2f}\u{2f}\(domainPart)\(image)"
    }

    private static func jMkWIjNlQwSyOIkWFoo(_ text: String, pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(
                in: text,
                range: NSRange(text.startIndex..<text.endIndex, in: text)
              ),
              let range = Range(match.range(at: 1), in: text) else {
            return nil
        }
        return String(text[range])
    }

    private static func xOxlxZJmzibcV(from url: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{4b}\u{35}\u{71}\u{79}\u{58}\u{6f}\u{57}\u{57}")),
              let match = regex.firstMatch(
                in: url,
                range: NSRange(url.startIndex..<url.endIndex, in: url)
              ),
              let range = Range(match.range(at: 1), in: url) else {
            return nil
        }
        return String(url[range])
    }

    private static func yYTBJBuamoTvsaf(
        source: [String: Any],
        keyword: String
    ) async -> KlkwtQJcDoqqkNfKrkYt? {
        guard let rule = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{4c}\u{6b}\u{55}\u{51}\u{30}\u{6f}\u{35}\u{75}")] as? String,
              let baseURL = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{6a}\u{73}\u{4b}\u{67}\u{54}\u{43}\u{49}\u{51}")] as? String else {
            return nil
        }

        return await FuxFtdCxEOVcXv.sEnIoJemAKfKdmevE(
            rule: rule,
            baseURL: baseURL,
            keyword: keyword
        )
    }
}
