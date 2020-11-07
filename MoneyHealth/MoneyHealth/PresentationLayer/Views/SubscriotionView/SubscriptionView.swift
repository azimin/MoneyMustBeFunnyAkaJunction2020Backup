//
//  SubscriotionView.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit

final class SubscriptionView: UIView, GenericCellSubview {

    init() {
        super.init(frame: .zero)
        self.setupInitialLayout()
    }

    let serviceImageView = UIImageView()

    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.text = "€"
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    let paymentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .black
        label.text = "Monthly payment"
        label.alpha = 0.7
        return label
    }()

    let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .black
        return label
    }()

    let serviceCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .black
        label.alpha = 0.7
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

        self.addSubview(self.serviceImageView)
        self.serviceImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(32)
        }

        self.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }

        self.addSubview(self.currencyLabel)
        self.currencyLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.priceLabel.snp.leading).inset(-2)
            make.top.equalTo(self.priceLabel.snp.top)
        }

        self.addSubview(self.paymentLabel)
        self.paymentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel.snp.bottom)
            make.trailing.equalTo(self.priceLabel.snp.trailing)
        }

        self.addSubview(self.serviceCategoryLabel)
        self.serviceCategoryLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(self.serviceImageView.snp.leading)
        }

        self.addSubview(self.serviceNameLabel)
        self.serviceNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.serviceCategoryLabel.snp.top)
            make.leading.equalTo(self.serviceImageView.snp.leading)
        }
    }

    func setup(config: SubscriptionModel) {
        let color = UIColor(hex: config.backgroundColor)
        self.backgroundColor = color

        let whiteContrast = color.contrastRatio(with: UIColor.white)
        let blackContrast = color.contrastRatio(with: UIColor.black)

        let labelColor = whiteContrast > blackContrast ? UIColor.white : UIColor.black
        for label in [self.priceLabel, self.currencyLabel, self.paymentLabel, self.serviceNameLabel, self.serviceCategoryLabel]  {
            label.textColor = labelColor
        }

        self.priceLabel.text = "\(config.amount)"
        self.serviceNameLabel.text = "\(config.name)"
        self.serviceCategoryLabel.text = "\(config.category)"
        
        self.serviceImageView.image = UIImage(named: config.imageName)
    }
}


