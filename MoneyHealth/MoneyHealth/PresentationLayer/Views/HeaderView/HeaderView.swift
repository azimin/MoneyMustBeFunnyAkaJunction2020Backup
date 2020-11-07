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

    let ratingView = RatinView()

    let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        label.text = "Financial Health Rank"
        return label
    }()

    let improveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "27D086")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Improve", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
        button.layer.cornerRadius = 6
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupInitialLayout()
        self.nameLabel.text = "Egor Petrov"
        self.ratingView.ratingLabel.text = "5.0"

        self.backgroundColor = UIColor(hex: "E5E5E5")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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

        let stackView = UIStackView(
            arrangedSubviews: [
                self.ratingView,
                self.ratingTitleLabel,
                self.improveButton
            ]
        )
        stackView.setCustomSpacing(9, after: ratingView)
        stackView.setCustomSpacing(11, after: ratingTitleLabel)
        stackView.axis = .horizontal

        self.improveButton.snp.makeConstraints { make in
            make.width.equalTo(52)
            make.height.equalTo(16)
        }

        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
}

