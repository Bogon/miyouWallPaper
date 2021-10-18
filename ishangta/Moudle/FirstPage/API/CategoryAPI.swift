//
//  CategoryAPI.swift
//  ishangta
//
//  Created by Senyas on 2021/4/27.
//

import Foundation
import Moya
import RxSwift

enum CategoryAPI {
    /// classify
    case classify
    case detail(value: [String: Any]?)

}

extension CategoryAPI: TargetType {
    /// 网络请求头设置
    var headers: [String: String]? {
        switch self {
        default:
            return ["biz-code": "jikebizhi", "os-system": "2"]
        }
    }

    /// 网络请求基地址
    public var baseURL: URL {
        return URL(string: basedURL)!
    }

    /// 网络请求路径
    public var path: String {
        switch self {
        case .classify:
            return "/cameraapi/wallpaper/classify/list"
        case .detail:
            return "/cameraapi/wallpaper/classify/detail"
        }
    }

    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
        case .classify:
            return .get
        case .detail:
            return .get
        }
    }

    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
        case .classify:
            return [:]
        case let .detail(params):
            return params
        }
    }

    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
        case .classify:
            return Data()
        case let .detail(value):
            return value!.jsonData()!
        }
    }

    // Represents an HTTP task.
    public var task: Task {
        switch self {
        case .classify:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        case .detail:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }

    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
        case .classify:
            return URLEncoding.default
        case .detail:
            return URLEncoding.default
        }
    }

    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
