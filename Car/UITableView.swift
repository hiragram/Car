//
//  UITableView.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITableView {
  // TODO NibInstantiatableにするほうが安全そう
  func register(nibWithType: UITableViewCell.Type) {
    let name = String.init(describing: nibWithType.self)
    register(UINib.init(nibName: name, bundle: nil), forCellReuseIdentifier: name)
  }

  func register(cellClass: UITableViewCell.Type) {
    register(cellClass.self, forCellReuseIdentifier: String.init(describing: cellClass.self))
  }

  func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: String.init(describing: T.self), for: indexPath) as! T
  }
}

extension Reactive where Base: UITableView {
  public func items<S: Sequence, Cell: UITableViewCell, O: ObservableType>(cellType: Cell.Type = Cell.self)
    -> (_ source: O)
    -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
    -> Disposable
    where O.E == S {
      return items(cellIdentifier: String.init(describing: Cell.self), cellType: Cell.self)
  }
}
