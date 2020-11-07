//
//  ProgressView.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

final class ProgressView: UIView {

    let fullProgressLayer = CAShapeLayer()
    let currentProgressLayer = CAShapeLayer()

    var currentProgress: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        fullProgressLayer.frame = rect
        fullProgressLayer.strokeColor = UIColor(hex: "DADBDD").cgColor
        fullProgressLayer.fillColor = UIColor.clear.cgColor
        fullProgressLayer.lineWidth = 8
        fullProgressLayer.lineCap = .round

        let fullProgressPath = UIBezierPath(
            roundedRect: CGRect(
                x: rect.origin.x + 4,
                y: rect.origin.y + 4,
                width: rect.width - 8,
                height: rect.height - 8
            ),
            cornerRadius: rect.width / 2
        )

        fullProgressLayer.path = fullProgressPath.cgPath
        
        currentProgressLayer.frame = rect
        currentProgressLayer.strokeColor = UIColor(hex: "27D086").cgColor
        currentProgressLayer.fillColor = UIColor.clear.cgColor
        currentProgressLayer.lineWidth = 8
        currentProgressLayer.lineCap = .round
        currentProgressLayer.strokeStart = 0
        currentProgressLayer.strokeEnd = currentProgress

        let currentProgressPath = UIBezierPath(
            roundedRect: CGRect(
                x: rect.origin.x + 4,
                y: rect.origin.y + 4,
                width: rect.width - 8,
                height: rect.height - 8
            ),
            cornerRadius: rect.width / 2
        )

        currentProgressLayer.path = currentProgressPath.cgPath

        self.layer.addSublayer(self.fullProgressLayer)
        self.layer.addSublayer(self.currentProgressLayer)
    }
}

