









import Foundation

@MainActor
enum FuxFtdCxEOVcXv {

    

    static func sEnIoJemAKfKdmevE(
        rule: String,
        baseURL: String,
        keyword: String
    ) async -> KlkwtQJcDoqqkNfKrkYt? {
        // source-obfuscator:padding:v1
        _ = Self.jDmCPFNoCTpg()

        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule),
              let urlArray = try? await aEyhHBGLxwtIid.aXvFZHktziGrSToOxB(
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{76}\u{6a}\u{6b}\u{61}\u{6e}\u{37}\u{55}\u{35}"),
                args: [baseURL, keyword]
              ),
              urlArray.count >= 2,
              let url = TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[1]),
              !url.isEmpty else {
            return nil
        }

        let method = (TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[0]) ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{61}\u{34}\u{6e}\u{45}\u{47}\u{54}\u{45}\u{4a}")).uppercased()
        let body = urlArray.count > 2 ? TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[2]) : nil
        let headers = await gEGrEirqBXAfyWVP(aEyhHBGLxwtIid: aEyhHBGLxwtIid, function: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{68}\u{76}\u{4c}\u{43}\u{72}\u{6d}\u{6d}\u{63}"))

        return KlkwtQJcDoqqkNfKrkYt(
            url: url,
            method: method,
            data: body,
            headers: headers
        )
    }

    static func hVEJiyJQMufvhF(rule: String, response: String) async -> [[String]] {
        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule),
              let rows = try? await aEyhHBGLxwtIid.aXvFZHktziGrSToOxB(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{61}\u{4b}\u{62}\u{6c}\u{51}\u{55}\u{66}\u{77}"), args: [response]) else {
            return []
        }

        return rows.compactMap { row in
            guard let values = row as? [Any] else { return nil }
            return values.map { TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk($0) ?? "" }
        }
    }

    

    

    struct HwPDouJCOokeqe {
        let actor: String
        let status: String
        let intro: String
    }

    struct BlcHzhFALZGTeXz {
        let name: String
        let detail: Any?
        let sourceTag: String
    }

    

    

    struct VzLChgfcWlGKNpfyuhUF {
        let method: String
        let url: String
        let body: String?
        let headers: [String: String]
    }

    

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jDmCPFNoCTpg() -> String {
        _ = Self.cKtDROimzDaqdSoKPjb()
        let base = (3 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 3) * 5
        let token = "\u{64}\u{33}\u{66}\u{39}\u{34}\u{36}\u{34}\u{31}\u{61}\u{36}\u{63}\u{64}\u{33}\u{33}\u{32}\u{33}\u{61}\u{65}\u{32}\u{38}\u{62}\u{34}\u{65}\u{66}"
        _ = Self.zTrlFmqLBvrd()
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func zTrlFmqLBvrd() -> String {
        let base = (29 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 29) * 7
        let token = "\u{64}\u{38}\u{66}\u{31}\u{62}\u{35}\u{34}\u{32}\u{35}\u{36}\u{36}\u{36}\u{61}\u{30}\u{39}\u{33}\u{34}\u{66}\u{38}\u{66}\u{63}\u{31}\u{32}\u{38}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func cKtDROimzDaqdSoKPjb() -> String {
        let token = "\u{64}\u{62}\u{34}\u{37}\u{61}\u{31}\u{37}\u{37}\u{39}\u{62}\u{38}\u{66}\u{65}\u{63}\u{33}\u{63}\u{36}\u{64}\u{35}\u{30}\u{62}\u{32}\u{30}\u{62}"
        let values = [19, 22, 57, 36]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 19) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension FuxFtdCxEOVcXv {
    private static func gEGrEirqBXAfyWVP(
        aEyhHBGLxwtIid: DsUfbDxzJNTEGoDtXLj,
        function: String
    ) async -> [String: String] {
        guard let raw = try? await aEyhHBGLxwtIid.nUSHBdBnpFzLwOwdcv(function), !raw.isEmpty else {
            return [:]
        }
        return TtDfizBQZfgNxud.aVsCZqLjzAieKnJ(raw)
    }

    static func gAICKBVxraEqoxN(
        rule: String,
        baseURL: String,
        videoLinkId: String
    ) async -> KlkwtQJcDoqqkNfKrkYt? {
        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule),
              let urlArray = try? await aEyhHBGLxwtIid.aXvFZHktziGrSToOxB(
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{41}\u{62}\u{59}\u{30}\u{65}\u{67}\u{72}\u{68}"),
                args: [baseURL, videoLinkId]
              ),
              urlArray.count >= 2,
              let url = TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[1]),
              !url.isEmpty else {
            return nil
        }

        let method = (TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[0]) ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{61}\u{34}\u{6e}\u{45}\u{47}\u{54}\u{45}\u{4a}")).uppercased()
        let body = urlArray.count > 2 ? TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[2]) : nil
        let headers = await gEGrEirqBXAfyWVP(aEyhHBGLxwtIid: aEyhHBGLxwtIid, function: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{47}\u{7a}\u{31}\u{35}\u{39}\u{53}\u{44}\u{39}"))

        return KlkwtQJcDoqqkNfKrkYt(
            url: url,
            method: method,
            data: body,
            headers: headers
        )
    }

    static func aMpwrsNULkXmwGEw(
        rule: String,
        episodeURL: String,
        sourceTag: String
    ) async -> VzLChgfcWlGKNpfyuhUF? {
        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule),
              let urlArray = try? await aEyhHBGLxwtIid.aXvFZHktziGrSToOxB(
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{49}\u{65}\u{6d}\u{64}\u{78}\u{53}\u{46}\u{79}"),
                args: [episodeURL, sourceTag]
              ),
              urlArray.count >= 2 else {
            return nil
        }

        let method = TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[0]) ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{61}\u{34}\u{6e}\u{45}\u{47}\u{54}\u{45}\u{4a}")
        let body = urlArray.count > 2 ? TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[2]) : nil

        
        let fields = TtDfizBQZfgNxud.aVsCZqLjzAieKnJ(TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(urlArray[1]) ?? "")
        var headers = fields
        let url = headers.removeValue(forKey: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{30}\u{67}\u{70}\u{6f}\u{4d}\u{56}\u{46}\u{4c}")) ?? ""

        guard !url.isEmpty else { return nil }

        return VzLChgfcWlGKNpfyuhUF(method: method, url: url, body: body, headers: headers)
    }

    static func jFPBhOrVgxZcbxcEPZJ(
        rule: String,
        response: String
    ) async -> (meta: HwPDouJCOokeqe, lines: [BlcHzhFALZGTeXz])? {
        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule),
              let data = try? await aEyhHBGLxwtIid.aXvFZHktziGrSToOxB(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{53}\u{74}\u{4a}\u{33}\u{6a}\u{53}\u{72}\u{63}"), args: [response]),
              !data.isEmpty else {
            return nil
        }

        var actor = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}")
        var status = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}")
        var intro = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}")

        if let metaRows = data[0] as? [Any] {
            
            let fields = (metaRows.first as? [Any]) ?? metaRows
            if fields.count > 0 { actor = TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(fields[0]) ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}") }
            if fields.count > 1 { status = TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(fields[1]) ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}") }
            if fields.count > 2 { intro = TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(fields[2]) ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}") }
        }

        guard data.count > 1, let lineRows = data[1] as? [Any], !lineRows.isEmpty else {
            return nil
        }

        
        let lines: [BlcHzhFALZGTeXz] = lineRows.compactMap { row in
            guard let values = row as? [Any], values.count >= 2 else { return nil }

            return BlcHzhFALZGTeXz(
                name: TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(values[0]) ?? "",
                detail: values[1],
                sourceTag: values.count > 3 ? (TtDfizBQZfgNxud.iMQAkKyRdbxKlGnkmk(values[3]) ?? "") : ""
            )
        }

        guard !lines.isEmpty else { return nil }

        return (HwPDouJCOokeqe(actor: actor, status: status, intro: intro), lines)
    }

    static func aXCHQsdDyYvadPvot(rule: String) async -> [String: String] {
        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule) else {
            return [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{38}\u{32}\u{68}\u{4b}\u{37}\u{64}\u{4d}\u{36}"): LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()]
        }

        let headers = await gEGrEirqBXAfyWVP(aEyhHBGLxwtIid: aEyhHBGLxwtIid, function: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{73}\u{79}\u{66}\u{4c}\u{5a}\u{66}\u{55}\u{45}"))
        return headers.isEmpty ? [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{38}\u{32}\u{68}\u{4b}\u{37}\u{64}\u{4d}\u{36}"): LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()] : headers
    }

    static func hMcijHaasWHyUodIm(
        rule: String,
        response: String,
        sourceTag: String
    ) async -> String? {
        guard let aEyhHBGLxwtIid = OjARBePFYkGOKHQPyt.aEyhHBGLxwtIid(for: rule),
              let result = try? await aEyhHBGLxwtIid.nUSHBdBnpFzLwOwdcv(
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6d}\u{52}\u{4c}\u{4f}\u{43}\u{64}\u{56}\u{56}\u{6a}"),
                args: [response, sourceTag]
              ),
              !result.isEmpty else {
            return nil
        }
        return result
    }
}
