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

        let upcomingDataSource = HorizontalSubscriptionsDataSource(style: .upcomming)
        let recommendedDataSource = HorizontalSubscriptionsDataSource(style: .recommended)

        self.collectionViewContainer = CollectionViewContainer(
            dataSources: [
                upcomingDataSource,
                recommendedDataSource
            ]
        )
    }
}

