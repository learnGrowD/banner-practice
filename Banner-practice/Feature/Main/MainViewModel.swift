//
//  MainViewModel.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/08/31.
//

import Foundation
import RxSwift
import RxCocoa

//ViewModel이 단독으로 존재하는 경우는 없다.
//View를 생성할때 ViewModel을 멤버로 가진다.
//View가 소멸하면 ViewModel도 메모리에서 사라진다.
class MainViewModel: BaseViewModel {
    private let bannerList = BehaviorRelay<[MainBannerItemAttribute]>(value: [])

    let navigationSettingButtonTap = PublishRelay<UITapGestureRecognizer>()
    let navigationAlarmButtonTap = PublishRelay<UITapGestureRecognizer>()
    let navigationPhotoButtonTap = PublishRelay<UITapGestureRecognizer>()

    init(repository: MainRepository = MainRepository()) {
        super.init()
        repository.getBannerList()
            .take(1)
            .bind(to: bannerList)
            .disposed(by: disposeBag)
    }
    
    func getPrimitiveBannerList() -> [MainBannerItemAttribute] {
        bannerList.value
    }

    func getPageControllNumberOfPages() -> Observable<Int> {
        bannerList
            .map { $0.count - 2 }
    }

    func getBannerList() -> Observable<[MainBannerItemAttribute]> {
        bannerList
            .asObservable()
    }

    func requestApiWithNavigationSettingButtonTap() -> Signal<UITapGestureRecognizer> {
        navigationSettingButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }

    func requestApiWithNavigationAlarmButtonTap() -> Signal<UITapGestureRecognizer> {
        navigationAlarmButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }

    func requestApiWithNavigationPhotoButtonTap() -> Signal<UITapGestureRecognizer> {
        navigationPhotoButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }
}
