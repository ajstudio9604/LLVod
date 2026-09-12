




import Foundation

struct EculVzlfyFSWuDv: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: String
}

struct YxdUIQGhxKMxKzMYnmOS: Identifiable, Hashable {
    let id: String
    let title: String
    let coverURL: String
    let headerBgImage: String
    let itemsCount: Int
}

struct NddHyKhRMgaZRVYLS: Decodable {
    let data: [NxPdfUTmPYsMcTRcxVie]
}

struct NxPdfUTmPYsMcTRcxVie: Decodable {
    let items: [PlPuwSUyRXeucOLTB]?
}

struct PlPuwSUyRXeucOLTB: Decodable {
    let title: String
    let id: String
    let coverURL: String?
    let headerBgImage: String?
    let itemsCount: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case id
        case coverURL = "\u{63}\u{6f}\u{76}\u{65}\u{72}\u{5f}\u{75}\u{72}\u{6c}"
        case headerBgImage = "\u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{5f}\u{62}\u{67}\u{5f}\u{69}\u{6d}\u{61}\u{67}\u{65}"
        case itemsCount = "\u{69}\u{74}\u{65}\u{6d}\u{73}\u{5f}\u{63}\u{6f}\u{75}\u{6e}\u{74}"
    }
}

