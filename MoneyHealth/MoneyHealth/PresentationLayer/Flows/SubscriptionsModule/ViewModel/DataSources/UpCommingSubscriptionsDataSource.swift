//
//  UpCommingSubscriptionsDataSource.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import Foundation
import RxCocoa
import RxSwift

final class UpCommingSubscriptionsDataSource: CollectionViewDataSource {
    weak var delegate: CollectionViewDataSourceContainerDelegate?

    var isEnabled = true
    var state = DataSourceState.items

    private var items = [SubscriptionModel]()

    var cellsForRegistration: [CollectionViewCell.Type]? {
        return [
            GenericCollectionViewCell<SpendingView>.self
        ]
    }

    init() {

    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.items[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<SpendingView>.self, indexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: self.collectionView.frame.width,
            height: self.collectionView.frame.height / 2
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

