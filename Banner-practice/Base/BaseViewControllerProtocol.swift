//
//  BaseViewControllerProtocol.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

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
        layout()
        bindToView(viewModel)
        bindToViewModel(viewModel)
        viewModel.lifeCycleStatus.accept(.viewDidLoad)
        print("🍎 viewDidLoad: \(className)")
    }
    func mViewWillAppear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewWillAppear)
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
        R
        print("🍎 viewDidDisappear: \(className)")
    }
    func mDeinit() {
        viewModel.lifeCycleStatus.accept(.mDeinit)
        print("🍎 ViewController deinit: \(className)")
    }
}

protocol Storage {}
extension Storage {
    var rootViewController: UIViewController? {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController
    }

    var topMostViewController: UIViewController? {
        var topMostViewController = self.rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        while let parentViewController = topMostViewController?.parent {
            if parentViewController is UINavigationController {
                topMostViewController = parentViewController
            }

            if let presentedViewController = parentViewController.presentedViewController,
                        presentedViewController != topMostViewController {
                topMostViewController = presentedViewController
            }
        }
        return (topMostViewController?.isViewLoaded == true && topMostViewController?.view.window != nil) ? topMostViewController : nil
    }

    var depthViewController: UIViewController? {
        var depthViewController = self.topMostViewController

        /*
         TabBar
         */
        if let tabBarController = depthViewController as? UITabBarController {
            depthViewController = tabBarController.selectedViewController
        }

        /*
         Navigation
         */
        if let navigationController = depthViewController as? UINavigationController {
            depthViewController = navigationController.visibleViewController
        }
        return (depthViewController?.isViewLoaded == true && depthViewController?.view.window != nil) ? depthViewController : nil
    }
}

extension UIViewController: Storage {}
extension UIView: Storage {}
