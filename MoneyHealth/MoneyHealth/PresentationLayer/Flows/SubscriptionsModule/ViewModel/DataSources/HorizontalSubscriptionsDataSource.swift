//
//  UpCommingSubscriptionsDataSource.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import Foundation
import RxCocoa
import RxSwift

final class HorizontalSubscriptionsDataSource: CollectionViewDataSource {
    enum Style {
        case upcomming
        case recommended
    }

    weak var delegate: CollectionViewDataSourceContainerDelegate?

    var isEnabled = true
    var state = DataSourceState.items

    var cellsForRegistration: [CollectionViewCell.Type]? {
        return [
            GenericCollectionViewCell<SubscriptionsCarouselView>.self,
            GenericCollectionViewCell<RecommendedSubscriptionsCarouselView>.self
        ]
    }

    private let style: Style

    init(style: Style) {
        self.style = style
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch self.style {
        case .upcomming:
            let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<SubscriptionsCarouselView>.self, indexPath: indexPath)
            cell.customSubview.updateStyle(style: self.style)
            return cell
        case .recommended:
            let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<RecommendedSubscriptionsCarouselView>.self, indexPath: indexPath)
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
        return CGSize(
            width: self.collectionView.frame.width,
            height: 154
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
        return .init(top: 20, left: 0, bottom: 24, right: 0)
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

