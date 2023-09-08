//
//  AnimateHeaderTableViewCell.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/07.
//

import UIKit

final class AnimateHeaderTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    private func layout() {
        contentView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: UIScreen.main.bounds.width, height: 256 + 32 + 16 + 44))
        }
    }
}
