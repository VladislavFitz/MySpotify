//
//  ReusableView.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

/**
 A protocol for reusable-type views to provide a default reuse identifier
 ReusableView is a way to generalize the pattern of declaring a constant for
 every reuse identifier. Much of this is based off of the ideas from:
 https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e
 */
public protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

/**
 Provide a default implementation constrained to UIView subclasses which is the
 string representation of the class name
 */
public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
