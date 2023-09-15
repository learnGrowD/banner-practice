//
//  TestPanModal.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import PanModal
import UIKit

final class TestPanModalNavigationViewController: UINavigationController {
    init(rootViewController: TestPanModal) {
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TestPanModalNavigationViewController: PanModalPresentable {
    var showDragIndicator: Bool {
        return false
    }

    var springDamping: CGFloat {
        return 1.0
    }

    var topOffset: CGFloat {
        return 0.0
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .maxHeight
    }

    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    var anchorModalToLongForm: Bool {
        return false
    }
}

final class TestPanModal: BaseViewController<BaseViewModel> {

    override func attribute() {
        view.backgroundColor = .white
    }
}

