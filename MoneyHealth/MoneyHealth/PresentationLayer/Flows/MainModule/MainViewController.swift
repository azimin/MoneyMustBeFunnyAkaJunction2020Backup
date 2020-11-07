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

        self.tabBarItem = .init(title: "Reccomendations", image: UIImage(named: "tab_bar_reccomendations"), selectedImage: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.showAR), name: .init(rawValue: "pushAR"), object: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindOutput() { }

    func bindInput() { }

    @objc
    func showAR() {
        let arVC = UIStoryboard(name: "AR", bundle: nil).instantiateInitialViewController()!
        arVC.modalPresentationStyle = .fullScreen
        self.present(arVC, animated: true, completion: nil)
    }
}
