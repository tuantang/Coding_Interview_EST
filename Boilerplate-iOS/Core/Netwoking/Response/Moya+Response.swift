//
//  Moya+Response.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import Moya
import RxSwift

extension Moya.Response {
    
    public func mapObject<T>(_ type: T.Type) -> T? where T: Decodable {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    public func mapObject<T: Decodable>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(response.mapObject(T.self)!)
        }
    }
}

