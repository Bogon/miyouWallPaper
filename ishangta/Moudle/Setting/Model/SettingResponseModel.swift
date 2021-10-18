//
//  SettingResponseModel.swift
//  ishangta
//
//  Created by Senyas on 2021/10/16.
//

import Foundation
import ObjectMapper
import RxDataSources

enum SettingType {
    case protocols
    case privacy
    case version
    case clear
}

struct SettingListSection {
    var items: [Item]
}

extension SettingListSection: SectionModelType {
    typealias Item = SettingItemInfoModel

    init(original: SettingListSection, items: [SettingListSection.Item]) {
        self = original
        self.items = items
    }
}

/// 设置数据模型
struct SettingItemInfoModel: Mappable {
    var type: SettingType?
    var is_refresh: Bool?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        type <- map["type"]
        is_refresh <- map["is_refresh"]
    }
}
