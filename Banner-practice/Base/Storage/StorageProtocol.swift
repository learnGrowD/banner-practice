//
//  StorageProtocol.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import XLPagerTabStrip

protocol StorageProtocol {}
extension UIViewController: StorageProtocol {}
extension UIView: StorageProtocol {}
extension StorageProtocol {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    var window: UIWindow? {
        sceneDelegate?.window
    }

    var commonRepository: CommonRepository {
        CommonRepository.shared
    }

    var rootViewController: UIViewController? {
        window?.rootViewController
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

        return topMostViewController
    }

    var continerViewController: UIViewController? {
        var depthViewController = commonRepository.judgeViewController.value

        /*
         TabBar
         */
        if let tabBarController = depthViewController as? UITabBarController {
            depthViewController = tabBarController
        }

        /*
         Navigation
         */
        if let navigationController = depthViewController as? UINavigationController {
            depthViewController = navigationController
        }

        /*
         XLPager
         */
        if let pagerTapViewController = depthViewController as? ButtonBarPagerTabStripViewController {
            depthViewController = pagerTapViewController
        }

        return depthViewController
    }
    var depthViewController: UIViewController? {
        var depthViewController = commonRepository.judgeViewController.value

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

        /*
         XLPager
         */
        if let pagerTapViewController = depthViewController as? ButtonBarPagerTabStripViewController {
            let currentIndex = pagerTapViewController.currentIndex
            depthViewController = pagerTapViewController.viewControllers[currentIndex]
        }

        return depthViewController
    }
}
