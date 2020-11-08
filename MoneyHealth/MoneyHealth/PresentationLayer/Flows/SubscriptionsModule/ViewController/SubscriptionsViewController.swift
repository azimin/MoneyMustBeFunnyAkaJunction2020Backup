//
//  SubscriptionsViewController.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import RxSwift
import RxCocoa
import FittedSheets

final class SubscriptionsViewController: CollectionViewController<SubscriptionsView>, ControllerProtocol {
    typealias ViewModelType = SubscriptionsViewModel

    let viewModel: ViewModelType

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel

        super.init(container: viewModel.collectionViewContainer)

        self.title = "Subscriptions"
        self.tabBarItem = .init(title: "Subscriptions", image: UIImage(named: "tab_bar_subscriptions"), selectedImage: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.pushAllSubscriptions), name: .init(rawValue: "pushAllSubscriptions"), object: nil)
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

    @objc func pushAllSubscriptions() {
        let controller = SubscriptionDetailsViewController(subscription: (try! APIService.shared.nextSubscriptions.value()).first!)
        let sheetController = SheetViewController(controller: controller)
        self.present(sheetController, animated: true, completion: nil)

        return
        let viewController = SubscriptionsListViewController(viewModel: .init())
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
