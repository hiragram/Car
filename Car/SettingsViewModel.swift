//
//  SettingsViewModel.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/29.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewModel {
  private let dataSource = RxTableViewSectionedReloadDataSource<Section>.init()
}

private struct Section: SectionModelType {
  typealias Item = String

  var items: [Item]

  init(original: Section, items: [Item]) {
    self.items = items
  }
}
