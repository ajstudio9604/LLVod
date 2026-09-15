//
//  HomeMainViewModel.swift
//  OrangeFilm
//
//  Created by Achille on 2024/6/17.
//

import UIKit

public class FilmItemModel : NSObject {
    required public override init() {
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
    @objc public var remark : String?   // "更新至20240616",
    
    @objc public var hot = 0
    @objc public var season = 0
    @objc public var coverImage : FilmCoverImageModel?
    @objc public var videos : [VideosItemModel]?
    @objc public var diskUrl : String?
    @objc public var videoPart : String?
    
    @objc public var vodPubdate:String?
    @objc public var cateType2:Int = -1
    
    

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
        super.init()
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
        super.init()
    }
}
