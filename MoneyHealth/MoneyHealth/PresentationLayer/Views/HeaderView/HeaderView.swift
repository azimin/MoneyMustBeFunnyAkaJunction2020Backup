//
//  HeaderView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class HeaderView: UIView {

    let avatarView = ImageViewWithProgress()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private func setupInitialLayout() {
        self.addSubview(self.avatarView)
        self.avatarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(42)
            make.size.equalTo(118)
        }

        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.avatarView.snp.bottom).offset(16)
        }


    }
}

