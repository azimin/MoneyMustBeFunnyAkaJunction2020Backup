//
//  MostSpendItemView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MostSpendItemView: UIView, GenericConfigurableCellComponent {
    
    typealias ViewData = MostSpendItemViewData
    typealias Model = MostSpendItemModel

    var disposeBag = DisposeBag()

    var model: MostSpendItemModel?

    let iconImageView = CategoryImageView()

    let amountLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()

    let transactionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(hex: "191919").withAlphaComponent(0.2)
        return label
    }()

    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        self.descriptionLabel.numberOfLines = 0

        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        self.superview?.layer.cornerRadius = 20
        self.superview?.backgroundColor = .white
    }
    
    private func setupInitialLayout() {
        self.addSubview(self.iconImageView)
        self.iconImageView.layer.cornerRadius = 22
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.top.equalToSuperview().offset(16)
        }

        self.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(11)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.top.equalToSuperview().offset(22)
        }

        self.addSubview(self.transactionsLabel)
        self.transactionsLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(11)
            make.top.equalTo(self.amountLabel.snp.bottom).offset(2)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(21)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    func configure(with model: MostSpendItemModel) {
        self.iconImageView.iconImageView.image = model.data.icon
        self.iconImageView.tintColor = .white
        self.iconImageView.backgroundColor = UIColor(hex: "FF9C87")

        self.amountLabel.text = String(format: "$ %.2f", model.data.amount)
    
        if model.data.numberOfTransactions == 1 {
            self.transactionsLabel.text = "\(model.data.numberOfTransactions) transaction"
        } else {
            self.transactionsLabel.text = "\(model.data.numberOfTransactions) transactions"
        }

        let attributedString = NSMutableAttributedString(
            string: "You spend",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ])
        
        let image: UIImage
        let color: UIColor
        
        let percentString: String
        let changesString: String
        if model.data.percent > 0 {
            image = UIImage(named: "Up")!
            color = UIColor(hex: "1ED760")
            percentString = String(format: "%.2f%%", model.data.percent)
            changesString = "more on"
        } else {
            image = UIImage(named: "Down")!
            color = UIColor(hex: "FF2D6C")
            percentString = String(format: "%.2f%%", model.data.percent * -1)
            changesString = "less on"
        }

        let productImageAttachment = NSTextAttachment()
        productImageAttachment.image = image
        productImageAttachment.bounds = .init(x: 0, y: 0, width: 10, height: 10)
        let productAttachmentString = NSAttributedString(attachment: productImageAttachment)
        
        attributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: color,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))
        attributedString.append(productAttachmentString)
        attributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: color,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))

        attributedString.append(
            .init(
                string: percentString,
                attributes:
                    [
                        .foregroundColor: color,
                        .font: UIFont.systemFont(ofSize: 15, weight: .bold)
                    ]
            )
        )

        attributedString.append(
            .init(
                string: "\u{00a0}",
                attributes:
                    [
                        .foregroundColor: color,
                        .font: UIFont.systemFont(ofSize: 15, weight: .bold)
                    ]
            )
        )
        
        attributedString.append(
            .init(
                string: changesString,
                attributes:
                    [
                    .foregroundColor: UIColor.black,
                    .font: UIFont.systemFont(ofSize: 15, weight: .medium)
                    ]
            )
        )
        
        attributedString.append(
            .init(
                string: "\u{00a0}",
                attributes:
                    [
                        .foregroundColor: color,
                        .font: UIFont.systemFont(ofSize: 15, weight: .bold)
                    ]
            )
        )
        
        attributedString.append(
            .init(
                string: model.data.category,
                attributes:
                    [
                    .foregroundColor: UIColor(hex: "FF9C87"),
                    .font: UIFont.systemFont(ofSize: 15, weight: .bold)
                    ]
            )
        )
        
        attributedString.append(
            .init(
                string: "\u{00a0}",
                attributes:
                    [
                        .foregroundColor: color,
                        .font: UIFont.systemFont(ofSize: 15, weight: .bold)
                    ]
            )
        )
        
        attributedString.append(
            .init(
                string: "compared to the last \(model.data.period.rawValue)",
                attributes:
                    [
                    .foregroundColor: UIColor.black,
                    .font: UIFont.systemFont(ofSize: 15, weight: .medium)
                    ]
            )
        )
        
        self.descriptionLabel.attributedText = attributedString
    }
}
