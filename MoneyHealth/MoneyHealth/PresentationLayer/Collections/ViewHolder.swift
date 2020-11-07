//
//  ViewHolder.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

protocol ViewHolder {
    associatedtype ViewType

    var rootView: ViewType { get }
}

extension ViewHolder where Self: UIViewController {
    var rootView: ViewType {
        guard let view = self.view as? ViewType else {
            fatalError("View type (\(type(of: self.view))) does not match with ViewType (\(ViewType.self))")
        }
        return view
    }
}
