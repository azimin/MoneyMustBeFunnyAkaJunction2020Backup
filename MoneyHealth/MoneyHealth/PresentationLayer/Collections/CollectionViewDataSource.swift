//
//  CollectionViewDataSource.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

protocol CollectionViewDataSourceContainerDelegate: AnyObject {
    func startSection(forDataSource dataSource: CollectionViewDataSource) -> Int
    func getCollectionView() -> UICollectionView?
    func getContainer() -> CollectionViewContainer
}

enum DataSourceState {
    case items
    case empty
}

protocol CollectionViewDataSource: AnyObject {
    var delegate: CollectionViewDataSourceContainerDelegate? { get set }

    var isEnabled: Bool { get }
    var state: DataSourceState { get set }

    var cellsForRegistration: [CollectionViewCell.Type]? { get }
    var headersForRegistration: [CollectionReusableView.Type]? { get }

    var fallBackStartedSection: Int { get }

    var numberOfSections: Int { get }

    func numberOfItems(inSection section: Int) -> Int

    func getSection() -> Int

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets

    func scrollViewDidScroll(_ scrollView: UIScrollView)

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)

}

extension CollectionViewDataSource {
    var fallBackStartedSection: Int {
        return 0
    }

    var headersForRegistration: [CollectionReusableView.Type]? {
        return []
    }

    var collectionView: UICollectionView {
        guard let collectionView = self.delegate?.getCollectionView() else {
            return UICollectionView(
                frame: .zero,
                collectionViewLayout: UICollectionViewFlowLayout()
            )
        }
        return collectionView
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }

    func getSection() -> Int {
        guard let startSection = self.delegate?.startSection(forDataSource: self) else {
            return self.fallBackStartedSection
        }

        return startSection
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {}

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
}
