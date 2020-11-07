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

    let iconImageView = UIImageView()

    let amountLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()

    let transactionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        return label
    }()

    let youSpendLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.text = "You spend"
        return label
    }()

    let directionImageView = UIImageView()

    let percentLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()

    let moreLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.text = "more on"
        return label
    }()

    let categoryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    
    let comparedLabel: UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 15, weight: .medium)
         label.textColor = .black
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayout() {
        self.addSubview(self.iconImageView)
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

        let stackView = UIStackView(
            arrangedSubviews: [
                self.youSpendLabel,
                self.directionImageView,
                self.percentLabel,
                self.moreLabel,
                self.categoryLabel
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 4

        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.top.equalTo(self.iconImageView.snp.bottom).offset(16)
        }

        self.directionImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
        }

        self.addSubview(self.comparedLabel)
        self.comparedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(21)
        }
    }

    func configure(with model: MostSpendItemModel) {
        self.iconImageView.image = model.data.icon
        self.amountLabel.text = String(format: "$ %.2f", model.data.amount)
    
        if model.data.numberOfTransactions == 1 {
            self.transactionsLabel.text = "\(model.data.numberOfTransactions) transaction"
        } else {
            self.transactionsLabel.text = "\(model.data.numberOfTransactions) transactions"
        }

        if model.data.percent > 0 {
            self.directionImageView.image = UIImage(named: "Up")
            self.percentLabel.text = String(format: "%.2f%%", model.data.percent)
            self.percentLabel.textColor = UIColor(hex: "1ED760")
        } else {
            self.directionImageView.image = UIImage(named: "Down")
            self.percentLabel.text = String(format: "%.2f%%", model.data.percent)
            self.percentLabel.textColor = UIColor(hex: "FF2D6C")
        }

        self.categoryLabel.text = model.data.category.rawValue
        self.categoryLabel.textColor = UIColor(hex: "006F46")
        
        self.comparedLabel.text = "compared to the \(model.data.period)"
    }
}
