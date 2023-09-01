//
//  TestViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/01.
//

import UIKit
import RxSwift
import RxCocoa

class TestViewController: UIViewController {
    let diseposeBag = DisposeBag()
    let button = UILabel()


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind() {
        button.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let mainViewModel = MainViewModel()
                let mainViewController = MainViewController(viewModel: mainViewModel)
                self?.present(mainViewController, animated: true)
            })
            .disposed(by: diseposeBag)
    }

    func layout() {
        button.text = "HELLO"
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }



}
