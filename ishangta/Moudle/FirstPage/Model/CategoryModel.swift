//
//  CategoryModel.swift
//  ishangta
//
//  Created by Senyas on 2021/4/27.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift
import PromiseKit

/// classify response model
struct CategoryResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: [[String: Any]]?
    var timestamp: Int?
    var m_data: [CategoryModel]?
    
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
        let biz_info: [String: Any] = ["biz_code": "category",
                                       "status": 200,
                                       "data": data ?? []
                                      ]
        return biz_info
    }
    
    var biz_titles: [String] {
        let m_biz_titles: [String] = m_data?.compactMap({ c_model in
            return c_model.classifyName
        }) ?? []
        return m_biz_titles
    }
}

/// classify
struct CategoryModel: Mappable {

    var id: Int?
    var folderId: Int?
    var osSystem: Int?
    var bizCode: String?
    var classifyName: String?
    var weight: Int?
    var state: Int?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        id              <- map["id"]
        folderId        <- map["folderId"]
        osSystem        <- map["osSystem"]
        bizCode         <- map["bizCode"]
        classifyName    <- map["classifyName"]
        weight          <- map["weight"]
        state           <- map["state"]
    }
}
