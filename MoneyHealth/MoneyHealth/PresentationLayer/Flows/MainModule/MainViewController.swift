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

        let healthView = HealthView(
            healthScore: helthScore,
            balance: balance,
            period: .month,
            periodSpend: 500,
            periodSpendChange: 0.5
        )
        
        healthView.snp.makeConstraints { make in
            make.width.equalTo(224)
            make.height.equalTo(221)
        }

        let image = imageWithView(view: healthView)

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
