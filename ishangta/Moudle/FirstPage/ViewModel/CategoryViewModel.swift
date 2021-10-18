//
//  CategoryViewModel.swift
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

class CategoryViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let provider = MoyaProvider<CategoryAPI>.init(
        endpointClosure: MoyaProvider<CategoryAPI>.defaultEndpointMapping,
        requestClosure: MoyaProvider<CategoryAPI>.defaultRequestMapping,
        stubClosure: MoyaProvider.neverStub,
        callbackQueue: nil,
        session: MoyaProvider<CategoryAPI>.defaultAlamofireSession(),
        plugins: [RequestLoadingPlugin(), NetworkLogger()],
        trackInflights: false)
    
    // MARK: - category list info
    /// category list infos
    ///
    /// - Parameter: nil
    /// - Returns: category model list
    func category() -> Promise<CategoryResponseModel?> {
        return Promise { [weak self] seal in
            self!.provider.requestJson(.classify)
                    .mapObject(type: CategoryResponseModel.self)
                    .subscribe(onNext: { response in
                        seal.fulfill(response)
                    }, onError: {
                        seal.reject($0)
                    }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - category detail list
    /// category list infos
    ///
    /// - Parameter value: params
    /// - Returns:  category detail
    func detail(params value: [String: Any]) -> Promise<CategoryDetailResponseModel?> {
        return Promise { [weak self] seal in
            self!.provider.requestJson(.detail(value: value))
                    .mapObject(type: CategoryDetailResponseModel.self)
                    .subscribe(onNext: { response in
                        seal.fulfill(response)
                    }, onError: {
                        seal.reject($0)
                    }).disposed(by: disposeBag)
        }
    }
}
