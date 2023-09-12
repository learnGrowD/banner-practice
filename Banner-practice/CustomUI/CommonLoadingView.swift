//
//  CommonLoadingView.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/11.
//

import Foundation
import Lottie
import RxSwift
import RxCocoa

//reqeust
//1. 특정 시간 loaidngView show
//2. 특정 시간 UserInteraction 해제
//3. -> UserInteraction 해제 했을때 페이지 나가면 loadingView 없애기?
//*** time out 이랑 충돌이....
class CommonLoadingView: Storage {
    private var disposeBag: DisposeBag? = DisposeBag()
    private var loadingView: LottieAnimationView? = LottieAnimationView(name: LottieResourceStorage.defaultLoading)
    private var milliseconds = 0

    init(milliseconds: Int = 800) {
        self.milliseconds = milliseconds
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        blockTouch()
        
        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.microseconds(milliseconds), scheduler: MainScheduler.instance)
            .debug()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if $0 == 0 {
                    self.loadingView?.isHidden = false
                    self.loadingView?.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
                    self.disposeBag = nil
                }
            })
            .disposed(by: disposeBag)
    }

    func dissmiss() {
        allowTouch()

        disposeBag = nil

        loadingView?.isHidden = true
        loadingView?.stop()
        loadingView?.removeFromSuperview()
        loadingView = nil
    }

    private func attribute() {
        loadingView?.isHidden = true
        loadingView?.contentMode = .scaleAspectFill
        loadingView?.loopMode = .loop
        loadingView?.play()
    }

    private func layout() {
        let superView = topMostViewController?.view
        guard let loadingView = loadingView,
              let superView = superView else { return }
        superView.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.size.equalTo(164)
            $0.center.equalToSuperview()
        }
    }

    private func blockTouch() {
        window?.isUserInteractionEnabled = false
    }

    private func allowTouch() {
        window?.isUserInteractionEnabled = true
    }
}

