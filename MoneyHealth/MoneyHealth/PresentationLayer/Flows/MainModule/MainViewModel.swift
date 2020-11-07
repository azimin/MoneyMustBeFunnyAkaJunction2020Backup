//
//  MainViewModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation

protocol AnyViewModelProtocol {
    func viewLoaded()
}

extension AnyViewModelProtocol {
    func viewLoaded() {}
}

protocol ViewModelProtocol: AnyViewModelProtocol {
    associatedtype Input
    associatedtype Output

    var output: Self.Output { get }
    var input: Self.Input { get }
}

protocol AnyControllerProtocol {
    var anyViewModel: AnyViewModelProtocol { get }
}

protocol ControllerProtocol: AnyControllerProtocol {
    associatedtype ViewModelType: ViewModelProtocol

    var viewModel: ViewModelType { get }

    func bindInput()
    func bindOutput()
}

extension ControllerProtocol {
    var anyViewModel: AnyViewModelProtocol {
        return self.viewModel
    }
}

final class MainViewModel: ViewModelProtocol {

    struct Output {
    }
    
    struct Input {
    }

    var output: Output
    var input: Input

    let headerModel: HeaderItemModel
    let spendingsItemModel: LookAtSpendingsItemModel

    let collectionViewContainer: CollectionViewContainer

    init() {
        self.output = Output()
        self.input = Input()

        self.headerModel = HeaderItemModel(data: .init())
        let dataSource = HeaderDataSource(model: headerModel)

        self.spendingsItemModel = LookAtSpendingsItemModel(data: .init())
        let spendingsDS = LookAtSpendingsDataSource(model: self.spendingsItemModel)

        self.collectionViewContainer = CollectionViewContainer(
            dataSources:
                [
                    dataSource,
                    spendingsDS
                ]
        )
    }
}
