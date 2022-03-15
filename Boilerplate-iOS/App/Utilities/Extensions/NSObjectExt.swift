//
//  NSObjectExt.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import Foundation

extension NSObject{
    public static var nameOfClass: String {
        return String(describing: self)
    }
    
    func nameOfClass() -> String {
        return "\(type(of: self))"
    }
}
