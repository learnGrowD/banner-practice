//
//  MyBottomModalModel.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/05.
//

import Foundation
import RxSwift
import RxCocoa

final class MyBottomModalViewModel: BaseViewModel {

    func profileURL() -> Driver<URL?> {
        Observable<String>.just("https://i.pinimg.com/originals/31/51/2a/31512a374041bcc7ba0983f37b67016e.jpg")
            .map { URL(string: $0) }
            .asDriver(onErrorDriveWith: .empty())
    }

    func nickName() -> Driver<String> {
        Observable<String>.just("will_d")
            .asDriver(onErrorDriveWith: .empty())
    }

    func backgroundURL() -> Driver<URL?> {
        Observable<String>.just("https://s.france24.com/media/display/490fcec0-7347-11ed-8477-005056a90284/w:980/p:16x9/000_32YC632.jpg")
            .map { URL(string: $0) }
            .asDriver(onErrorDriveWith: .empty())
    }
}
