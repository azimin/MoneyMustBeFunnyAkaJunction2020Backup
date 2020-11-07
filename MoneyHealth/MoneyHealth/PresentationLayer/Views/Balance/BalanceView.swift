//
//  BalanceView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class BalanceView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.text = "Total Balance"
        return label
    }()

    let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.text = "$12,032.14"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 20

        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInitialLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }

        self.addSubview(self.balanceLabel)
        self.balanceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
}
