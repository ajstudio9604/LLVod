import Foundation

struct BujroaRaxIvHZD: Identifiable {
    var id: String { "\(path)\u{2d}\(videoLinkId)" }

    let title: String
    let path: String
    let videoLinkId: String
    let sourceName: String
    let pic: String
    let zypath: String
    let lineIndex: Int
    let lineName: String
    let gAnSZJKWRXAmnpyvYK: Int
    let episodeTitle: String
    let episodePath: String
    let position: Double
    let duration: Double
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
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{62}\u{47}\u{6b}\u{32}\u{66}\u{6a}\u{59}\u{71}"): lineIndex,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{44}\u{4e}\u{30}\u{54}\u{32}\u{75}\u{47}\u{42}"): lineName,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{6c}\u{6a}\u{4f}\u{57}\u{62}\u{74}\u{76}\u{32}"): gAnSZJKWRXAmnpyvYK,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{67}\u{4a}\u{46}\u{76}\u{32}\u{38}\u{64}\u{67}"): episodeTitle,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{6a}\u{56}\u{6a}\u{57}\u{73}\u{31}\u{6e}\u{70}"): episodePath,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{44}\u{56}\u{6f}\u{62}\u{66}\u{37}\u{7a}\u{76}"): position,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{4f}\u{65}\u{33}\u{57}\u{72}\u{46}\u{76}\u{67}"): duration,
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
        lineIndex: Int,
        lineName: String,
        gAnSZJKWRXAmnpyvYK: Int,
        episodeTitle: String,
        episodePath: String,
        position: Double = 0,
        duration: Double = 0,
        timestamp: Double = Date().timeIntervalSince1970
    ) {
        // source-obfuscator:padding:v1
        _ = Self.bRYcmJigMsQJ()

        self.title = title
        self.path = path
        self.videoLinkId = videoLinkId
        self.sourceName = sourceName
        self.pic = pic
        self.zypath = zypath
        self.lineIndex = lineIndex
        self.lineName = lineName
        self.gAnSZJKWRXAmnpyvYK = gAnSZJKWRXAmnpyvYK
        self.episodeTitle = episodeTitle
        self.episodePath = episodePath
        self.position = position
        self.duration = duration
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
        self.lineIndex = BdOQnOJDoOmaXKqzHDH.jPCsrGcMaGUdMtb(dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{62}\u{47}\u{6b}\u{32}\u{66}\u{6a}\u{59}\u{71}")])
        self.lineName = dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{44}\u{4e}\u{30}\u{54}\u{32}\u{75}\u{47}\u{42}")] as? String ?? ""
        self.gAnSZJKWRXAmnpyvYK = BdOQnOJDoOmaXKqzHDH.jPCsrGcMaGUdMtb(dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{6c}\u{6a}\u{4f}\u{57}\u{62}\u{74}\u{76}\u{32}")])
        self.episodeTitle = (dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{67}\u{4a}\u{46}\u{76}\u{32}\u{38}\u{64}\u{67}")] as? String)
            ?? (dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{4c}\u{52}\u{49}\u{75}\u{76}\u{6c}\u{36}\u{38}")] as? String)
            ?? ""
        self.episodePath = dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{6a}\u{56}\u{6a}\u{57}\u{73}\u{31}\u{6e}\u{70}")] as? String ?? ""
        self.position = BdOQnOJDoOmaXKqzHDH.double(dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{44}\u{56}\u{6f}\u{62}\u{66}\u{37}\u{7a}\u{76}")])
        self.duration = BdOQnOJDoOmaXKqzHDH.double(dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{4f}\u{65}\u{33}\u{57}\u{72}\u{46}\u{76}\u{67}")])
        self.timestamp = BdOQnOJDoOmaXKqzHDH.double(dictionary[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{79}\u{6c}\u{68}\u{43}\u{64}\u{62}\u{35}\u{50}")])
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bRYcmJigMsQJ() -> String {
        let token = "\u{36}\u{38}\u{34}\u{66}\u{30}\u{65}\u{33}\u{35}\u{36}\u{62}\u{35}\u{65}\u{36}\u{33}\u{32}\u{37}\u{62}\u{37}\u{32}\u{36}\u{36}\u{33}\u{39}\u{65}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{32}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 22) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

