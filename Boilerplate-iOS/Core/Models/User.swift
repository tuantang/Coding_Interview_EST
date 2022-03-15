//
//  User.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

struct User: Codable {
    var id: Int?
    var login: String?
    var avatarURL: String?
    var htmlURL: String?
    var bio: String?
    var publicRepos: Int?
    var followers: Int?
    var following: Int?
    var location: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case bio, followers, following
        case publicRepos = "public_repos"
        case location, name
    }
}
