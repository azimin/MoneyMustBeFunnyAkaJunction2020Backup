//
//  LookAtSpendingsDataSource.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

class LookAtSpendingsDataSource: CollectionViewDataSource {
    weak var delegate: CollectionViewDataSourceContainerDelegate?

    var state = DataSourceState.items
    var isEnabled = true

    private let model: LookAtSpendingsItemModel
    

    init(model: LookAtSpendingsItemModel) {
        self.model = model
    }

    var cellsForRegistration: [CollectionViewCell.Type]? {
        return [GenericCollectionViewCell<LookAtSpendingItemView>.self]
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<LookAtSpendingItemView>.self, indexPath: indexPath)
        cell.customSubview.configure(with: self.model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 230)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
