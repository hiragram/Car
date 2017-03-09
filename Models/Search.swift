//
//  Search.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/29.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

private let searchTextKey = "searchText"

public struct Search {
  private static let textObserver = AnyObserver<String?>.init { (event) in
    switch event {
    case .next(let text):
      UserDefaults.standard.set(text, forKey: searchTextKey)
      UserDefaults.standard.synchronize()
    default:
      break
    }
    textSubject.on(event)
  }

  private static var textSubject: ReplaySubject<String?> = { _ -> ReplaySubject<String?> in
    let sub = ReplaySubject<String?>.create(bufferSize: 1)
    let savedText = UserDefaults.standard.value(forKey: searchTextKey) as? String
    sub.onNext(savedText)
    return sub
  }()

  public static let text = ControlProperty<String?>.init(values: textSubject.asObservable().distinctUntilChanged(), valueSink: textObserver)
}
