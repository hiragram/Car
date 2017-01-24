//
//  UICollectionView.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/24.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UICollectionView {
  // TODO NibInstantiatableにするほうが安全そう
  func register(nibWithType: UICollectionViewCell.Type) {
    let name = String.init(describing: nibWithType.self)
    register(UINib.init(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
  }
}

extension Reactive where Base: UICollectionView {
  public func items<S: Sequence, Cell: UICollectionViewCell, O: ObservableType>(cellType: Cell.Type = Cell.self)
    -> (_ source: O)
    -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
    -> Disposable
    where O.E == S {
      return items(cellIdentifier: String.init(describing: Cell.self), cellType: Cell.self)
  }
}
