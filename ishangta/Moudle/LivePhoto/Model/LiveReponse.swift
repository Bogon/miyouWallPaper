//
//  LiveReponse.swift
//  ishangta
//
//  Created by Senyas on 2021/9/25.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift
import PromiseKit

/// live response model
struct LiveResponseModel: Mappable {
    var code: Int?
    var msg: String?
    var timestamp: Int?
    var data: [LiveModel]?
    
    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        data <- map["data"]
        timestamp <- map["timestamp"]
    }
}

struct LiveModel: Mappable {
    var id: String?
    var materialId: Int?
    var imageUrl: String?
    var bundle: String?
    var videoUrl: String?
    var type: Int?
    var isVideo: Int?
    var sort: Int?
    
    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        id          <- map["id"]
        materialId  <- map["materialId"]
        imageUrl    <- map["imageUrl"]
        bundle      <- map["bundle"]
        videoUrl    <- map["videoUrl"]
        type        <- map["type"]
        isVideo     <- map["isVideo"]
        sort        <- map["sort"]
    }
}
