//
//  UIBarButtonItem+extension.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/01.
//

import UIKit

func makeNavigationItemSpacing(offset: CGFloat) -> UIBarButtonItem {
    let spacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    spacing.width =  offset
    return spacing
}

extension UIViewController {
    func makeNavigationItemSpacing(offset: CGFloat) -> UIBarButtonItem {
        let spacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacing.width =  offset
        let a = CAGradientLayer()

        return spacing
    }
}
