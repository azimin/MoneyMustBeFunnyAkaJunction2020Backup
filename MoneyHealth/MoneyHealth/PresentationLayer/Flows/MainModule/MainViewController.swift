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

    init(viewModel: MainViewModel) {
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
