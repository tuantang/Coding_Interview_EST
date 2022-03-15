//
//  Repository.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import Realm
import RealmSwift

protocol AbstractRepository {
    associatedtype T
    func queryAll(keyPath: String?) -> [T?]
    func queryObject(by id: String) -> T?
    func addObject(entity: T)
}

final class Repository<T:RealmRepresentable>: AbstractRepository where T == T.RealmType.ModelType, T.RealmType: Object {
    
    private var realm = RealmFactory.sharedInstance.realm()
    
    func queryAll(keyPath: String? = nil) -> [T?] {
        var result = realm.objects(T.RealmType.self)
        if let keyPath = keyPath {
            result = result.sorted(byKeyPath: keyPath, ascending: true)
        }
        return result.map { $0.asModel() }
    }
    
    func queryObject(by id: String) -> T? {
        guard let object = realm.object(ofType: T.RealmType.self, forPrimaryKey: id) else { return nil }
        return object.asModel()
    }
    
    func addObject(entity: T) {
        let object = entity.asRealm()
        realm.writeAsync(realm: realm, obj: object) { [weak self] (object) in
            guard let object = object, let realm = self?.realm else { return }
            realm.add(object, update: .all)
        }
    }
}
