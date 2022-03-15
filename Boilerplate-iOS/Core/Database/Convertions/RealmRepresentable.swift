//
//  RealmRepresentable.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

protocol RealmRepresentable {
    associatedtype RealmType: ModelConvertibleType
    var uid: String { get }
    func asRealm() -> RealmType
}
