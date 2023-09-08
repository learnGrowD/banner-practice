//
//  AnimateTableView.swift
//  Banner-practice
//
//  Created by 도학태 on 2023/09/08.
//

import UIKit
import RxSwift
import RxCocoa

final class AnimateTableView: UITableView {
    private let disposeBag = DisposeBag()
    private let viewModel: AnimationViewModel

    init(frame: CGRect = .zero, style: UITableView.Style = .plain, viewModel: AnimationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, style: style)
        attribute()
        bindToView(viewModel)
        bind(viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindToView(_ viewModel: AnimationViewModel) {
        rx.didScroll
            .map { [weak self] in
                guard let self = self else { return  0.0 }
                return self.contentOffset.y
            }
            .bind(to: viewModel.tableViewOffsetY)
            .disposed(by: disposeBag)
    }

    private func bind(_ viewModel: AnimationViewModel) {
        viewModel.list
            .bind(to: rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: AnimateHeaderTableViewCell.tag,
                        for: indexPath) as! AnimateHeaderTableViewCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: AnimateItemTableViewCell.tag,
                        for: indexPath) as! AnimateItemTableViewCell
                    cell.setUI(data: data)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    private func attribute() {
        self.backgroundColor = .clear
        self.separatorStyle = .none
        self.register(AnimateHeaderTableViewCell.self,
                           forCellReuseIdentifier: AnimateHeaderTableViewCell.tag)
        self.register(AnimateItemTableViewCell.self,
                           forCellReuseIdentifier: AnimateItemTableViewCell.tag)
    }
}
