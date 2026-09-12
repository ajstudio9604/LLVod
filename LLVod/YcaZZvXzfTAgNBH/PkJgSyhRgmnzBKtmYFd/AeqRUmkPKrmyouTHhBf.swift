




import Foundation

struct RawJGVnXMRwEec: Hashable, Identifiable {
    var id: String { "\(sourceName)\u{2d}\(videoLinkId)\u{2d}\(path)\u{2d}\(name)" }

    let name: String
    let path: String
    let sourceName: String
    let videoLinkId: String
    let pic: String
    let zypath: String
}

struct EhHFmDeOqPSoNz: Identifiable, Hashable {
    let id: Int
    let title: String
    let path: String
}

struct ZhopfUeTrMREiEzrLsF: Identifiable, Hashable {
    let id: String
    let name: String
    let episodes: [EhHFmDeOqPSoNz]
    let parseURL: String
    let sourceTag: String
}

struct DuIXQlwHzgRQ {
    let title: String
    let pic: String
    let actor: String
    let status: String
    let intro: String
    let sourceLines: [ZhopfUeTrMREiEzrLsF]
    let sourceConfig: [String: Any]
}

struct QmmmuZADoqghePkjvRNZ: Identifiable, Hashable {
    let id: String
    let name: String
    let type: String
    let api: String
    let userAgent: String
    let sniffWhitelist: String
    let sniffBlacklist: String
}

struct WbBfylATHouFf {
    let url: String
    let tZEwKoRUrWxOAeG: [String: String]
    let usedParserName: String
}

enum IzcEdBMNMPdvVWzISgw: LocalizedError {
    case unableToResolve

    var errorDescription: String? {
        ""
    }
}

