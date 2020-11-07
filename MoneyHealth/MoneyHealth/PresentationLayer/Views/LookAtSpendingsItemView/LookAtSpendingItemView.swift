//
//  LookAtSpendingItemView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit
import SnapKit

final class LookAtSpendingItemView: UIView {

    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Look at your spendings"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        layout.scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInitialLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview()
        }

        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(180)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
    }
}
