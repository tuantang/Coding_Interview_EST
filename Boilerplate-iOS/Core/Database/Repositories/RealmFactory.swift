//
//  RealmFactory.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import RealmSwift

struct RealmFactory {
    
    public static var sharedInstance = RealmFactory()
    
    public func realm() -> Realm {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                
            }
        )
        return try! Realm(configuration: config)
    }
    
}
