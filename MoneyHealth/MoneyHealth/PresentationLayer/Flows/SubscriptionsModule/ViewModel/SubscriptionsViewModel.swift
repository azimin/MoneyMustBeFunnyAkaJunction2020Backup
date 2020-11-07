//
//  SubscriptionsViewModel.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

final class SubscriptionsViewModel: ViewModelProtocol {

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

        let upcomingDataSource = UpCommingSubscriptionsDataSource()

        self.collectionViewContainer = CollectionViewContainer(dataSources: [upcomingDataSource])
    }
}

