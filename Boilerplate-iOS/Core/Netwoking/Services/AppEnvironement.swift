//
//  AppEnvironement.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import Foundation

enum AppEnvironement {
    case production
    case staging
    case development
}

extension AppEnvironement {
    static var currentState: AppEnvironement {
        return .development
    }
}

extension AppEnvironement {
    public static var baseURL: URL {
        switch AppEnvironement.currentState {
        case .production:
            return URL(string: "https://api.github.com")!
        case .staging:
            return URL(string: "https://api.github.com")!
        case .development:
            return URL(string: "https://api.github.com")!
        }
    }
}
