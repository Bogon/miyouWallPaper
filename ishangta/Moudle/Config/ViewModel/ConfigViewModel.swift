//
//  ConfigViewModel.swift
//  ishangta
//
//  Created by Senyas on 2021/3/4.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift
import PromiseKit

class ConfigViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let provider = MoyaProvider<ConfigAPI>.init(
        endpointClosure: MoyaProvider<ConfigAPI>.defaultEndpointMapping,
        requestClosure: MoyaProvider<ConfigAPI>.defaultRequestMapping,
        stubClosure: MoyaProvider.neverStub,
        callbackQueue: nil,
        session: MoyaProvider<ConfigAPI>.defaultAlamofireSession(),
        plugins: [RequestLoadingPlugin(), NetworkLogger()],
        trackInflights: false)
    
    // MARK: - 获取全局配置信息

    /// 全局配置信息
    ///
    ///
    /// - Parameter value: 无
    /// - Returns:  配置信息
    func config() -> Promise<ConfigModel?> {
        return Promise { [weak self] seal in
            
            self!.provider.requestJson(.config)
                    .mapObject(type:ConfigResponseModel.self)
                    .subscribe(onNext: { response in
                        seal.fulfill(response.data)
                    }, onError: {
                        seal.reject($0)
                    }).disposed(by: disposeBag)
        }
    }
}
