//
//  LiveViewModel.swift
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

struct LiveViewModel {
    
    private let disposeBag = DisposeBag()
    private var m_page: Int = 1
    private var m_page_size: Int = 30
    
    private let provider = MoyaProvider<LiveAPI>.init(
        endpointClosure: MoyaProvider<LiveAPI>.defaultEndpointMapping,
        requestClosure: MoyaProvider<LiveAPI>.defaultRequestMapping,
        stubClosure: MoyaProvider.neverStub,
        callbackQueue: nil,
        session: MoyaProvider<LiveAPI>.defaultAlamofireSession(),
        plugins: [RequestLoadingPlugin(), NetworkLogger()],
        trackInflights: false)
    
    // MARK: - live list info
    /// live list infos
    ///
    /// - Parameter: nil
    /// - Returns: category model list
    mutating func load() -> Promise<[LiveModel]?> {
        m_page = 1
        let m_params: [String: Any] = ["materialType": "wallpaper", "pageNum": m_page, "pageSize": m_page_size, "titleCode": "dongtaibizhi"]
        return Promise { seal in
            self.provider.requestJson(.live(value: m_params))
                    .mapObject(type: LiveResponseModel.self)
                    .subscribe(onNext: { response in
                        seal.fulfill(response.data)
                    }, onError: {
                        seal.reject($0)
                    }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - live list info
    /// more live list infos
    ///
    /// - Parameter: nil
    /// - Returns: category model list
    mutating func more() -> Promise<[LiveModel]?> {
        m_page += 1
        let m_params: [String: Any] = ["materialType": "wallpaper", "pageNum": m_page, "pageSize": m_page_size, "titleCode": "dongtaibizhi"]
        return Promise { seal in
            self.provider.requestJson(.live(value: m_params))
                    .mapObject(type: LiveResponseModel.self)
                    .subscribe(onNext: { response in
                        seal.fulfill(response.data)
                    }, onError: {
                        seal.reject($0)
                    }).disposed(by: disposeBag)
        }
    }
}
