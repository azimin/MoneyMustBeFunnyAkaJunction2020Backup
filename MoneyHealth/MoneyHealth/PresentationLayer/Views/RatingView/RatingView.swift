//
//  RatingView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class RatinView: UIView {

    let ratingImageView = UIImageView(image: UIImage(named: "rating"))

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private func setupInitialLayout() {
        self.addSubview(self.ratingImageView)
        self.ratingImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(18)
        }

        self.addSubview(self.ratingLabel)
        self.ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.ratingImageView.snp.trailing).offset(2)
            make.centerY.equalTo(self.ratingImageView)
            make.trailing.equalToSuperview()
        }
    }
}
