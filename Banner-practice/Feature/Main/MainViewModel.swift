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
    let bannerList = BehaviorRelay<[MainBannerItemAttribute]>(value: [])

    init(repository: MainRepository = MainRepository()) {
        super.init()
        repository.getBannerList()
            .take(1)
            .bind(to: bannerList)
            .disposed(by: disposeBag)
    }
    //MARK: - CollectionView
    func numberOfSection() -> Int {
        return 1
    }

    func numberOfItemsInSection() -> Int {
    
        return bannerList.value.count
    }

    func getBannerData(indexPath: IndexPath) -> MainBannerItemAttribute {
        return bannerList.value[indexPath.row]
    }
}
