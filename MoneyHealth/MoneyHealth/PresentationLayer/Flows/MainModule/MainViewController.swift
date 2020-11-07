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
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindOutput() {
    }

    func bindInput() {
    }
}
