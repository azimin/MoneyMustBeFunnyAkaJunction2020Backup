//
//  NavigationViewController.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import RxSwift
import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationBar.prefersLargeTitles = true
    }
}
