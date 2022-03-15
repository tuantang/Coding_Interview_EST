//
//  GithubRequest.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import RxSwift
import Moya

class GithubRequest {
    private let userProvider: APIService<GithubEndpoint>
    public init() {
        userProvider = APIService()
    }
}

extension GithubRequest {
    func getUsers() -> Observable<(data: [User]?, error: GenericError?)> {
        return Observable<(data: [User]?, error: GenericError?)>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            return self.userProvider.request(targetType: GithubEndpoint.users, type: [User].self)
                .subscribe(onNext: { element in
                    observer.onNext(element)
                    observer.onCompleted()
                })
        }
    }
    
    func getDetail(login: String) -> Observable<(data: User?, error: GenericError?)> {
        return Observable<(data: User?, error: GenericError?)>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            return self.userProvider.request(targetType: GithubEndpoint.detail(login), type: User.self)
                .subscribe(onNext: { element in
                    observer.onNext(element)
                    observer.onCompleted()
                })
        }
    }
}
