//
//  SpendingView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import Nuke

final class SpendingView: UIView, GenericConfigurableCellComponent {
    
    typealias Model = SpendingItemModel
    typealias ViewData = SpendingViewData

    let imageView = UIImageView()

    var disposeBag = DisposeBag()

    var model: SpendingItemModel?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(hex: "E5E5E5")

        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        superview?.layer.cornerRadius = 20
        superview?.layer.masksToBounds = true
    }
    
    private func setupInitialLayout() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(6)
        }
    }

    func configure(with model: SpendingItemModel) {
        self.titleLabel.text = model.data.title
        Nuke.loadImage(with: model.data.imageUrl, into: self.imageView)
    }
}
