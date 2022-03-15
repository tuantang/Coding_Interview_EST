//
//  ModelConvertibleType.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

protocol ModelConvertibleType {
    associatedtype ModelType
    func asModel() -> ModelType?
}
