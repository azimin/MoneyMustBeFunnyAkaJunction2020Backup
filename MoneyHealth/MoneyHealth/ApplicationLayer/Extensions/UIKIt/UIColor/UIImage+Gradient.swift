//
//  UIImage+Gradient.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit

extension UIImage {
    public convenience init?(size: CGSize, gradientColor: [UIColor], locations: [CGFloat]? = nil) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        guard let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: gradientColor.map { $0.cgColor } as CFArray,
            locations: locations
        ) else {
            return nil
        }

        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions())
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: image)

        UIGraphicsEndImageContext()
    }
}
