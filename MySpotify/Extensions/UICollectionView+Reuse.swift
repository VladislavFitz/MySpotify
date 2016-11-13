//
//  UICollectionView+Reuse.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_: Cell.Type) where Cell: ReusableView, Cell: NibLoadableView {
        let nib = UINib(nibName: Cell.nibName, bundle: .none)
        register(nib, forCellWithReuseIdentifier: Cell.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell where Cell: ReusableView {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Couldn't dequeue reusable cell with identifier \(Cell.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
}
