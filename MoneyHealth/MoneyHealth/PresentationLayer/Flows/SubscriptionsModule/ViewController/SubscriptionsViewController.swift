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
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindOutput() {
    }

    func bindInput() {
    }
}
