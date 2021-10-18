//
//  CategoryDetailModel.swift
//  ishangta
//
//  Created by Senyas on 2021/4/29.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift
import PromiseKit

/// classify detail response model
struct CategoryDetailResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: [[String: Any]]?
    var timestamp: Int?
    var m_data: [CategoryDetailModel]?
    
    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        success <- map["success"]
        msg <- map["msg"]
        data <- map["data"]
        m_data <- map["data"]
        timestamp <- map["timestamp"]
    }
    
    /// flutter biz data
    var biz_data: [String: Any] {
        let biz_info: [String: Any] = ["biz_code": "category_detail",
                                       "status": 200,
                                       "data": data ?? []
                                      ]
        return biz_info
    }
}

/// category detail
struct CategoryDetailModel: Mappable {

    var id: String?
    var wallpaperClassifyId: Int?
    var wallpaperSource: String?
    var wallpaperName: String?
    var wallpaperDesc: String?
    var weight: Int?
    var classify: Int?
    var wallpaperElements: [WallpeperElementModel]?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        wallpaperClassifyId <- map["wallpaperClassifyId"]
        wallpaperSource <- map["wallpaperSource"]
        wallpaperName <- map["wallpaperName"]
        wallpaperDesc <- map["wallpaperDesc"]
        weight <- map["weight"]
        classify <- map["classify"]
        wallpaperElements <- map["wallpaperElements"]
    }
}

/// classify
struct WallpeperElementModel: Mappable {

    var pixelSize: Int?
    var pixels: String?
    var width: Int?
    var height: Int?
    var size: Int?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        pixelSize <- map["pixelSize"]
        pixels <- map["pixels"]
        width <- map["width"]
        height <- map["height"]
        size <- map["size"]
    }
    
    private var pixel_title: String {
        switch pixelSize {
        case 25:
            return "标清"
            
        case 50:
            return "高清"
            
        case 75:
            return "超清"
            
        case 100:
            return "原图"
            
        default:
            return "原图"
        }
    }
    
    private var size_value: String {
        return String(format: "%.2fMB", Double(Double(size ?? 0)/(1024.0*1024.0)))
    }
    
    private var sc_size: String {
        return "\(width ?? 0)*\(height ?? 0)"
    }
    
    var m_title: String {
        return "\(pixel_title) (\(size_value) \(sc_size))"
    }
}
