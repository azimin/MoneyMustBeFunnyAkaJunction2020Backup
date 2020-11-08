//
//  MainViewModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

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

    let apiService = APIService.shared
    
    let headerModel: HeaderItemModel
    let spendingsItemModel: LookAtSpendingsItemModel

    let popularCategoriesDS: PopularCategoriesDatasource
    let behaviorDS: YouSpendMostDataSource

    let collectionViewContainer: CollectionViewContainer

    let disposeBag = DisposeBag()

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
    
        self.apiService
            .userAvatarURL
            .bind(to: self.headerModel.imageURL)
            .disposed(by: self.disposeBag)

        self.apiService
            .userName
            .bind(to: self.headerModel.name)
            .disposed(by: self.disposeBag)

        self.apiService
            .userHealth
            .bind(to: self.headerModel.rating)
            .disposed(by: self.disposeBag)

        self.apiService
            .userBalance
            .bind(to: self.headerModel.balance)
            .disposed(by: self.disposeBag)
    }
    
    func viewLoaded() {
        self.apiService.getUser(byID: 1)
        self.apiService.getBehavior(byId: 1, for: Date(), period: .month)
            .subscribe(onSuccess: { [weak self] in
                self?.behaviorDS.model.items.onNext($0)
            })
            .disposed(by: self.disposeBag)

        self.apiService.getCategories(byId: 1, for: Date(), period: .month)
            .subscribe(onSuccess: { [weak self] in
                self?.popularCategoriesDS.items = $0
            })
            .disposed(by: self.disposeBag)

        self.apiService.getNextSubscriptions(byUserId: 1).subscribe(onSuccess: { value in
            print(value)
        })
        .disposed(by: self.disposeBag)

        self.apiService.getActiveSubscriptions(byUserId: 1).subscribe(onSuccess: { value in
            print(value)
        })
        .disposed(by: self.disposeBag)

        self.apiService.getRecommendedSubscriptions(byUserId: 1).subscribe(onSuccess: { value in
            print(value)
        })
        .disposed(by: self.disposeBag)
    }
}
