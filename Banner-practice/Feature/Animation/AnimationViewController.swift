//
//  AnimationViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/07.
//

import UIKit
import RxSwift
import RxCocoa

final class AnimationViewController: BaseViewController<AnimationViewModel> {
    private let backgroundView = UIView()
    private lazy var navigationBackgroundView = AnimateNavigationBackgroundView(viewModel: viewModel)
    private lazy var thumbnailView = AnimateThumbnailView(viewModel: viewModel)
    private lazy var animateTxableView = AnimateTableView(viewModel: viewModel)

    private var test: EntroViewProtocol?

    override func bindToViewModel(_ viewModel: AnimationViewModel) {
        super.bindToViewModel(viewModel)
        
        viewModel.getTableViewContentsOffsetY()
            .emit()
            .disposed(by: disposeBag)

        Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.test?.dismiss()
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🧊 Animate ViewDidLoad" + String(describing: continerViewController))
        test = CommonBlurView()
        test?.show()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🧊 Animate viewWillAppear" + String(describing: continerViewController))
    }

    override func attribute() {
        super.attribute()
        view.backgroundColor = UIColor("#212121")
        backgroundView.layer.zPosition = -2
        thumbnailView.layer.zPosition = -1

        animateTxableView.contentInset = .init(top: 0, left: 0, bottom: -56, right: 0)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundView
            .setGradient(startColor: .red.withAlphaComponent(0.3), endColor: .black.withAlphaComponent(0.3))
        navigationBackgroundView.snp.removeConstraints()
        navigationBackgroundView.snp.makeConstraints {
            $0.height.equalTo(view.safeAreaInsets.top)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

    override func layout() {
        super.layout()

        //MARK: willLayoutSubViews 배치
        view.addSubview(navigationBackgroundView)
        [
            backgroundView,
            thumbnailView,
            animateTxableView,
        ].forEach {
            view.addSubview($0)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        thumbnailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        animateTxableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
