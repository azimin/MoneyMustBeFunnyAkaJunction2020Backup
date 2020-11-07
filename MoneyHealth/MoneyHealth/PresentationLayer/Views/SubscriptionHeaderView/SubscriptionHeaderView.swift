//
//  SubscriptionHeaderView.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit

final class SubscriptionHeaderView: UIView, GenericCellSubview {

    init() {
        super.init(frame: .zero)
        self.setupInitialLayout()
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.alpha = 0.8
        return label
    }()

    let moneyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    let allSubsriptionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .init(hex: "496BE8")
        label.text = "All subscriptions ▶"
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
        self.layer.cornerRadius = 18
        self.backgroundColor = UIColor(hex: "B1060F")

        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
        }

        self.addSubview(self.moneyLabel)
        self.moneyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(self.titleLabel.snp.bottom).inset(4)
        }

        self.addSubview(self.allSubsriptionsLabel)
        self.allSubsriptionsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
        }
    }
}
