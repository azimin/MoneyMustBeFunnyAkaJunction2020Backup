//
//  SubscriptionsViewModel.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

final class SubscriptionsListViewModel: ViewModelProtocol {

    struct Output {
    }

    struct Input {
    }

    var output: Output
    var input: Input

    let collectionViewContainer: CollectionViewContainer

    init() {
        self.output = Output()
        self.input = Input()

        self.collectionViewContainer = CollectionViewContainer(
            dataSources: [
                TotalSubscriptionsDataSource(isAll: true),
                ListOfSubscriptionsDataSource()
            ]
        )
    }
}

