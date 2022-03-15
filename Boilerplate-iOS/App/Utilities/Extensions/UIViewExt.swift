//
//  UIView_Ext.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import UIKit

public extension UIView {
    @discardableResult
    func leading(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func trailing(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    func top(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func bottom(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ dimension: NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ dimension: NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func centerY(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func centerX(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}
