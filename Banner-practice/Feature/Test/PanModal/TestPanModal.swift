//
//  TestPanModal.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import PanModal
import UIKit

final class TestNavigationPanModal: UINavigationController, BasePanModalPresentable {
    var panScrollable: UIScrollView? { nil }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        attribute()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func attribute() {
        view.backgroundColor = .white
    }
}

final class TestPanModal: BaseViewController<BaseViewModel>, BasePanModalPresentable {
    var panScrollable: UIScrollView? { nil }

    override func attribute() {
        view.backgroundColor = .white
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "HELLO"
    }
}

