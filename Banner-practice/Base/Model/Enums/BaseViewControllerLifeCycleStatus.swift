//
//  BaseViewControllerLifeCycleStatus.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/04.
//

import Foundation

enum BaseViewControllerLifeCycleStatus {
    case notInit
    case mInit
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
    case viewWillDisAppear
    case viewDidDisAppear
    case mDeinit
}
