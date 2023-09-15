//
//  TestChildBetaViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import XLPagerTabStrip

final class TestChildBetaViewController: BaseViewController<TestChildBetaViewModel>, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: "Beta")
    }
}
