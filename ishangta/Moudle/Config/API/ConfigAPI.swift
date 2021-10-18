//
//  ConfigAPI.swift
//  ishangta
//
//  Created by Senyas on 2021/3/4.
//

import Alamofire
import Foundation
import Moya
import RxSwift

enum ConfigAPI {
    /// 获取配置信息
    case config
}

extension ConfigAPI: TargetType {
    /// 网络请求头设置
    var headers: [String: String]? {
        switch self {
        default:
            return [:]
        }
    }

    /// 网络请求基地址
    public var baseURL: URL {
        return URL(string: basedURL)!
    }

    /// 网络请求路径
    public var path: String {
        switch self {
        case .config:
            return "/cameraapi/config/app-audit"
        }
    }

    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
        case .config:
            return .get
        }
    }

    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
        case .config:
            return [:]
        }
    }

    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
        case .config:
            return Data()
        }
    }

    // Represents an HTTP task.
    public var task: Task {
        switch self {
        case .config:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }

    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
        case .config:
            return URLEncoding.default
        }
    }

    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
