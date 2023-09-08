//
//  Rx+extension.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/06.
//

import UIKit
import RxSwift
import RxCocoa


extension Reactive where Base: UICollectionView {
    func reloadData<T: Collection>() -> Binder<T> {
        Binder(base) { collectionView, data in
            if !data.isEmpty {
                collectionView.reloadData()
            }
        }
    }
}
