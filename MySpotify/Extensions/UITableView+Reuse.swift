//
//  UITableView+Reuse.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

extension UITableView {
    
    func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: ReusableView, Cell: NibLoadableView {
        let nib = UINib(nibName: Cell.nibName, bundle: .none)
        register(nib, forCellReuseIdentifier: Cell.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell where Cell: ReusableView {
        
        guard let cell = dequeueReusableCell(withIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Couldn't dequeue reusable cell with identifier \(Cell.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
}
