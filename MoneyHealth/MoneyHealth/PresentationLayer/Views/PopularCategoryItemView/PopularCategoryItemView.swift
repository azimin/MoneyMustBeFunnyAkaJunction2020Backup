//
//  PopularCategoryItemView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

final class CategoryImageView: UIView {

    let iconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayout() {
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.center.equalToSuperview()
        }
    }
}

final class PopularCategoryItemView: UIView, GenericConfigurableCellComponent {
    typealias Model = PopularCategoryItemModel
    typealias ViewData = PopularCategoryItemViewData

    var model: Model?

    var disposeBag = DisposeBag()

    let iconImageView = CategoryImageView()

    let categoryTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()

    let periodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(hex: "191919").withAlphaComponent(0.2)
        return label
    }()

    let tendencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        return label
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
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
        self.layer.cornerRadius = 20
        self.backgroundColor = .white

        self.iconImageView.layer.cornerRadius = 22
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().inset(22)
        }

        self.addSubview(self.categoryTitleLabel)
        self.categoryTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(22)
        }

        self.addSubview(self.periodLabel)
        self.periodLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(16)
            make.top.equalTo(self.categoryTitleLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().inset(22)
        }

        self.addSubview(self.tendencyLabel)
        self.tendencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.periodLabel.snp.trailing).offset(6)
            make.centerY.equalTo(self.periodLabel)
        }

        self.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
        }
    }

    func configure(with model: Model) {
        self.iconImageView.iconImageView.image = model.data.categoryImage
        self.iconImageView.tintColor = .white
        self.iconImageView.backgroundColor = model.data.iconColor

        self.categoryTitleLabel.text = model.data.categoryTitle
        self.periodLabel.text = model.data.periodTitle

        if model.data.tendency > 0 {
            self.tendencyLabel.text = String(format: "%.2f%%", model.data.tendency)
            self.tendencyLabel.textColor = UIColor(hex: "1ED760")
        } else {
            self.tendencyLabel.text = String(format: "%.2f%%", model.data.tendency)
            self.tendencyLabel.textColor = .red
        }

        let amount = String(format: "$ %.2f", model.data.amount)
        
        let parts = amount.split(separator: ".")

        let attributedString = NSMutableAttributedString(
            string: amount,
            attributes: [
                .foregroundColor: UIColor.black
            ]
        )

        let rangeOfFullPart = (attributedString.string as NSString).range(of: String(parts[0]))
        let rangeOfDecimalPart = (attributedString.string as NSString).range(of: ".\(String(parts[1]))")

        attributedString.setAttributes(
            [
                .font: UIFont.systemFont(ofSize: 21, weight: .bold)
            ],
            range: rangeOfFullPart
        )

        attributedString.setAttributes(
            [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ],
            range: NSRange(location: rangeOfDecimalPart.location, length: rangeOfDecimalPart.length)
        )

        self.amountLabel.attributedText = attributedString
    }

    func reuse() {
        self.model?.reuse()
        self.model = nil
        self.amountLabel.attributedText = nil
    }
}
