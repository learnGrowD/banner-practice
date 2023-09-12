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

final class SplashViewController: BaseViewController<SplashViewModel> {

    let button = UILabel()
    var loadingView: CommonLoadingView?

    override func bindToView(_ viewModel: SplashViewModel) {
        super.bindToView(viewModel)
        button.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                CommonToast.Builder()
                    .setMessage(message: "HELLO")
                    .setOnClickDelegate { _ in
                        print("이거는 가능한건지!!")
                    }
                    .build(status: .top)
                    .show()
//                let animateViewModel = AnimationViewModel()
//                let animateViewController = AnimationViewController(viewModel: animateViewModel)
//                self?.navigationController?.pushViewController(animateViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadingView = CommonLoadingView()
        loadingView?.show()
    }

    override func attribute() {
        super.attribute()
        view.backgroundColor = .white
        button.text = "화면전환"
    }

    override func layout() {
        super.layout()
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
