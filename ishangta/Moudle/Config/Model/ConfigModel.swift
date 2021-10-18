//
//  ConfigModel.swift
//  ishangta
//
//  Created by Senyas on 2021/3/4.
//

import Foundation
import ObjectMapper
import RxDataSources

/**
 {
   "code": 0,
   "msg": "执行成功",
   "data": {
     "wallpaper": 2,
     "yunying": 2,
     "urlPrefix": "https://camera-real.oss-cn-shanghai.aliyuncs.com/",
     "adSwitch": 2,
     "overReview": 2,
     "hotStartInterval": 30,
     "chargeSwitch": 2
   },
   "timestamp": 1614843216159
 }
 */

/// 获取配置信息
struct ConfigResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: ConfigModel?
    var timestamp: Int?
    
    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        success <- map["success"]
        msg <- map["msg"]
        data <- map["data"]
        timestamp <- map["timestamp"]
    }
}

/// 配置信息详情
struct ConfigModel: Mappable {
    var wallpaper: Int?
    var yunying: Int?
    var urlPrefix: String?
    var adSwitch: Int?
    var overReview: Int?
    var hotStartInterval: Int?
    var chargeSwitch: Int?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        wallpaper <- map["wallpaper"]
        yunying <- map["yunying"]
        urlPrefix <- map["urlPrefix"]
        adSwitch <- map["adSwitch"]
        overReview <- map["overReview"]
        hotStartInterval <- map["hotStartInterval"]
        chargeSwitch <- map["chargeSwitch"]
    }
    
    /// Description
    var discription: String {
        return "wallpaper: \(wallpaper ?? -1) \n" +
               "yunying: \(yunying ?? -1)\n" +
               "urlPrefix: \(urlPrefix ?? "null")\n" +
               "adSwitch: \(adSwitch ?? -1)\n" +
               "overReview: \(overReview ?? -1)\n" +
               "hotStartInterval: \(hotStartInterval ?? -1)\n" +
               "chargeSwitch: \(chargeSwitch ?? -1)\n"
    }
}
