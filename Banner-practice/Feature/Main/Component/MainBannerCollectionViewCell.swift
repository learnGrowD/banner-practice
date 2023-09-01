//
//  MainBannerCollectionViewCell.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/08/31.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import UIColor_Hex_Swift

final class MainBannerCollectionViewCell: UICollectionViewCell {
    private var disposeBag = DisposeBag()
    private let recommendLabel = UILabel()
    private let titleLabel = UILabel()
    private let playButton = UIImageView()

    private let descriptionLabel = UILabel()
    private let largeThubnailImageView = UIImageView()
    private let middleThumbnailImageView = UIImageView()
    private let smallThumbnailImageView = UIImageView()
    private let nameAndCountLabel = UILabel()

    private let decorateImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Logic: cell 생성 할때 호출
    func setUI(_ data: MainBannerItemAttribute) {
        contentView.backgroundColor = UIColor(data.backgroundColorHexString)
        recommendLabel.text = "\(data.categoryText) 추천"

        titleLabel.text = data.titleText

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        let dateString = dateFormatter.string(from: data.date)
        descriptionLabel.text = "총 \(data.allCnt)곡 \(dateString)"

        largeThubnailImageView.kf.setImage(with: URL(string: data.largeThumbnailImageURL))
        middleThumbnailImageView.kf.setImage(with: URL(string: data.middleThumbnailImageURL))
        smallThumbnailImageView.kf.setImage(with: URL(string: data.smallThumbnailImageURL))

        nameAndCountLabel.text = "\(data.nameText) 외 \(data.allCnt)곡"

        decorateImageView.kf.setImage(with: URL(string: data.decorateImageURL))
    }

    func bind(_ viewModel: MainViewModel) {

    }

    // MARK: - View Support
    private func attribute() {
        recommendLabel.font = UIFont.systemFont(ofSize: 16)
        recommendLabel.textColor = .white

        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2

        playButton.image = UIImage(systemName: "play.fill")

        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white

        largeThubnailImageView.layer.zPosition = 3
        largeThubnailImageView.clipsToBounds = true
        largeThubnailImageView.layer.cornerRadius = 8
        largeThubnailImageView.contentMode = .scaleAspectFill

        middleThumbnailImageView.layer.zPosition = 2
        middleThumbnailImageView.clipsToBounds = true
        middleThumbnailImageView.layer.cornerRadius = 8
        middleThumbnailImageView.contentMode = .scaleAspectFill

        smallThumbnailImageView.layer.zPosition = 1
        smallThumbnailImageView.clipsToBounds = true
        smallThumbnailImageView.layer.cornerRadius = 8
        smallThumbnailImageView.contentMode = .scaleAspectFill

        nameAndCountLabel.font = UIFont.systemFont(ofSize: 12)
        nameAndCountLabel.textColor = .white

        decorateImageView.layer.zPosition = 0
        decorateImageView.clipsToBounds = true
        decorateImageView.layer.cornerRadius = 8
        decorateImageView.contentMode = .scaleAspectFill
    }

    private func layout() {
        [
            recommendLabel,
            titleLabel,
            playButton,

            descriptionLabel,
            largeThubnailImageView,
            middleThumbnailImageView,
            smallThumbnailImageView,
            nameAndCountLabel,
            decorateImageView
        ].forEach {
            contentView.addSubview($0)
        }
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(recommendLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        playButton.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
        }
        largeThubnailImageView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        middleThumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(80)
            $0.centerY.equalTo(largeThubnailImageView)
            $0.leading.equalTo(largeThubnailImageView.snp.centerX)
        }
        smallThumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.centerY.equalTo(largeThubnailImageView)
            $0.leading.equalTo(middleThumbnailImageView.snp.centerX)
        }
        nameAndCountLabel.snp.makeConstraints {
            $0.top.equalTo(largeThubnailImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        decorateImageView.snp.makeConstraints {
            $0.size.equalTo(164)
            $0.bottom.equalToSuperview().inset(56)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    //MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
