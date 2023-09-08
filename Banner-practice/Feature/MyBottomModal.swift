//
//  MyBottomModal.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class MyBottomModal: BaseBottomModal<MyBottomModalViewModel> {
    let profileImageView = UIImageView()
    let nickNameLabel = UILabel()
    let backgroundImageView = UIImageView()

    override func bindToViewModel(_ viewModel: MyBottomModalViewModel) {
        super.bindToViewModel(viewModel)

        viewModel.profileURL()
            .drive(onNext: { [weak self] in
                self?.profileImageView.kf.setImage(with: $0)
            })
            .disposed(by: disposeBag)

        viewModel.nickName()
            .drive(nickNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.backgroundURL()
            .drive(onNext: { [weak self] in
                self?.backgroundImageView.kf.setImage(with: $0)
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 32
        profileImageView.contentMode = .scaleAspectFill

        nickNameLabel.font = UIFont.systemFont(ofSize: 20)

        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    override func layout() {
        super.layout()
        [
            backgroundImageView,
            profileImageView,
            nickNameLabel,
        ].forEach {
            view.addSubview($0)
        }

        backgroundImageView.snp.makeConstraints {
            $0.height.equalTo(216)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        profileImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.bottom.equalTo(backgroundImageView.snp.top).offset(-16)
            $0.leading.equalToSuperview().inset(16)
        }

        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }

        self.layoutContainerView(topView: profileImageView)
    }
}

