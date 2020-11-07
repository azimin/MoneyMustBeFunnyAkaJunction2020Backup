//
//  ListOfSubscriptionsDataSource.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import Foundation
import RxCocoa
import RxSwift

final class ListOfSubscriptionsDataSource: CollectionViewDataSource {
    weak var delegate: CollectionViewDataSourceContainerDelegate?

    var isEnabled = true
    var state = DataSourceState.items

    var cellsForRegistration: [CollectionViewCell.Type]? {
        return [
            GenericCollectionViewCell<CategoryHeaderView>.self,
            GenericCollectionViewCell<SubscriptionView>.self
        ]
    }

    init() {

    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<CategoryHeaderView>.self, indexPath: indexPath)
            cell.customSubview.titleLabel.text = "All Subscriptions"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<SubscriptionView>.self, indexPath: indexPath)
            cell.customSubview.setup(
                config: .init(
                    id: "1",
                  name: "Spotify",
                  category: "Music",
                  imageName: "Spotify",
                  backgroundColor: "000000",
                  price: 9.99
                )
            )
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(
                width: self.collectionView.frame.width,
                height: 26
            )
        } else {
            return CGSize(
                width: self.collectionView.frame.width - 32,
                height: 109
            )
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
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


