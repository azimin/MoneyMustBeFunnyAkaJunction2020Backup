//
//  StoryViewController.swift
//  MoneyHealth
//
//  Created by Alexander on 11/8/20.
//

import UIKit
import SnapKit
import AVKit

class StoryViewController: UIViewController {

    let closeButton = UIButton()
    private let videoView = AVPlayerLayer()
    let url: String

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.view.layer.addSublayer(self.videoView)

        self.videoView.frame = self.view.bounds
        self.videoView.videoGravity = .resizeAspectFill
        self.videoView.player = AVPlayer(url: URL(string: self.url)!)
        self.videoView.player?.play()

        self.closeButton.setTitle("CLOSE", for: .normal)
        self.closeButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        self.closeButton.setTitleColor(.black, for: .normal)
        self.closeButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.closeButton.layer.cornerRadius = 12
        self.view.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(60)
            make.top.equalToSuperview().inset(40)
        }
        self.closeButton.addTarget(self, action: #selector(self.closeScreen), for: .touchUpInside)
    }

    @objc
    func closeScreen() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.videoView.frame = self.view.bounds
    }
}

