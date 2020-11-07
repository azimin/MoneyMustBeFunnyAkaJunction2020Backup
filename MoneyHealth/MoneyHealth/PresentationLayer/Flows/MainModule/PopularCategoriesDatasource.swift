//
//  PopularCategoriesDatasource.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

class PopularCategoriesDatasource: CollectionViewDataSource {
    weak var delegate: CollectionViewDataSourceContainerDelegate?

    var state = DataSourceState.items
    var isEnabled = true

    var items = [PopularCategoryItemModel]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var cellsForRegistration: [CollectionViewCell.Type]? {
        return [GenericCollectionViewCell<PopularCategoryItemView>.self]
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<PopularCategoryItemView>.self, indexPath: indexPath)
        cell.customSubview.configure(with: self.items[indexPath.row])

        if indexPath.row == 0 {
            cell.customSubview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == self.items.count - 1 {
            cell.customSubview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            cell.customSubview.layer.maskedCorners = []
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 88)
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
        return .init(top: 0, left: 16, bottom: 16, right: 16)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

