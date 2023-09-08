//
//  AnimateNavigationBackgroundView.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/08.
//

import UIKit
import RxSwift
import RxCocoa

final class AnimateNavigationBackgroundView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: AnimationViewModel

    private let titleLabel = UILabel()

    init(frame: CGRect = .zero, viewModel: AnimationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: AnimationViewModel) {
        viewModel.getTableViewContentsOffsetY()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                let offsetY = $0
                let backgroundAlpha = offsetY / 300
                let titleAlpha = offsetY / 100

                self.alpha = backgroundAlpha
                self.titleLabel.alpha = titleAlpha
                self.titleLabel.snp.removeConstraints()
                self.titleLabel.snp.makeConstraints {
                    $0.bottom.equalToSuperview().inset(min(12, offsetY / 20))
                    $0.centerX.equalToSuperview()
                }
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        self.backgroundColor = .gray
        self.alpha = 0.0

        titleLabel.text = "HELLO TitleView"
        self.alpha = 0.0
    }

    private func layout() {
        [
            titleLabel,
        ].forEach {
            addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
    }

}
