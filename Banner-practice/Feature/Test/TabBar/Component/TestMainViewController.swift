//
//  TestMainViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import RxSwift
import RxCocoa


final class TestMainViewController: BaseViewController<BaseViewModel> {
    let testButton = UILabel()

    override func bindToView(_ viewModel: BaseViewModel) {
        super.bindToView(viewModel)

        testButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let bbb = TestPagerViewModel()
                let ccc = TestPanModal(viewModel: bbb)
                self?.navigationController?.pushViewController(ccc, animated: true)
            })
            .disposed(by: disposeBag)

    }

    override func attribute() {
        super.attribute()
        testButton.text = "BUTTON"
    }

    override func layout() {
        super.layout()
        view.addSubview(testButton)

        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
