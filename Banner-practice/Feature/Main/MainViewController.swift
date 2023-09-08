//
//  MainViewController.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/08/31.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit

final class MainViewController: BaseViewController<MainViewModel> {
    private lazy var navigationContainer = MainNavigationItemContainer(navigationItem: navigationItem, viewModel: viewModel)
    private let bannerFlowLayout = UICollectionViewFlowLayout()
    private lazy var bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: bannerFlowLayout)
    private let pageControll = UIPageControl()

    override func bindToView(_ viewModel: MainViewModel) {
        super.bindToView(viewModel)
    }

    override func bindToViewModel(_ viewModel: MainViewModel) {
        super.bindToViewModel(viewModel)
        viewModel.requestApiWithNavigationSettingButtonTap()
            .emit(onNext: { [weak self] _ in
                self?.tapSettingNavigationButton()
            })
            .disposed(by: disposeBag)
        viewModel.requestApiWithNavigationAlarmButtonTap()
            .emit(onNext: { [weak self] _ in
                self?.tapAlarmNavigationButton()
            })
            .disposed(by: disposeBag)
        viewModel.requestApiWithNavigationPhotoButtonTap()
            .emit(onNext: { [weak self] _ in
                self?.tapPhotoNavigationButton()
            })
            .disposed(by: disposeBag)

        viewModel.getBannerList()
            .bind(to: bannerCollectionView.rx.items) { [weak self] collectionView, row, data in
                guard let self = self else { return UICollectionViewCell() }
                return self.createBannerCell(collectionView: collectionView, row: row, data: data)
            }
            .disposed(by: disposeBag)

        viewModel.getPageControllNumberOfPages()
            .bind(to: pageControll.rx.numberOfPages)
            .disposed(by: disposeBag)

        bannerCollectionView.rx.didScroll
            .bind(onNext: { [weak self] in
                self?.didScroll()
            })
            .disposed(by: disposeBag)

        bannerCollectionView.rx.didEndDecelerating
            .bind(onNext: { [weak self] in
                self?.infiniteScroll()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - View Support
    override func attribute() {
        super.attribute()

        bannerFlowLayout.scrollDirection = .horizontal
        bannerFlowLayout.minimumLineSpacing = 0
        bannerFlowLayout.minimumInteritemSpacing = 0
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 416
        bannerFlowLayout.itemSize = .init(width: width, height: height)

        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.contentInsetAdjustmentBehavior = .never
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.backgroundColor = .black
        bannerCollectionView.register(
            MainBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: MainBannerCollectionViewCell.self)
        )
        pageControll.pageIndicatorTintColor = .white
        pageControll.currentPageIndicatorTintColor = .systemBlue
    }
    override func layout() {
        super.layout()
        [
            bannerCollectionView,
            pageControll
        ].forEach {
            view.addSubview($0)
        }
        bannerCollectionView.snp.makeConstraints {
            $0.height.equalTo(416)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        pageControll.snp.makeConstraints {
            $0.top.equalTo(bannerCollectionView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Life Cycle
extension MainViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bannerCollectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
    }
}
// MARK: - Logic
extension MainViewController {
    func tapSettingNavigationButton() {
        print("🧊 tapSettingNavigationButton")
    }

    func tapAlarmNavigationButton() {
        print("🧊 tapAlarmNavigationButton")
    }

    func tapPhotoNavigationButton() {
        print("🧊 tapPhotoNavigationButton")
    }

    func createBannerCell(
        collectionView: UICollectionView,
        row: Int,
        data: MainBannerItemAttribute) -> UICollectionViewCell {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MainBannerCollectionViewCell.self),
            for: indexPath) as? MainBannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUI(data)
        cell.bind(viewModel)
        return cell
    }

    func didScroll() {
        if bannerCollectionView.frame.size.width != 0 {
            let value = (bannerCollectionView.contentOffset.x / bannerCollectionView.frame.width)
            pageControll.currentPage = Int(round(value)) - 1
        }
    }

    func infiniteScroll() {
        let value = (bannerCollectionView.contentOffset.x / bannerCollectionView.frame.width)
        let last = viewModel.getPrimitiveBannerList().count - 2
        switch Int(round(value)) {
        case 0:
            bannerCollectionView.scrollToItem(at: [0, last], at: .left, animated: false)
        case viewModel.getPrimitiveBannerList().count - 1:
            bannerCollectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
        default: break
        }
    }
}

//collectionView
//tableview
//
