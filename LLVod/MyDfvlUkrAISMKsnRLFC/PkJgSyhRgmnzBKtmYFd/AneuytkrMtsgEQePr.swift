import Foundation

struct RhhpkFvgKfFHMcMR: Decodable {
    let list: [VideoCategory]
}

struct VideoCategory: Decodable {
    let typeID: Int
    let videoList: [NxlvoRQtwNKjxDlQLJQB]

    enum CodingKeys: String, CodingKey {
        case typeID = "\u{74}\u{79}\u{70}\u{65}\u{5f}\u{69}\u{64}"
        case videoList = "\u{76}\u{6c}\u{69}\u{73}\u{74}"
    }
}

struct NxlvoRQtwNKjxDlQLJQB: Decodable {
    let videoName: String?
    let videoPicture: String?
    let videoRemarks: String?
    let videoTimeAdd: EbAJbWZfBVsQeyxMX?
    let visibility: EbAJbWZfBVsQeyxMX?
    let videoID: EbAJbWZfBVsQeyxMX?

    enum CodingKeys: String, CodingKey {
        case videoName = "\u{76}\u{6f}\u{64}\u{5f}\u{6e}\u{61}\u{6d}\u{65}"
        case videoPicture = "\u{76}\u{6f}\u{64}\u{5f}\u{70}\u{69}\u{63}"
        case videoRemarks = "\u{76}\u{6f}\u{64}\u{5f}\u{72}\u{65}\u{6d}\u{61}\u{72}\u{6b}\u{73}"
        case videoTimeAdd = "\u{76}\u{6f}\u{64}\u{5f}\u{74}\u{69}\u{6d}\u{65}\u{5f}\u{61}\u{64}\u{64}"
        case visibility = "\u{76}\u{69}\u{73}"
        case videoID = "\u{76}\u{6f}\u{64}\u{5f}\u{69}\u{64}"
    }
}

