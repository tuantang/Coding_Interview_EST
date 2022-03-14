//
//  GenericError.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

public struct GenericError: Error, Equatable, Decodable {
    
    public var code: String
    public var description: String
    
    
    public init(code: String, description: String) {
        self.code = code
        self.description = description
    }
    
    public var success: Bool {
        return (code == "\(InternalErrorCode.success.rawValue)")
    }
    
    private enum CodingKeys: String, CodingKey {
        case code = "errCode"
        case description
    }
}


public struct NormalResult: Decodable {
    
    public var success: Bool
    public var message: String
    
    public init(success: Bool, message: String) {
        self.success = success
        self.message = message
    }
}
