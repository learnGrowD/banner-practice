//
//  SplashViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/05.
//
import UIKit
import Lottie
import RxSwift
import RxCocoa



final class SplashViewController: BaseViewController<SplashViewModel>, RetryEnabledProtocol {
    func processRetry() {
        print("이것이 Retry다!!")
    }

    var retryContainerView: UIView {
        return self.view
    }

    let button = UILabel()

    let list = BehaviorRelay<[String]>(value: [""])
    lazy var emptyView = CommonEmptyView<[String]>(list: list.asObservable())
    var retryView: CommonRetryView?

    override func bindToView(_ viewModel: SplashViewModel) {
        super.bindToView(viewModel)
        button.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let rootViewController = TestPanModal(viewModel: BaseViewModel())
                self?.presentPanModal(rootViewController)
            })
            .disposed(by: disposeBag)

//        Observable<Int>.interval(.seconds(3), scheduler: MainScheduler.instance)
//            .bind(onNext: { [weak self]  in
//                if $0 == 0 {
//                    self?.retryView = CommonRetryView()
//                }
//            })
//            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBlue
        button.text = "화면전환"
        emptyView.setEmptyName(name: "이것이 empty다")
    }

    override func layout() {
        super.layout()
        view.addSubview(button)
        view.addSubview(emptyView)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
