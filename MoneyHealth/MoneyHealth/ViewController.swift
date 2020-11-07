//
//  ViewController.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 06.11.2020.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let progressView = HeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.view.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        progressView.avatarView.currentProgress = 1
    }
}

