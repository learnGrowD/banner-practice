//
//  UIIconImageView.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/01.
//

import UIKit

final class UIIconImageView: UIView {
    private let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(named: String) {
        imageView.image = UIImage(named: named)
    }

    func setImage(systemName: String) {
        imageView.image = UIImage(systemName: systemName)
    }

    private func attribute() {}

    private func layout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
