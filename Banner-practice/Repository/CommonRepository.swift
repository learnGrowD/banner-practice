//
//  CommonRepository.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import Foundation
import RxSwift
import RxCocoa

class CommonRepository {
    static let shared = CommonRepository()
    private init() {}

    let judgeViewController = BehaviorRelay<UIViewController?>(value: nil)
}
