//
//  CellModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import RxSwift

typealias VoidBlock = () -> Void

protocol ReusableComponent: AnyObject {
    func reuse()
}

protocol GenericConfigurableCellComponent: UIView, GenericCellSubview, ReusableComponent {
    associatedtype ViewData: Hashable
    associatedtype Model: GenericCellModelProtocol

    var disposeBag: DisposeBag { get set }
    var model: Model? { get }

    func configure(with data: ViewData)
    func configure(with model: Model)

    func bindOutput(from model: Model)
    func bindInput(from model: Model)
}

extension GenericConfigurableCellComponent {
    func bindOutput(from model: Model) {}
    func bindInput(from model: Model) {}

    func reuse() {
        self.model?.reuse()
        self.disposeBag = DisposeBag()
    }

    func configure(with data: ViewData) {}
    func configure(with model: Model) {}
}

public protocol GenericCellSubview {
    init()

    func setSelected(_ selected: Bool, animated: Bool)
    func setHighlighted(_ highlighted: Bool, animated: Bool)
}

extension GenericCellSubview {
    public func setSelected(_ selected: Bool, animated: Bool) {}
    public func setHighlighted(_ highlighted: Bool, animated: Bool) {}
}

typealias GenericCellModelProtocol = TappableCellModelProtocol & ConfigurableCellModelProtocol

protocol TappableCellModelProtocol {
    var onTap: VoidBlock? { get set }
}

protocol ConfigurableCellModelProtocol {
    var disposeBag: DisposeBag { get }

    func configure(_ view: UIView)

    func reuse()
}

class GenericCellModel<CellType: GenericConfigurableCellComponent>: GenericCellModelProtocol, Hashable {
    var disposeBag = DisposeBag()

    var data: CellType.ViewData

    var onTap: VoidBlock?

    var rootView: CellType!

    init(data: CellType.ViewData) {
        self.data = data

        if let tapable = self.data as? TappableCellModelProtocol {
            self.onTap = tapable.onTap
        }
    }

    func configure(_ view: UIView) {
        guard let castedView = view as? CellType else {
            return
        }
        self.rootView = castedView
        castedView.configure(with: self.data)
    }

    func reuse() {
        self.disposeBag = DisposeBag()
    }

    static func == (lhs: GenericCellModel<CellType>, rhs: GenericCellModel<CellType>) -> Bool {
        return lhs.data == rhs.data
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.data)
    }
}
