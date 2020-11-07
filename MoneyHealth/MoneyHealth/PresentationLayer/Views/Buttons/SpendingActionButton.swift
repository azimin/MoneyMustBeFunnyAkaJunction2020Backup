//
//  ShowSpendsInAR.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class SpendingActionButton: UIControl {

    let gradientView = UIImageView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = "Spendings in AR"
        label.numberOfLines = 2
        return label
    }()

    let iconImageView = UIImageView(image: UIImage(named: "AR"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialLayout()
    
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let image = UIImage(
            size: self.bounds.size,
            gradientColor: [
                UIColor.init(hex: "AB6CDD"),
                UIColor.init(hex: "EF3C7C"),
            ],
            locations: [0, 1.0]
        )
        self.gradientView.image = image
    }
    
    private func setupInitialLayout() {
        self.addSubview(self.gradientView)
        self.gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(15)
        }

        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.bottom.trailing.equalToSuperview().inset(12)
        }
    }
}
