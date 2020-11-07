//
//  MainViewModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

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

    let popularCategoriesDS: PopularCategoriesDatasource
    let behaviorDS: YouSpendMostDataSource

    let collectionViewContainer: CollectionViewContainer

    init() {
        self.output = Output()
        self.input = Input()

        self.headerModel = HeaderItemModel(data: .init())
        let dataSource = HeaderDataSource(model: headerModel)

        self.spendingsItemModel = LookAtSpendingsItemModel(data: .init())

        let spendingsDS = LookAtSpendingsDataSource(model: self.spendingsItemModel)
        
        let titleDS = TitleDataSource()

        self.popularCategoriesDS = PopularCategoriesDatasource()

        let behaviorModel = YouSpendMostItemModel(data: .init())
        self.behaviorDS = YouSpendMostDataSource(model: behaviorModel)

        self.collectionViewContainer = CollectionViewContainer(
            dataSources:
                [
                    dataSource,
                    spendingsDS,
                    behaviorDS,
                    titleDS,
                    popularCategoriesDS
                ]
        )

        let dummyItems = [
            SpendingViewData(title: "Hello", imageUrl: URL(string: "https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/fdb0f429-e363-4e5c-8429-cd2db7a604c2/280x420")!),
            SpendingViewData(title: "Guys", imageUrl: URL(string: "https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/fdb0f429-e363-4e5c-8429-cd2db7a604c2/280x420")!),
            SpendingViewData(title: "How are you", imageUrl: URL(string: "https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/fdb0f429-e363-4e5c-8429-cd2db7a604c2/280x420")!),
        ]

        let models = dummyItems.map {
            SpendingItemModel(data: $0)
        }

        self.spendingsItemModel.items.onNext(models)

        let dummyCategories = [
            PopularCategoryItemViewData(
                categoryImage: UIImage(named: "1")!,
                iconColor: UIColor(hex: "FF5A36"),
                categoryTitle: "Grocery",
                periodTitle: "From last week",
                tendency: 25,
                amount: 323.15
            ),
            PopularCategoryItemViewData(
                categoryImage: UIImage(named: "2")!,
                iconColor: UIColor(hex: "27D086"),
                categoryTitle: "Home",
                periodTitle: "From last week",
                tendency: -30,
                amount: 100
            ),
        ]

        let categoryModels = dummyCategories.map {
            PopularCategoryItemModel(data: $0)
        }
        

        self.popularCategoriesDS.items = categoryModels

        let dummyBehavior = [
            MostSpendItemViewData(
                icon: UIImage(named: "3")!,
                amount: 300,
                numberOfTransactions: 12,
                percent: 20,
                category: .insurance,
                period: .week
            ),
            MostSpendItemViewData(
                icon: UIImage(named: "4")!,
                amount: 1500.10,
                numberOfTransactions: 20,
                percent: -40,
                category: .pets,
                period: .week
            ),
        ]

        let behaviourModels = dummyBehavior.map {
            MostSpendItemModel(data: $0)
        }

        self.behaviorDS.model.items.onNext(behaviourModels)
    }
}
