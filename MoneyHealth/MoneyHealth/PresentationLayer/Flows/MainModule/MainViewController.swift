//
//  MainViewController.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: CollectionViewController<MainView>, ControllerProtocol {
    typealias ViewModelType = MainViewModel

    let viewModel: MainViewModel

    override func loadView() {
        self.view = MainView()
    }

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(container: viewModel.collectionViewContainer)

        self.tabBarItem = .init(title: "Recommendations", image: UIImage(named: "tab_bar_reccomendations"), selectedImage: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.showAR), name: .init(rawValue: "pushAR"), object: nil)

        self.title = "Recommendations"
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.viewLoaded()
    }
    
    func bindOutput() { }

    func bindInput() { }

    @objc
    func showAR() {
        let balance = try! APIService.shared.userBalance.value()
        let helthScore = try! APIService.shared.userHealth.value()

        let user = (try? APIService.shared.user.value()) ?? UserModel(user_name: "", user_health: 4.5, user_avatar_url: "", user_balance: 2500, user_month_subscribtion_payment: 0, user_spend_this_month: 200, spend_change: 0.2)

        let healthView = HealthView(
            healthScore: user.user_health,
            balance: user.user_balance,
            period: .month,
            periodSpend: user.user_spend_this_month ?? 0,
            periodSpendChange: user.spend_change ?? 0
        )
        
        healthView.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.height.equalTo(221)
        }
        healthView.backgroundColor = .clear
        healthView.isOpaque = false
        healthView.layoutIfNeeded()

        let image = imageWithView(view: healthView)
        ARImageStoreService.shared.forceHealthImage = image

        let arVC = UIStoryboard(name: "AR", bundle: nil).instantiateInitialViewController()!
        arVC.modalPresentationStyle = .fullScreen
        self.present(arVC, animated: true, completion: nil)
    }
}

func imageWithView(view: UIView) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    defer { UIGraphicsEndImageContext() }
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    return UIGraphicsGetImageFromCurrentImageContext()
}
