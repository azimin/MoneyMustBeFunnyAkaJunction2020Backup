//
//  ShowSpendsInAR.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class ShowSpendsInAR: UIControl {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayout() {
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
