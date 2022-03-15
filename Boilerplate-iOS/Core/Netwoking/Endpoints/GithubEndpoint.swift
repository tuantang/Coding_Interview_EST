//
//  GithubEndpoint.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import Moya

enum GithubEndpoint {
    case users
    case detail(String)
}

extension GithubEndpoint: TargetType {
    var baseURL: URL {
        return AppEnvironement.baseURL
    }
    
    var path: String {
        switch self {
        case .users:
            return Path.Github.users
        case .detail(let login):
            return Path.Github.detail.replace(target: "{login}", withString: login)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .users, .detail:
            return .get
        }
    }
    
    var sampleData: Data {
        return "Data".data(using: .utf8) ?? Data()
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .users, .detail:
            return nil
        }
    }
    
    var task: Task {
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: self.parameterEncoding)
        } else {
            return .requestPlain
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
