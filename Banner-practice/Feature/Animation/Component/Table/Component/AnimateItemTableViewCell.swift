//
//  AnimateItemTableViewCell.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/07.
//

import UIKit

struct AnimationItem {
    let profileImageURL: String
    let nickName: String
    init() {
        self.profileImageURL = ""
        self.nickName = ""
    }
    init(profileImageURL: String, nickName: String) {
        self.profileImageURL = profileImageURL
        self.nickName = nickName
    }
}
final class AnimateItemTableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let nickNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI(data: AnimationItem) {
        profileImageView.kf.setImage(with: URL(string: data.profileImageURL))
        nickNameLabel.text = data.nickName
    }

    private func attribute() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 16

        backgroundColor = .clear
        contentView.backgroundColor = .gray
    }

    private func layout() {
        [
            profileImageView,
            nickNameLabel
        ].forEach {
            contentView.addSubview($0)
        }
        //Cell 사이즈 결정
        contentView.snp.makeConstraints {
            let width = UIScreen.main.bounds.width
            let height: CGFloat = 32
            let topPadding: CGFloat = 16
            let bottomPadding: CGFloat = 16
            $0.size.equalTo(CGSize(width: width,
                                   height: topPadding + height + bottomPadding))
        }
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
    }
}
