//
//  RMUser.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import RealmSwift

class RMUser: Object {
    @objc dynamic public var id: String = ""
    @objc dynamic public var login: String = ""
    @objc dynamic public var avatarURL: String = ""
    @objc dynamic public var htmlURL: String = ""
    @objc dynamic public var bio: String = ""
    @objc dynamic public var publicRepos: Int = 0
    @objc dynamic public var followers: Int = 0
    @objc dynamic public var following: Int = 0
    @objc dynamic public var location: String = ""
    @objc dynamic public var name: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMUser: ModelConvertibleType {
    func asModel() -> User? {
        return User(id: Int(id) ?? 0,
                    login: login,
                    avatarURL: avatarURL,
                    htmlURL: htmlURL,
                    bio: bio,
                    publicRepos: publicRepos,
                    followers: followers,
                    following: following,
                    location: location,
                    name: name
        )
    }
}

extension User: RealmRepresentable {
    var uid: String {
        "\(String(describing: id))"
    }
    
    func asRealm() -> some RMUser {
        RMUser.build { object in
            object.id = id != nil ? "\(id!)" : ""
            object.login = login ?? ""
            object.avatarURL = avatarURL ?? ""
            object.htmlURL = htmlURL ?? ""
            object.bio = bio ?? ""
            object.publicRepos = publicRepos ?? 0
            object.followers = followers ?? 0
            object.following = following ?? 0
            object.location = location ?? ""
            object.name = name ?? ""
        }
    }
}
