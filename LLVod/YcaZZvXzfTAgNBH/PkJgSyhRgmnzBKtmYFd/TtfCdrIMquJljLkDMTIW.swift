import Foundation

struct OdvEclAbLCCnVQ: Identifiable {
    var id: String { "\(path)\u{2d}\(videoLinkId)" }

    let title: String
    let path: String
    let videoLinkId: String
    let sourceName: String
    let pic: String
    let zypath: String
    let timestamp: Double

    var route: RawJGVnXMRwEec {
        RawJGVnXMRwEec(
            name: title,
            path: path,
            sourceName: sourceName,
            videoLinkId: videoLinkId,
            pic: pic,
            zypath: zypath
        )
    }

    var dictionary: [String: Any] {
        [
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{38}\u{34}\u{4b}\u{69}\u{7a}\u{50}\u{72}\u{69}"): title,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{65}\u{64}\u{6a}\u{64}\u{4c}\u{42}\u{6b}\u{77}"): path,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{42}\u{63}\u{65}\u{69}\u{65}\u{54}\u{69}\u{77}"): videoLinkId,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}"): sourceName,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{55}\u{52}\u{65}\u{35}\u{68}\u{51}\u{30}\u{30}"): pic,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{72}\u{6b}\u{63}\u{75}\u{73}\u{69}\u{30}\u{62}"): zypath,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{79}\u{6c}\u{68}\u{43}\u{64}\u{62}\u{35}\u{50}"): timestamp
        ]
    }

    init(
        title: String,
        path: String,
        videoLinkId: String,
        sourceName: String,
        pic: String,
        zypath: String,
        timestamp: Double = Date().timeIntervalSince1970
    ) {
        // source-obfuscator:padding:v1
        _ = Self.xOHxKjNgHnAaRVHE()

        self.title = title
        self.path = path
        self.videoLinkId = videoLinkId
        self.sourceName = sourceName
        self.pic = pic
        self.zypath = zypath
        self.timestamp = timestamp
    }

    init?(dictionary: [String: Any]) {
        guard let path = dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{65}\u{64}\u{6a}\u{64}\u{4c}\u{42}\u{6b}\u{77}")] as? String else { return nil }
        self.title = dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{38}\u{34}\u{4b}\u{69}\u{7a}\u{50}\u{72}\u{69}")] as? String ?? ""
        self.path = path
        self.videoLinkId = dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{42}\u{63}\u{65}\u{69}\u{65}\u{54}\u{69}\u{77}")] as? String ?? ""
        
        self.sourceName = (dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String)
            ?? (dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{54}\u{55}\u{4a}\u{38}\u{5a}\u{32}\u{55}\u{66}")] as? String)
            ?? ""
        self.pic = dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{55}\u{52}\u{65}\u{35}\u{68}\u{51}\u{30}\u{30}")] as? String ?? ""
        self.zypath = (dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{72}\u{6b}\u{63}\u{75}\u{73}\u{69}\u{30}\u{62}")] as? String)
            ?? (dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{71}\u{6c}\u{35}\u{39}\u{6f}\u{44}\u{7a}\u{4b}")] as? String)
            ?? ""
        self.timestamp = BdOQnOJDoOmaXKqzHDH.double(dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{79}\u{6c}\u{68}\u{43}\u{64}\u{62}\u{35}\u{50}")])
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xOHxKjNgHnAaRVHE() -> String {
        let base = (79 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 79) * 8
        let token = "\u{61}\u{34}\u{31}\u{39}\u{39}\u{37}\u{36}\u{36}\u{38}\u{64}\u{64}\u{39}\u{39}\u{61}\u{61}\u{66}\u{38}\u{33}\u{39}\u{39}\u{31}\u{66}\u{37}\u{30}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

