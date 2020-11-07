//
//  ReusableView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
    static var bundle: Bundle? { get }
}

extension ReusableView {
    public static var reuseIdentifier: String {
        if let component = String(describing: self).split(separator: ".").last {
            return String(component)
        } else {
            return ""
        }
    }

    public static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: bundle)
    }

    public static var bundle: Bundle? {
        return nil
    }
}

public typealias CollectionViewCell = UICollectionViewCell & ReusableView
public typealias CollectionReusableView = UICollectionReusableView & ReusableView
