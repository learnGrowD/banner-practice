//
//  RetryEnableProtocol.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/12.
//

import UIKit

protocol RetryEnabledProtocol where Self: SplashViewController {
    var retryContainerView: UIView { get }
    func processRetry()
}
