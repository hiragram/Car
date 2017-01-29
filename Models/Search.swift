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
  public static let text: Variable<String?> = { _ -> Variable<String?> in
    return Variable<String?>.init(UserDefaults.standard.value(forKey: searchTextKey) as? String)
  }()
}
