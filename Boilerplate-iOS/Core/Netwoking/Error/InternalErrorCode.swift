//
//  InternalErrorCode.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

public enum InternalErrorCode: Int {
    case success = 0
    case unknown = -1
    case parseError = 100
    case unexpectedError = 101
    
    public var code: Int {
        return self.rawValue
    }
    
    public var stringConvertion: String {
        return String(describing: self.rawValue)
    }
    
    public var description: String {
        switch self {
        case .unknown:
            return "Seems there is a technical problem. Please try later."
        case .parseError:
            return "Seems there is a technical problem with converting data. Please try later."
        case .unexpectedError:
            return "There are some unexpected things happened. Please try later."
        case .success: return ""
        }
        
    }
}
