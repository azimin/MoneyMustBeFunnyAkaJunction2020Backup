//
//  MostSpendItemView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class MostSpendItemView: UIView {

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

        self.addSubview(self.comparedLabel)
        self.comparedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(21)
        }
    }
}
