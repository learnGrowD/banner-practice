//
//  BaseViewModel.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/01.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    var className: String {
        String(describing: type(of: self))
    }
    let disposeBag = DisposeBag()

    deinit {
        print("🍎 ViewModel deinit: \(className)")
    }
}
