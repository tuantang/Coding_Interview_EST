//
//  StringExt.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import Foundation

public extension String {
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
