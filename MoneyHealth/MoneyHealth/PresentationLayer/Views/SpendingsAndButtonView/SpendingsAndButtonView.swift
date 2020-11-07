//
//  SpendingsAndButtonView.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit

final class SpendingsAndButtonView: UIView, GenericCellSubview {
    init() {
        super.init(frame: .zero)
        self.setupInitialLayout()
    }

    let balanceView = BalanceView()
    let spendingActionButton = SpendingActionButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupInitialLayout() {
        self.backgroundColor = .clear

        self.addSubview(self.balanceView)
        self.balanceView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.53)
        }

        self.addSubview(self.spendingActionButton)
        self.spendingActionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.balanceView.snp.trailing).inset(-12)
        }
    }
}
