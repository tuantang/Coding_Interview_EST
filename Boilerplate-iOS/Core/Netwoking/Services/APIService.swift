//
//  APiService.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import Moya
import RxSwift

class APIService<Target>: MoyaProvider<Target> where Target: TargetType {
    private let provider: MoyaProvider<Target>
    
    init() {
        provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    }
    
    @discardableResult
    func request<T: Decodable>(targetType: Target, type: T.Type) -> Observable<(data: T?, error: GenericError)> {
        Observable<(data: T?, error: GenericError)>.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            return self.provider
                .rx
                .request(targetType)
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        if let obj = response.mapObject(type.self) {
                            let genericError = GenericError.init(code: "\(InternalErrorCode.success.rawValue)", description: InternalErrorCode.success.description)
                            observer.onNext((data: obj, error: genericError))
                            observer.onCompleted()
                        }
                    case .failure(let error):
                        let error = GenericError.init(code: String(describing: error.asAFError?.responseCode ?? -111), description: error.localizedDescription)
                        observer.onNext((data: nil, error: error))
                        observer.onCompleted()
                    }
                }
        }
    }
    
    func cancelAllRequests() {
        provider.session.cancelAllRequests()
    }
}
