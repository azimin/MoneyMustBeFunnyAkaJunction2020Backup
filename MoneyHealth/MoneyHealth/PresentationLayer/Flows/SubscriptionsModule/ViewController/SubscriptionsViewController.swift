//
//  SubscriptionsViewController.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import RxSwift
import RxCocoa

final class SubscriptionsViewController: CollectionViewController<SubscriptionsView>, ControllerProtocol {
    typealias ViewModelType = SubscriptionsViewModel

    let viewModel: ViewModelType

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel

        super.init(container: viewModel.collectionViewContainer)

        self.title = "Subscriptions"
        self.tabBarItem = .init(title: "Subscriptions", image: UIImage(named: "tab_bar_subscriptions"), selectedImage: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = SubscriptionsView()
    }

    func bindOutput() {
    }

    func bindInput() {
    }
}