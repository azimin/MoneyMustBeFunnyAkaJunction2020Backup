//
//  CategoryHeaderView.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit

final class CategoryHeaderView: UIView, GenericCellSubview {
    init() {
        super.init(frame: .zero)
        self.setupInitialLayout()
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
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
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }

    }
}
