






import Foundation

enum XeLsbpDHHfMQ: String {
    case movie
    case tv
}

struct LbnNqTgdpeAicW {
    let weekly: [RwxvTSHANrTeJWJ]
    let yearTabs: [SiWvtvcRnfCnlXxQdJX]
    let movieCategoryTabs: [SiWvtvcRnfCnlXxQdJX]
    let tvCategoryTabs: [SiWvtvcRnfCnlXxQdJX]
}

struct YawiusCPTRnJHUFBYK {
    let items: [YbfRUDRMWBvXF]
    let collection: RwxvTSHANrTeJWJ?
}

protocol AHRankRepository {
    func loadShell() async throws -> LbnNqTgdpeAicW
    func loadYear(year: String) async throws -> [RwxvTSHANrTeJWJ]
    func loadCategory(kind: XeLsbpDHHfMQ, key: String) async throws -> [RwxvTSHANrTeJWJ]
    func loadItems(collectionID: String) async throws -> YawiusCPTRnJHUFBYK
}

struct McoIbVrGXduq: AHRankRepository {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        // source-obfuscator:padding:v1
        _ = Self.qGltXHDEUzdtF()

        self.session = session
        self.decoder = decoder
    }

    

    

    func loadCategory(kind: XeLsbpDHHfMQ, key: String) async throws -> [RwxvTSHANrTeJWJ] {
        let path = kind == .movie
            ? "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{2f}\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{79}\u{5f}\u{72}\u{61}\u{6e}\u{6b}\u{73}"
            : "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{74}\u{76}\u{2f}\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{79}\u{5f}\u{72}\u{61}\u{6e}\u{6b}\u{73}"
        let data = try await AniKjrmweMtR.rGoBpQdxzjbCfr(
            path: path,
            extraQuery: [
                URLQueryItem(name: "\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{79}", value: key),
                URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: "\u{30}"),
                URLQueryItem(name: "\u{63}\u{6f}\u{75}\u{6e}\u{74}", value: "\u{32}\u{30}")
            ],
            session: session
        )
        return try decoder.decode(JiGAfdsKZedtA.self, from: data).selectedCollections
    }

    func loadItems(collectionID: String) async throws -> YawiusCPTRnJHUFBYK {
        let data = try await AniKjrmweMtR.rGoBpQdxzjbCfr(
            path: "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\(collectionID)\u{2f}\u{69}\u{74}\u{65}\u{6d}\u{73}",
            extraQuery: [
                URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: "\u{30}"),
                URLQueryItem(name: "\u{63}\u{6f}\u{75}\u{6e}\u{74}", value: "\u{33}\u{30}"),
                URLQueryItem(name: "\u{75}\u{70}\u{64}\u{61}\u{74}\u{65}\u{64}\u{5f}\u{61}\u{74}", value: ""),
                URLQueryItem(name: "\u{69}\u{74}\u{65}\u{6d}\u{73}\u{5f}\u{6f}\u{6e}\u{6c}\u{79}", value: "\u{30}")
            ],
            session: session
        )
        let response = try decoder.decode(YfUSSijIbiZRZMywHI.self, from: data)
        return YawiusCPTRnJHUFBYK(
            items: response.subjectCollectionItems,
            collection: response.subjectCollection
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qGltXHDEUzdtF() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 79) * 7
        let token = "\u{65}\u{63}\u{34}\u{62}\u{62}\u{66}\u{30}\u{34}\u{34}\u{61}\u{65}\u{38}\u{33}\u{34}\u{32}\u{32}\u{32}\u{63}\u{32}\u{34}\u{36}\u{66}\u{33}\u{64}"
        _ = Self.gLkJMeggpzqGYe()
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func gLkJMeggpzqGYe() -> String {
        let token = "\u{30}\u{35}\u{35}\u{34}\u{35}\u{33}\u{33}\u{34}\u{61}\u{62}\u{31}\u{31}\u{39}\u{66}\u{35}\u{38}\u{37}\u{62}\u{35}\u{38}\u{37}\u{31}\u{33}\u{65}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{36}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 6) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension McoIbVrGXduq {
    func loadYear(year: String) async throws -> [RwxvTSHANrTeJWJ] {
        async let movieData = AniKjrmweMtR.rGoBpQdxzjbCfr(
            path: "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{2f}\u{79}\u{65}\u{61}\u{72}\u{5f}\u{72}\u{61}\u{6e}\u{6b}\u{73}",
            extraQuery: [URLQueryItem(name: "\u{79}\u{65}\u{61}\u{72}", value: year)],
            session: session
        )
        async let tvData = AniKjrmweMtR.rGoBpQdxzjbCfr(
            path: "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{74}\u{76}\u{2f}\u{79}\u{65}\u{61}\u{72}\u{5f}\u{72}\u{61}\u{6e}\u{6b}\u{73}",
            extraQuery: [URLQueryItem(name: "\u{79}\u{65}\u{61}\u{72}", value: year)],
            session: session
        )

        let movie = try decoder.decode(GsUIobuTSMMM.self, from: try await movieData)
        let tv = try decoder.decode(GsUIobuTSMMM.self, from: try await tvData)
        return movie.groups.flatMap(\.selectedCollections) + tv.groups.flatMap(\.selectedCollections)
    }

    func loadShell() async throws -> LbnNqTgdpeAicW {
        async let movieData = AniKjrmweMtR.rGoBpQdxzjbCfr(path: "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{2f}\u{72}\u{61}\u{6e}\u{6b}\u{5f}\u{6c}\u{69}\u{73}\u{74}", session: session)
        async let tvData = AniKjrmweMtR.rGoBpQdxzjbCfr(path: "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{74}\u{76}\u{2f}\u{72}\u{61}\u{6e}\u{6b}\u{5f}\u{6c}\u{69}\u{73}\u{74}", session: session)

        let movie = try decoder.decode(PikKJcTaoCEJw.self, from: try await movieData)
        let tv = try decoder.decode(PikKJcTaoCEJw.self, from: try await tvData)

        let movieWeekly = movie.groups.first(where: { $0.type == "\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}" })?.selectedCollections ?? []
        let tvWeekly = tv.groups.first(where: { $0.type == "\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}" })?.selectedCollections ?? []

        var weekly: [RwxvTSHANrTeJWJ] = []
        if let movieBest = movieWeekly.first(where: { $0.id == "\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{5f}\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}\u{5f}\u{62}\u{65}\u{73}\u{74}" }) {
            weekly.append(movieBest)
        }

        for id in [
            "\u{74}\u{76}\u{5f}\u{63}\u{68}\u{69}\u{6e}\u{65}\u{73}\u{65}\u{5f}\u{62}\u{65}\u{73}\u{74}\u{5f}\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}",
            "\u{74}\u{76}\u{5f}\u{67}\u{6c}\u{6f}\u{62}\u{61}\u{6c}\u{5f}\u{62}\u{65}\u{73}\u{74}\u{5f}\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}",
            "\u{73}\u{68}\u{6f}\u{77}\u{5f}\u{63}\u{68}\u{69}\u{6e}\u{65}\u{73}\u{65}\u{5f}\u{62}\u{65}\u{73}\u{74}\u{5f}\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}",
            "\u{73}\u{68}\u{6f}\u{77}\u{5f}\u{67}\u{6c}\u{6f}\u{62}\u{61}\u{6c}\u{5f}\u{62}\u{65}\u{73}\u{74}\u{5f}\u{77}\u{65}\u{65}\u{6b}\u{6c}\u{79}"
        ] {
            if let item = tvWeekly.first(where: { $0.id == id }) {
                weekly.append(item)
            }
        }

        if weekly.isEmpty {
            weekly = Array(movieWeekly.prefix(1)) + tvWeekly
        }

        let yearTabs = (movie.groups.first(where: { $0.type == "\u{79}\u{65}\u{61}\u{72}" })?.tabs)
            .flatMap { $0.isEmpty ? nil : $0 }
            ?? tv.groups.first(where: { $0.type == "\u{79}\u{65}\u{61}\u{72}" })?.tabs
            ?? []

        return LbnNqTgdpeAicW(
            weekly: weekly,
            yearTabs: yearTabs,
            movieCategoryTabs: movie.groups.first(where: { $0.type == "\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{79}" })?.tabs ?? [],
            tvCategoryTabs: tv.groups.first(where: { $0.type == "\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{79}" })?.tabs ?? []
        )
    }
}
