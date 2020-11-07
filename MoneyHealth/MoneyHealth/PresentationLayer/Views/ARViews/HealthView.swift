//
//  HealthView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 08.11.2020.
//

import UIKit
import SnapKit

final class HealthView: UIView {
    
    let helthContanerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 27
        return view
    }()
    
    let healthScoreLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Financial Health"
        return label
    }()

    let titleBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    let balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    let periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    let totalSpending = UILabel()
    let spendingsChangeLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.helthContanerView.layer.cornerRadius = self.helthContanerView.bounds.width / 2
    }

    init(
        healthScore: Double,
        balance: Double,
        period: Period,
        periodSpend: Double,
        periodSpendChange: Double
    ) {
        super.init(frame: .zero)

        self.healthScoreLabel.text = String(format: "%.2f%", healthScore)
        self.balanceLabel.text = "$ \(balance)"
        self.periodLabel.text = "This \(period.rawValue)"
        
        let attributedString = NSMutableAttributedString(
            string: "Spedings",
            attributes:
                [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                ]
        )

        attributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))

        attributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))
    
        attributedString.append(
            .init(
                string: String(format: "€%.2f%", periodSpend),
                attributes:
                    [
                        .foregroundColor: UIColor(hex: "1ED760"),
                        .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                    ]
            )
        )
        
        self.totalSpending.attributedText = attributedString
        
        let spendingsAttributedString = NSMutableAttributedString(
            string: "",
            attributes:
                [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                ]
        )
    
        let downImageAttachment = NSTextAttachment()
        downImageAttachment.image = periodSpendChange > 0 ? UIImage(named: "Up") : UIImage(named: "Down")
        downImageAttachment.bounds = .init(x: 0, y: 0, width: 10, height: 10)
        let downAttachString = NSAttributedString(attachment: downImageAttachment)

        spendingsAttributedString.append(downAttachString)
    
        spendingsAttributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))

        spendingsAttributedString.append(
            .init(
                string: String(format: "%.2f%%", periodSpendChange * 100),
                attributes:
                    [
                        .foregroundColor: periodSpendChange > 0 ? UIColor(hex: "1ED760") : UIColor.red,
                        .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                    ]
            )
        )
        
        self.spendingsChangeLabel.attributedText = spendingsAttributedString
        
        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInitialLayout() {
        self.addSubview(self.helthContanerView)
        self.helthContanerView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(self.helthContanerView.snp.height)
        }

        self.helthContanerView.addSubview(self.healthScoreLabel)
        self.healthScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.helthContanerView.snp.trailing).offset(15)
            make.centerY.equalTo(self.helthContanerView)
        }

        self.addSubview(titleBalanceLabel)
        self.titleBalanceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.helthContanerView.snp.bottom).offset(36)
        }

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fill

        stackView.addArrangedSubview(self.balanceLabel)
        stackView.addArrangedSubview(self.periodLabel)

        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(periodLabel)
        self.periodLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.balanceLabel.snp.bottom).offset(16)
        }

        self.addSubview(self.totalSpending)
        self.totalSpending.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(3)
            make.bottom.equalToSuperview()
        }

        self.addSubview(self.spendingsChangeLabel)
        self.spendingsChangeLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.totalSpending.snp.trailing).offset(20)
            make.bottom.equalToSuperview()
        }
    }
}
