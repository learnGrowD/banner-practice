//
//  SplashViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/05.
//
import UIKit

final class SplashViewController: BaseViewController<SplashViewModel> {

    let button = UILabel()

    override func bindToView(_ viewModel: SplashViewModel) {
        super.bindToView(viewModel)
        button.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let animateViewModel = AnimationViewModel()
                let animateViewController = AnimationViewController(viewModel: animateViewModel)
                self?.navigationController?.pushViewController(animateViewController, animated: true
                )
            })
            .disposed(by: disposeBag)

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