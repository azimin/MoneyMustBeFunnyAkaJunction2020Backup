//
//  HeaderView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HeaderView: UIView, GenericConfigurableCellComponent {
    typealias Model = HeaderItemModel
    typealias ViewData = HeaderItemViewData

    var model: HeaderItemModel?

    var disposeBag = DisposeBag()

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
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.layer.cornerRadius = 6
        return button
    }()

    let spendingsAndButtonView = SpendingsAndButtonView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupInitialLayout()

        self.spendingsAndButtonView.update(style: .main)
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
        }

        self.addSubview(self.spendingsAndButtonView)
        self.spendingsAndButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(49)
            make.height.equalTo(128)
            make.bottom.equalToSuperview()
        }
    }

    func configure(with model: HeaderItemModel) {
        self.model = model
        self.bindOutput(from: model)
    }

    func bindOutput(from model: HeaderItemModel) {
        model.imageURL
            .subscribe(onNext: { [unowned self] in
                guard let url = $0 else {
                    return
                }
                self.avatarView.loadImageByUrl(url)
            })
            .disposed(by: self.disposeBag)

        model.name
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)

        model.balance
            .map { return "$\($0)" }
            .bind(to: self.spendingsAndButtonView.balanceView.balanceLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        model.rating
            .map { return String(format: "%.2f%", $0) }
            .bind(to: self.ratingView.ratingLabel.rx.text)
            .disposed(by: self.disposeBag)

        model.rating
            .map { return $0/5 }
            .subscribe(onNext: { [unowned self] in
                self.avatarView.currentProgress = CGFloat($0)
            })
            .disposed(by: self.disposeBag)

        self.spendingsAndButtonView.spendingActionButton.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: {
                NotificationCenter.default.post(
                    name: .init(rawValue: "pushAR"),
                    object: nil
                )
            })
            .disposed(by: self.disposeBag)
    }
}

