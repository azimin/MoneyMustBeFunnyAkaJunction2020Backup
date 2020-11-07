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
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
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

    let incomeLabel = UILabel()
    let spendingsLabel = UILabel()

    init(
        healthScore: Double,
        balance: Double,
        period: Period,
        income: Double,
        spendings: Double
    ) {
        super.init(frame: .zero)

        self.healthScoreLabel.text = String(format: "%.2f%", healthScore)
        self.balanceLabel.text = "$ \(balance)"
        self.periodLabel.text = "This \(period.rawValue)"
        
        let attributedString = NSMutableAttributedString(
            string: "Income",
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
    
        let upImageAttachment = NSTextAttachment()
        upImageAttachment.image = UIImage(named: "Up")
        upImageAttachment.bounds = .init(x: 0, y: 0, width: 10, height: 10)
        let upAttachString = NSAttributedString(attachment: upImageAttachment)

        attributedString.append(upAttachString)

        attributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))
    
        attributedString.append(
            .init(
                string: String(format: "%.2f%", income),
                attributes:
                    [
                        .foregroundColor: UIColor(hex: "1ED760"),
                        .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                    ]
            )
        )
        
        self.incomeLabel.attributedText = attributedString
        
        let spendingsAttributedString = NSMutableAttributedString(
            string: "Spendings",
            attributes:
                [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                ]
        )

        spendingsAttributedString.append(.init(
            string: "\u{00a0}",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]
        ))
    
        let downImageAttachment = NSTextAttachment()
        downImageAttachment.image = UIImage(named: "Down")
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
                string: String(format: "%.2f%", spendings),
                attributes:
                    [
                        .foregroundColor: UIColor(hex: "1ED760"),
                        .font: UIFont.systemFont(ofSize: 13, weight: .bold)
                    ]
            )
        )
        
        self.spendingsLabel.attributedText = attributedString
        
        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInitialLayout() {
        self.helthContanerView.addSubview(self.healthScoreLabel)
        self.healthScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(54)
        }

        self.addSubview(self.helthContanerView)
        self.helthContanerView.snp.makeConstraints { make in
            make.size.equalTo(54)
            make.leading.top.equalToSuperview()
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

        self.addSubview(balanceLabel)
        self.balanceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.titleBalanceLabel.snp.bottom).offset(36)
        }
        
        self.addSubview(periodLabel)
        self.periodLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.balanceLabel.snp.bottom).offset(28)
        }

        self.addSubview(self.incomeLabel)
        self.incomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(3)
            make.top.equalTo(self.periodLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }

        self.addSubview(self.spendingsLabel)
        self.spendingsLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.incomeLabel.snp.trailing).offset(3)
            make.top.equalTo(self.periodLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
