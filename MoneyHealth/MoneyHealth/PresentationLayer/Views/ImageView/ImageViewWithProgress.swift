//
//  ImageViewWithProgress.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Nuke
import UIKit
import SnapKit

final class ImageViewWithProgress: UIView {

    let imageView = UIImageView()

    let progressView = ProgressView()

    var currentProgress: CGFloat {
        set {
            self.progressView.currentProgress = newValue
        }
        get {
            return progressView.currentProgress
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupInitialLayout() {
        self.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.addSubview(self.imageView)
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 45
        self.imageView.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.center.equalToSuperview()
        }
    }

    func loadImageByUrl(_ url: URL) {
        Nuke.loadImage(with: url, into: self.imageView)
    }
}
