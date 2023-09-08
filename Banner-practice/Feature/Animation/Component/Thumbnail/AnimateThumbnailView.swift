//
//  AnimateThumbnailView.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/08.
//

import UIKit
import RxSwift
import RxCocoa

final class AnimateThumbnailView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: AnimationViewModel

    private let backgroundView = UIView()
    private let headerView = UIView()
    private let thumbnailView = UIImageView()

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let safeTopInset: CGFloat = 16
        let betweenHeaderAndThumbnail: CGFloat = 32
        let headerViewHeight: CGFloat = 44
        let thumbnailImageHeight: CGFloat = 256
        let height: CGFloat = safeTopInset + betweenHeaderAndThumbnail + headerViewHeight + thumbnailImageHeight
        return CGSize(width: width, height: height)
    }

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

                let maxAlpha: CGFloat = 1.0
                let minAlpha: CGFloat = 0.0
                let haederAlpha = max(minAlpha, min(maxAlpha, 1 - offsetY / 50))
                let imageAlpha = max(minAlpha, min(maxAlpha, 1 - offsetY / 200))

                self.headerView.alpha = haederAlpha
                self.thumbnailView.alpha = imageAlpha

                let maxImageHeight: CGFloat = 256.0
                let minImageHeight: CGFloat = 164.0

                let size = max(minImageHeight, maxImageHeight - offsetY / 4 )
                let safeGuide = window?.rootViewController?.view.safeAreaInsets.top ?? 0.0
                let headerViewInset = min(0, max(-safeGuide, -offsetY))
                self.headerView.snp.removeConstraints()
                self.headerView.snp.makeConstraints {
                    $0.height.equalTo(44)
                    $0.top.equalTo(self.safeAreaLayoutGuide).inset(16 + headerViewInset)
                    $0.leading.trailing.equalToSuperview().inset(32)
                }

                self.thumbnailView.snp.removeConstraints()
                self.thumbnailView.snp.makeConstraints {
                    $0.size.equalTo(size)
                    $0.top.equalTo(self.headerView.snp.bottom).offset(32)
                    $0.centerX.equalToSuperview()
                }
            })
            .disposed(by: disposeBag)
    }


    private func attribute() {
        headerView.backgroundColor = .purple

        thumbnailView.kf.setImage(with: URL(string: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg"))
        thumbnailView.contentMode = .scaleToFill
    }
    
    private func layout() {
        [
            backgroundView,
            headerView,
            thumbnailView,
        ].forEach {
            addSubview($0)
        }

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(44)
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.centerX.equalToSuperview()
        }
        thumbnailView.snp.makeConstraints {
            $0.height.width.equalTo(256)
            $0.top.equalTo(headerView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }
}
