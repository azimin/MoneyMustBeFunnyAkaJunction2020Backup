//
//  SubscriptionDetailsViewController.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit

class SubscriptionDetailsViewController: UIViewController {
    let imageView = UIImageView()

    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    let categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .init(hex: "B0B0B0")
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

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

    let paymentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.alpha = 0.6
        return label
    }()

    let paymentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    let nextTransactionDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.alpha = 0.6
        return label
    }()

    let nextTransactionDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    let totalSumTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.alpha = 0.6
        return label
    }()

    let totalSumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    let cancelButton = UIButton()

    let subscription: SubscriptionModel

    init(subscription: SubscriptionModel) {
        self.subscription = subscription
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(44)
        }

        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.categoryLabel])
        stackView.axis = .vertical

        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.imageView.snp.trailing).inset(-16)
            make.centerY.equalTo(self.imageView.snp.centerY)
        }

        let anotherStackView = UIStackView(arrangedSubviews: [self.paymentTitleLabel, self.paymentLabel, self.nextTransactionDateTitleLabel, self.nextTransactionDateLabel, self.totalSumTitleLabel, self.totalSumLabel])
        anotherStackView.setCustomSpacing(16, after: self.paymentLabel)
        anotherStackView.spacing = 2
        anotherStackView.setCustomSpacing(16, after: self.nextTransactionDateLabel)
        anotherStackView.axis = .vertical

        self.view.addSubview(anotherStackView)
        anotherStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).inset(-38)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        self.view.addSubview(cancelButton)
        cancelButton.setTitle("Cancel subscription", for: .normal)
        cancelButton.layer.cornerRadius = 20
        cancelButton.backgroundColor = .init(hex: "D73B3B")
        cancelButton.isEnabled = false
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.alpha = 0.6
        cancelButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(anotherStackView.snp.bottom).inset(-88)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaInsets.bottom).inset(40)
            make.height.equalTo(51)
        }

        self.imageView.image = self.subscription.image
        self.nameLabel.text = self.subscription.name
        self.categoryLabel.text = self.subscription.category

        self.paymentTitleLabel.text = "Monthly payment"
        let money = String(format: "€%.2f%", self.subscription.amount)
        if self.subscription.isAvarage {
            self.paymentLabel.text = "\(money) on avarage"
        } else {
            self.paymentLabel.text = money
        }

        self.nextTransactionDateTitleLabel.text = "Next transaction date"

        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMMM"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        self.nextTransactionDateLabel.text = formatter.string(from: subscription.nextCharge)

        self.totalSumTitleLabel.text = "Total spend"
        let total = String(format: "€%.2f%", self.subscription.total)
        self.totalSumLabel.text = total
    }

}
