//
//  TestPagerViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import RxSwift
import XLPagerTabStrip

final class TestPagerViewController: BasePagerViewController<TestPagerViewModel> {

    private var test: EntroViewProtocol?

    private let mButton = UILabel()

    override func bindToView(_ viewModel: TestPagerViewModel) {
        super.bindToView(viewModel)

        Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.test?.dismiss()
            })
            .disposed(by: disposeBag)

        mButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let viewModel = TestPanModalViewModel()
                let panModal = TestPanModal(viewModel: viewModel)
                self?.navigationController?.pushViewController(panModal, animated: true)
            })
            .disposed(by: disposeBag)
    }
    override func attribute() {
        view.backgroundColor = .white

        mButton.text = "HELLO"
    }

    override func layout() {
        super.layout()
        buttonBarView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(buttonBarView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        view.addSubview(mButton)
        mButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }


    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let alphaViewModel = TestChildAlphaViewModel()
        let alphaViewController = TestChildAlphaViewController(viewModel: alphaViewModel)

        let betaViewModel = TestChildBetaViewModel()
        let betaViewController = TestChildBetaViewController(viewModel: betaViewModel)

        return [alphaViewController, betaViewController]
    }
}
