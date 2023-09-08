//
//  AnimationViewModel.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/07.
//

import Foundation
import RxSwift
import RxCocoa

final class AnimationViewModel: BaseViewModel {
    let list = BehaviorRelay<[AnimationItem]>(value: [
        .init(),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
        .init(profileImageURL: "https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg", nickName: "HELLO"),
    ])
    let tableViewOffsetY = PublishRelay<CGFloat>()


    func getTableViewContentsOffsetY() -> Signal<CGFloat> {
        tableViewOffsetY
            .asSignal(onErrorSignalWith: .empty())
    }
}
