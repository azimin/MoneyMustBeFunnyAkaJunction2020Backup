//
//  GenericCollectionViewCell.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

public final class GenericCollectionViewCell<T: UIView>: UICollectionViewCell, ReusableView where T: GenericCellSubview {
    let customSubview = T()
    weak var reusableComponent: ReusableComponent?

    override public func prepareForReuse() {
        super.prepareForReuse()
        self.reusableComponent?.reuse()

        if let reuseView = self.customSubview as? ReusableComponent {
            reuseView.reuse()
        }
    }

    public init() {
        super.init(frame: .zero)
        self.setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    private func setup() {
        self.contentView.addSubview(self.customSubview)
        self.customSubview.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        self.customSubview.setSelected(self.isSelected, animated: false)
    }

    override public var isSelected: Bool {
        didSet {
            self.customSubview.setSelected(self.isSelected, animated: false)
        }
    }

    override public func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return self.customSubview.systemLayoutSizeFitting(targetSize)
    }
}
