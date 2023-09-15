//
//  TestTabBarViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/14.
//

import UIKit
import RxSwift
import RxCocoa

class TestTabBarViewController: UITabBarController {
    static let NFT    = 0
    static let META   = 1
    static let MYPAGE = 2

    /*
     초기에 정해야 되었다면 필요한 Bool
     */
//    var isSelectedConfirm = true

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     초기에 Campus를 매인 화면으로 설정하는 로직
     */
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        initScreen()
//    }

//    func initScreen() {
//        if isSelectedConfirm {
//            self.selectedIndex = MainTabBarViewController.META
//
//            isSelectedConfirm = false
//        }
//    }

//    private func generateNavController(
//        vc : UIViewController,
//        title : String,
//        image : UIImage?) -> UINavigationController {
//            vc.view.backgroundColor = .togetherWhite
//            let navController = UINavigationController(rootViewController: vc)
//            navController.tabBarItem.title = title
//            navController.tabBarItem.image = image
//
//            return navController
//        }

//    func attribute() {
//        delegate = self

//        let tabBarManager = BottomTabBarManager(tabBar)
//        tabBarManager.configure()
//    }
    func layout() {
        let mainViewController = TestMainViewController(viewModel: BaseViewModel())
        mainViewController.tabBarItem.title = "MAIN"
        mainViewController.tabBarItem.image = UIImage(systemName: "eraser.fill")
        let nftViewController = TestNFTViewController(viewModel: BaseViewModel())
        nftViewController.tabBarItem.title = "NFT"
        nftViewController.tabBarItem.image = UIImage(systemName: "eraser.fill")
        let metaViewController = TestMetaViewController(viewModel: BaseViewModel())
        metaViewController.tabBarItem.title = "META"
        metaViewController.tabBarItem.image = UIImage(systemName: "eraser.fill")

        self.viewControllers = [
            mainViewController,
            nftViewController,
            metaViewController,
        ]
    }

}


//extension MainTabBarViewController : UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
//
//        switch index {
//        case MainTabBarViewController.NFT:
//            let url = NFTWebViewUrl2()
//            let vc = CommonWebViewController(urlProtocol: url)
//
//            vc.bind(viewModel.nftViewModel)
//            self.presentViewController(
//                vc: vc,
//                modalTransitionStyle: .coverVertical,
//                modalPresentationStyle: .fullScreen
//            )
//
//        case MainTabBarViewController.META:
//            viewModel.d3ButtonTap.accept(.init())
//        case MainTabBarViewController.MYPAGE:
//            let vc = MypageViewController()
//            vc.bind(viewModel.mypageViewModel)
//            self.presentNavigationViewController(vc: vc, title: "")
//        default:
//            break
//        }
//        return false
//    }
//}
