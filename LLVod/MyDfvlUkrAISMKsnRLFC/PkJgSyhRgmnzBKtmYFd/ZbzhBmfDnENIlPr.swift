






import UIKit

public class XhuIBtnztVzo : NSObject {
    required public override init() {
        // source-obfuscator:padding:v1
        _ = Self.eZfaxAWTjMrQ()

        super.init()
    }
    
    @objc public var id: String?
    @objc public var area : String?
    @objc public var createTime : TimeInterval = 0
    @objc public var favoriteId = 0
    @objc public var intro : String?
    @objc public var like = 0
    @objc public var name : String?
    @objc public var director: String?
    @objc public var stars: Float = 0
    @objc public var type = 0
    @objc public var updateTime : TimeInterval = 0
    @objc public var year : String?
    @objc public var keyword: String?
    @objc public var clazz: String?
    @objc public var actor: String?
    @objc public var userLikes: String?
    @objc public var brief: String?
    @objc public var serial = 0
    @objc public var vip = 0
    @objc public var isEnd = 0
    @objc public var hitsWeek = 0
    @objc public var hitsMonth = 0
    @objc public var hitsDay = 0
    @objc public var hits = 0
    @objc public var vfavorite: String?
    @objc public var remark : String?   
    
    @objc public var hot = 0
    @objc public var season = 0
    @objc public var coverImage : FilmCoverImageModel?
    @objc public var videos : [VideosItemModel]?
    @objc public var diskUrl : String?
    @objc public var videoPart : String?
    
    @objc public var vodPubdate:String?
    @objc public var cateType2:Int = -1
    
    


    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eZfaxAWTjMrQ() -> String {
        let values = [59, 67, 472, 76]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 59) * 8
        let token = "\u{32}\u{33}\u{34}\u{65}\u{33}\u{32}\u{35}\u{38}\u{38}\u{35}\u{31}\u{38}\u{62}\u{61}\u{63}\u{65}\u{63}\u{61}\u{61}\u{66}\u{62}\u{39}\u{35}\u{65}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

public class VideosItemModel : NSObject {
    @objc public var classType = 0
    @objc public var dramaId: String?
    @objc public var episode = 0
    @objc public var format : String?
    @objc public var id : String?
    @objc public var isVip = 0
    @objc public var path : String?
    @objc public var priority = 0
    @objc public var season = 0
    @objc public var size = 0
    @objc public var source : String?
    @objc public var sourceOld : String?
    @objc public var sourceCn : String?
    @objc public var time = 0
    @objc public var title : String?
    @objc public var titleOld: String?
    @objc public var type = 0
    @objc public var isClicked: Bool = false
    
    required public override init() {
        // source-obfuscator:padding:v1
        _ = Self.rOzZWQANLAQvAfxAiFc()

        super.init()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rOzZWQANLAQvAfxAiFc() -> String {
        let base = (81 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 81) * 3
        let token = "\u{65}\u{63}\u{38}\u{35}\u{34}\u{36}\u{30}\u{64}\u{35}\u{62}\u{38}\u{34}\u{36}\u{64}\u{35}\u{66}\u{33}\u{66}\u{33}\u{61}\u{31}\u{35}\u{65}\u{30}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

public class FilmCoverImageModel : NSObject {
    @objc public var height: Float = 0
    @objc public var width: Float = 0
    @objc public var id : String?
    @objc public var order = 0
    @objc public var path : String?
    @objc public var select = 0
    @objc public var thumbnailPath : String?
    
    required public override init() {
        // source-obfuscator:padding:v1
        _ = Self.kWpiWAtILKIpYugKK()

        super.init()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kWpiWAtILKIpYugKK() -> String {
        let token = "\u{32}\u{31}\u{31}\u{64}\u{65}\u{38}\u{35}\u{33}\u{33}\u{30}\u{39}\u{65}\u{30}\u{62}\u{31}\u{66}\u{32}\u{35}\u{31}\u{61}\u{38}\u{37}\u{30}\u{33}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{33}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 13) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

