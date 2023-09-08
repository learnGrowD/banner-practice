//
//  UIView+extension.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/07.
//

import UIKit

extension UIView {
    static var className: String {
        String(describing: type(of: self))
    }
    static var tag: String {
        String(describing: Self.self)
    }

    func setGradient(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            startColor.cgColor,
            endColor.cgColor
        ]
        self.layer.addSublayer(gradientLayer)
    }
}
