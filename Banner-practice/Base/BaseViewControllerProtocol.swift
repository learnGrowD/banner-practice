//
//  BaseViewControllerProtocol.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

/*
 BaseViewControllerProtocol만 상속 받으면 된다.
 */
protocol BaseViewControllerProtocol: UIViewController {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel { get set }
    func bindToView(_ viewModel: ViewModel)
    func bindToViewModel(_ viewModel: ViewModel)
    func attribute()
    func layout()
}

extension BaseViewControllerProtocol {
    var className: String {
        String(describing: type(of: self))
    }

    func mInit() {
        attribute()
        viewModel.lifeCycleStatus.accept(.mInit)
        print("🍎 init: \(className)")
    }

    func mViewDidLoad() {
        /*
         judgeViewController 넣어주기
         */
        acceptJudgeViewController(value: self)

        layout()
        bindToView(viewModel)
        bindToViewModel(viewModel)
        viewModel.lifeCycleStatus.accept(.viewDidLoad)
        print("🍎 viewDidLoad: \(className)")
    }
    func mViewWillAppear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewWillAppear)
        /*
         judgeViewController 넣어주기
         */
        acceptJudgeViewController(value: self)

        print("🍎 viewWillAppear: \(className)")
    }
    func mViewDidAppear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewDidAppear)
        print("🍎 viewDidAppear: \(className)")
    }
    func mViewWillLayoutSubviews() {
        viewModel.lifeCycleStatus.accept(.viewWillLayoutSubviews)
        print("🍎 viewWillLayoutSubviews: \(className)")
    }
    func mViewDidLayoutSubviews() {
        viewModel.lifeCycleStatus.accept(.viewDidLayoutSubviews)
        print("🍎 viewDidLayoutSubviews: \(className)")
    }
    func mViewWillDisappear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewWillDisAppear)
        print("🍎 viewWillDisappear: \(className)")
    }
    func mViewDidDisappear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewDidDisAppear)
        print("🍎 viewDidDisappear: \(className)")
    }
    func mDeinit() {
        viewModel.lifeCycleStatus.accept(.mDeinit)
        print("🍎 ViewController deinit: \(className)")
    }
}

extension BaseViewControllerProtocol {
    func acceptJudgeViewController(value: UIViewController?) {
        //XLPager의 자식이 아닌 다른 ViewController에서는 depthViewController를 업데이트 시켜준다.
        if !(self is UIViewController & IndicatorInfoProvider) {
            commonRepository.judgeViewController.accept(value)
            print("🧊 accept depthViewController: \(String(describing: value.self))")
        }
    }
}
