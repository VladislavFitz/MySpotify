//
//  NibLoadableView.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

/**
 A protocol for views having a corresponding nib to expose a default name, but
 can easily be overridden if the corresponding nib filename is different from
 that of its class
 NibLoadableView is a way to generalize the pattern of declaring a constant for
 every nib file. Much of this is based off of the ideas from:
 https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e
 */
public protocol NibLoadableView: class {
    static var nibName: String { get }
}

/**
 Provide a default implementation for UIViews that is a safer way of getting the
 nib name
 */
public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
