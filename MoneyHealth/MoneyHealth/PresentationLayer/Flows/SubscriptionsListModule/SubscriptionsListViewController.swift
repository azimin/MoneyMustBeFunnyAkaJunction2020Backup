//
//  SubscriptionsViewController.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import RxSwift
import RxCocoa

final class SubscriptionsListViewController: CollectionViewController<SubscriptionsListView>, ControllerProtocol {
    typealias ViewModelType = SubscriptionsListViewModel

    let viewModel: ViewModelType

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel

        super.init(container: viewModel.collectionViewContainer)

        self.title = "All Subscriptions"
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = SubscriptionsListView()
    }

    func bindOutput() {
    }

    func bindInput() {
    }
}
