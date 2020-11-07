//
//  CollectionViewDataSource.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation
import RxSwift

class CollectionViewContainer: CollectionViewDataSource, CollectionViewDataSourceContainerDelegate {
    weak var delegate: CollectionViewDataSourceContainerDelegate?

    var internalCollectionView: UICollectionView? {
        didSet {
            if let collectionView = self.internalCollectionView {
                self.registerCellsFor(collectionView: collectionView)
            }
        }
    }

    func getCollectionView() -> UICollectionView? {
        return self.internalCollectionView
    }

    func getContainer() -> CollectionViewContainer {
        return self
    }

    let dataSources: [CollectionViewDataSource]
    var numberOfSections: Int = 0
    var isEnabled = true
    var state = DataSourceState.items

    private var sections: [Range<Int>: CollectionViewDataSource] = [:]
    private var previousSections: [Range<Int>: CollectionViewDataSource] = [:]

    var reloadAction: Observable<Void> {
        return self.reloadActionSubject.asObservable()
    }

    private let reloadActionSubject = PublishSubject<Void>()

    init(dataSources: [CollectionViewDataSource]) {
        self.dataSources = dataSources
        self.reload(shouldReloadCollection: false)
    }

    var cellsForRegistration: [CollectionViewCell.Type]? {
        return self.dataSources.reduce([]) { (result, dataSource) -> [CollectionViewCell.Type] in
            result + (dataSource.cellsForRegistration ?? [])
        }
    }

    var headersForRegistration: [CollectionReusableView.Type]? {
        return self.dataSources.reduce([]) { (result, dataSource) -> [CollectionReusableView.Type] in
            result + (dataSource.headersForRegistration ?? [])
        }
    }

    func reload(shouldReloadCollection: Bool) {
        var currentSection = 0
        self.previousSections = self.sections
        self.sections = [:]

        for source in self.dataSources {
            source.delegate = self
            let startIndex = currentSection
            let endIndex = currentSection + source.numberOfSections
            if source.numberOfSections != 0 {
                self.sections[startIndex ..< endIndex] = source
                currentSection += source.numberOfSections
            }
        }

        self.numberOfSections = currentSection
        self.reloadActionSubject.onNext(())

        if shouldReloadCollection {
            self.internalCollectionView?.reloadData()
        }
    }

    func numberOfItems(inSection section: Int) -> Int {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(section)
        }

        guard let currentDataSourcePair = pair else {
            return 0
        }

        let newSection = section - currentDataSourcePair.key.lowerBound
        return currentDataSourcePair.value.numberOfItems(inSection: newSection)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(indexPath.section)
        }

        guard let currentDataSourcePair = pair else {
            return UICollectionViewCell()
        }

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - currentDataSourcePair.key.lowerBound)
        return currentDataSourcePair.value.collectionView(collectionView, cellForItemAt: newIndexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pair = self.sections.merging(self.previousSections) { _, previousDataSource in
            previousDataSource
        }
        .first { (range, _) -> Bool in
            range.contains(indexPath.section)
        }

        guard let currentDataSourcePair = pair else {
            return
        }

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - currentDataSourcePair.key.lowerBound)
        currentDataSourcePair.value.collectionView(collectionView, willDisplay: cell, forItemAt: newIndexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pair = self.sections.merging(self.previousSections) { _, previousDataSource in
            previousDataSource
        }
        .first { (range, _) -> Bool in
            range.contains(indexPath.section)
        }

        guard let currentDataSourcePair = pair else {
            return
        }

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - currentDataSourcePair.key.lowerBound)
        currentDataSourcePair.value.collectionView(collectionView, didEndDisplaying: cell, forItemAt: newIndexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(indexPath.section)
        }

        guard let currentDataSourcePair = pair else {
            return UICollectionReusableView()
        }

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - currentDataSourcePair.key.lowerBound)
        return currentDataSourcePair.value.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: newIndexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(section)
        }

        guard let currentDataSourcePair = pair else {
            return .zero
        }

        if currentDataSourcePair.value.headersForRegistration?.count == 0 {
            return .zero
        }

        let newSection = section - currentDataSourcePair.key.lowerBound
        return currentDataSourcePair.value.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: newSection)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(indexPath.section)
        }

        guard let currentDataSourcePair = pair else {
            return
        }

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - currentDataSourcePair.key.lowerBound)
        currentDataSourcePair.value.collectionView(collectionView, didSelectItemAt: newIndexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(indexPath.section)
        }

        guard let currentDataSourcePair = pair else {
            return .zero
        }

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - currentDataSourcePair.key.lowerBound)
        return currentDataSourcePair.value.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: newIndexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(section)
        }

        guard let currentDataSourcePair = pair else {
            return .zero
        }
        let newSection = section - currentDataSourcePair.key.lowerBound
        return currentDataSourcePair.value.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: newSection)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(section)
        }

        guard let currentDataSourcePair = pair else {
            return .zero
        }
        let newSection = section - currentDataSourcePair.key.lowerBound
        return currentDataSourcePair.value.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: newSection)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let pair = self.sections.first { (range, _) -> Bool in
            range.contains(section)
        }

        guard let currentDataSourcePair = pair else {
            return .zero
        }
        let newSection = section - currentDataSourcePair.key.lowerBound
        return currentDataSourcePair.value.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: newSection)
    }

    func startSection(forDataSource: CollectionViewDataSource) -> Int {
        let pair = self.sections.first { (_, dataSource: CollectionViewDataSource) -> Bool in
            dataSource === forDataSource
        }

        guard let currentDataSourcePair = pair else {
            return .zero
        }

        return currentDataSourcePair.key.lowerBound
    }

    // MARK: - Scroll View

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.dataSources.forEach {
            $0.scrollViewDidScroll(scrollView)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.dataSources.forEach {
            $0.scrollViewWillEndDragging(
                scrollView,
                withVelocity: velocity,
                targetContentOffset: targetContentOffset
            )
        }
    }

    // MARK: - Setup

    private func registerCellsFor(collectionView: UICollectionView) {
        for cellType in self.cellsForRegistration ?? [] {
            collectionView.registerAnonimusReusableCellWithClass(cellType)
        }
    }
}

