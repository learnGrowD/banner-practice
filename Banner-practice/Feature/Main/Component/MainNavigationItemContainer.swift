//
//  MainNavigationItemContainer.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/06.
//

import UIKit
import RxSwift
import RxCocoa

final class MainNavigationItemContainer {
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    private let navigationItem: UINavigationItem

    private let navigationSettingButton = UIIconImageView()
    private let navigationAlarmButton = UIIconImageView()
    private let navigationPhotoButton = UIIconImageView()

    init(navigationItem: UINavigationItem, viewModel: MainViewModel) {
        self.navigationItem = navigationItem
        self.viewModel = viewModel
        attribute()
        layout()
        register()
        bindToView(viewModel)
        bindToViewModel(viewModel)
    }

    private func bindToView(_ viewModel: MainViewModel) {
        navigationSettingButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.navigationSettingButtonTap)
            .disposed(by: disposeBag)

        navigationAlarmButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.navigationAlarmButtonTap)
            .disposed(by: disposeBag)

        navigationPhotoButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.navigationPhotoButtonTap)
            .disposed(by: disposeBag)
    }

    private func bindToViewModel(_ viewModel: MainViewModel) {}

    private func attribute() {
        navigationSettingButton.setImage(systemName: "bolt.fill")
        navigationAlarmButton.setImage(systemName: "bolt.fill")
        navigationPhotoButton.setImage(systemName: "bolt.fill")
    }

    private func register() {
        let navigationSpacing = makeNavigationItemSpacing(offset: 16)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: navigationSettingButton),
            navigationSpacing,
            UIBarButtonItem(customView: navigationAlarmButton),
            navigationSpacing,
            UIBarButtonItem(customView: navigationPhotoButton)
        ]
    }

    private func layout() {
        navigationSettingButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        navigationAlarmButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        navigationPhotoButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
    }
}
