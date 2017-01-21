//
//  ObservablePaging.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift

public enum ObservablePaging<T> {
  case single(Observable<T>)
  case multiple(ObservableForPageBlock)

  public typealias ObservableForPageBlock = (Int) -> Observable<T>

  public func observableFor(page: Int) -> Observable<T> {
    switch self {
    case .single(let observable):
      if page == 1 {
        return observable
      } else {
        return Observable<T>.empty()
      }
    case .multiple(let observableForPage):
      return observableForPage(page)
    }
  }
}
