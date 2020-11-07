//
//  UICollectionView+Reusable.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

extension UICollectionView {
    public func registerReusableCellWithNib<T: CollectionViewCell>(_ cellType: T.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    public func registerReusableCellWithClass<T: CollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    public func registerAnonimusReusableCellWithClass(_ anonimusCellType: CollectionViewCell.Type) {
        register(anonimusCellType, forCellWithReuseIdentifier: anonimusCellType.reuseIdentifier)
    }

    public func dequeueReusableCellWithType<T: CollectionViewCell>(_ viewType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: viewType.reuseIdentifier, for: indexPath) as! T
    }
}
