//
//  BaseViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/01.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewControllerProtocol: UIViewController {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel { get set }
    func bindToView()
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
        print("🍎 init: \(className)")
    }

    func mViewDidLoad() {
        layout()
        bindToView()
        bindToViewModel(viewModel)
        print("🍎 viewDidLoad: \(className)")
    }
    func mViewWillAppear(_ animated: Bool) {
        print("🍎 viewWillAppear: \(className)")
    }
    func mViewDidAppear(_ animated: Bool) {
        print("🍎 viewDidAppear: \(className)")
    }
    func mViewWillDisappear(_ animated: Bool) {
        print("🍎 viewWillDisappear: \(className)")
    }
    func mViewDidDisappear(_ animated: Bool) {
        print("🍎 viewDidDisappear: \(className)")
    }
    func mDeinit() {
        print("🍎 ViewController deinit: \(className)")
    }
}

class BaseViewController<ViewModel: BaseViewModel>: UIViewController, BaseViewControllerProtocol {
    typealias ViewModel = ViewModel

    var viewModel: ViewModel
    let disposeBag = DisposeBag()

    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, viewModel: ViewModel) {
        self.viewModel = viewModel
        print("🍎 ViewModel init: \(viewModel.className)")
        super.init(nibName: nil, bundle: nil)
        self.mInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindToView() {}

    func bindToViewModel(_ viewModel: ViewModel) {}

    func attribute() {}

    func layout() {}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mViewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mViewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mViewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mViewDidDisappear(animated)
    }
    deinit {
        self.mDeinit()
    }
}

