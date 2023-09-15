//
//  TestPanModal.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import PanModal
import UIKit

final class TestPanModal: BaseNavigationViewController<BaseViewModel>, BasePanModalPresentable {
    var panScrollable: UIScrollView? { nil }

    let testButton = UILabel()
    let navigationBarRightItem = UIBarButtonItem()

    let rightItemButton = UIImageView(image: UIImage(systemName: "eraser.fill"))

    override func attribute() {
        super.attribute()
        view.backgroundColor = .white
        testButton.text = "HELLO"
    }

    override func bindToView(_ viewModel: BaseViewModel) {
        super.bindToView(viewModel)

        rightItemButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                print("HELLO IOS")
            })
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        title = "HELLo"
        navigationBar.topItem?.title = "HELLO"
        navigationItem.title = "HELLO"
    }

    override func layout() {
        super.layout()
        view.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        let titleLabel = UILabel()

        titleLabel.text = "HELLO"
        navigationBar.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        navigationBar.addSubview(rightItemButton)
        rightItemButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

    }
}

