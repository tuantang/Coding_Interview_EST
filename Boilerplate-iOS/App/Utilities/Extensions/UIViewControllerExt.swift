//
//  UIViewControllerExt.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import UIKit

extension UIViewController {
    
    static func instantiate() -> Self {
        return instantiateFromStoryboard()
    }
    
    private class func instantiateFromStoryboard<T: UIViewController>() -> T {
        let storyboardID = String(describing: self)
        let storyboardName = self.nameOfClass
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        guard let identifierVC = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("Instantiate ViewControler Failed at \(storyboardID)")
        }
        return identifierVC
    }
}
