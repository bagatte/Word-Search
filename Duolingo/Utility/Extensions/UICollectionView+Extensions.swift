//
//  UICollectionView+Extensions.swift
//  Duolingo
//
//  Created by bagatte on 3/10/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol NibLoadable {}
extension NibLoadable {
    
    /// Returns type name as default identifier.
    static var identifier: String {
        return String(describing: self)
    }
    
    /// Returns type name as default nib name.
    static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, forIndexPath indexPath: IndexPath) -> T where T: NibLoadable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("No table view cell could be dequeued with identifier \(T.identifier)")
        }
        return cell
    }
}
