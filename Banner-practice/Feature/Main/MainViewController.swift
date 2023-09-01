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
    private let navigationSettingButton = UIIconImageView()
    private let navigationAlarmButton = UIIconImageView()
    private let navigationPhotoButton = UIIconImageView()

    private let bannerFlowLayout = UICollectionViewFlowLayout()
    private lazy var bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: bannerFlowLayout)
    private let pageControll = UIPageControl()

    // MARK: - Logic
    override func bindToView() {
        super.bindToView()
        navigationSettingButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                print("🧊 SettingButton Tap")
            })
            .disposed(by: disposeBag)

        navigationAlarmButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                print("🧊 Alarm Button Tap")
            })
            .disposed(by: disposeBag)
        navigationPhotoButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                print("🧊 Photo Button Tap")
            })
            .disposed(by: disposeBag)
    }

    override func bindToViewModel(_ viewModel: MainViewModel) {
        super.bindToViewModel(viewModel)
        viewModel.bannerList
            .filter { !$0.isEmpty }
            .bind(onNext: { [weak self] in
                self?.pageControll.numberOfPages = $0.count - 2
                self?.bannerCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - View Support
    override func attribute() {
        super.attribute()
        navigationSettingButton.setImage(systemName: "bolt.fill")
        navigationAlarmButton.setImage(systemName: "bolt.fill")
        navigationPhotoButton.setImage(systemName: "bolt.fill")

        let navigationSpacing = makeNavigationItemSpacing(offset: 16)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: navigationSettingButton),
            navigationSpacing,
            UIBarButtonItem(customView: navigationAlarmButton),
            navigationSpacing,
            UIBarButtonItem(customView: navigationPhotoButton)
        ]

        bannerFlowLayout.scrollDirection = .horizontal
        bannerFlowLayout.minimumLineSpacing = 0
        bannerFlowLayout.minimumInteritemSpacing = 0
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 416
        bannerFlowLayout.itemSize = .init(width: width, height: height)

        bannerCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        bannerCollectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
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
        navigationSettingButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        navigationAlarmButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        navigationPhotoButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bannerCollectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
    }
}

//MARK: - DataSource, Delegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: MainBannerCollectionViewCell.self),
                for: indexPath) as? MainBannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setUI(viewModel.getBannerData(indexPath: indexPath))
            cell.bind(viewModel)
            return cell
        }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControll.currentPage = Int(round(value)) - 1
            print("🧊 row: \(Int(round(value)))")
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let value = (scrollView.contentOffset.x / scrollView.frame.width)
        let last = viewModel.bannerList.value.count - 2
        switch Int(round(value)) {
        case 0:
            bannerCollectionView.scrollToItem(at: [0, last], at: .left, animated: false)
        case viewModel.bannerList.value.count - 1:
            bannerCollectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
        default: break
        }
    }
}
