//
//  MainRepository.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/01.
//

import Foundation
import RxSwift
import RxCocoa

class MainRepository {
    func getBannerList() -> Observable<[MainBannerItemAttribute]> {
        return Observable.just([
            MainBannerItemAttribute(
                backgroundColorHexString: "#FF5733",
                categoryText: "보관함",
                titleText: "요즘\n좋아한 곡",
                allCnt: 30,
                date: Date(),
                largeThumbnailImageURL: getImageURL(),
                middleThumbnailImageURL: getImageURL(),
                smallThumbnailImageURL: getImageURL(),
                nameText: "Dancin (krono Remix)",
                decorateImageURL: getDecorateImageURL()
            ),

            MainBannerItemAttribute(
                backgroundColorHexString: "#8A2BE2",
                categoryText: "보관함",
                titleText: "요즘\n좋아한 곡",
                allCnt: 30,
                date: Date(),
                largeThumbnailImageURL: getImageURL(),
                middleThumbnailImageURL: getImageURL(),
                smallThumbnailImageURL: getImageURL(),
                nameText: "Dancin (krono Remix)",
                decorateImageURL: getDecorateImageURL()
            ),

            MainBannerItemAttribute(
                backgroundColorHexString: "#00FF7F",
                categoryText: "보관함",
                titleText: "요즘\n좋아한 곡",
                allCnt: 30,
                date: Date(),
                largeThumbnailImageURL: getImageURL(),
                middleThumbnailImageURL: getImageURL(),
                smallThumbnailImageURL: getImageURL(),
                nameText: "Dancin (krono Remix)",
                decorateImageURL: getDecorateImageURL()
            )
        ])
        .map {
            var result = $0
            result.insert(result[result.count - 1], at: 0)
            result.append(result[1])
            return result
        }
    }

    func getImageURL() -> String {
        let urlList = [
            "https://media.newyorker.com/photos/64bc4330ef09d4a0e04cb249/3:4/w_1278,h_1704,c_limit/Rosen-Messi-Miami.jpg",
            "https://images.mlssoccer.com/image/private/t_q-best/prd-league/ipocdxrkbpszcnbd2hzg.jpg",
            "https://media.cnn.com/api/v1/images/stellar/prod/230726053047-01-lionel-messi-goals-inter-miami-spt-intl.jpg?c=original",
        ]
        guard let result = urlList.randomElement() else {
            return "https://media.newyorker.com/photos/64bc4330ef09d4a0e04cb249/3:4/w_1278,h_1704,c_limit/Rosen-Messi-Miami.jpg"
        }
        return result
    }

    func getDecorateImageURL() -> String {
        let urlList = [
            "https://img.freepik.com/premium-photo/purple-wallpaper-for-iphone-is-the-best-high-definition-iphone-wallpaper-in-you-can-make-this-wallpaper-for-your-iphone-x-backgrounds-mobile-screensaver-or-ipad-lock-screen-wallpaper-screen_899894-5038.jpg",

            "https://images.unsplash.com/photo-1475274047050-1d0c0975c63e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
            "https://img2.quasarzone.com/editor/2022/04/08/ecbd2b60ec7ea4b44cbdbfeee980b8c9.jpg"

        ]
        guard let result = urlList.randomElement() else {
            return "https://img.freepik.com/premium-photo/purple-wallpaper-for-iphone-is-the-best-high-definition-iphone-wallpaper-in-you-can-make-this-wallpaper-for-your-iphone-x-backgrounds-mobile-screensaver-or-ipad-lock-screen-wallpaper-screen_899894-5038.jpg"
        }
        return result
    }
}
