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
  let dataSource = RxTableViewSectionedReloadDataSource<Section>.init()

  let sections: [Section] = [
    Section.init(items: ["検索文字列"])
  ]

  init() {
    dataSource.configureCell = { (dataSource, tableView, indexPath, row) -> UITableViewCell in
      let cell: TextFieldCell = tableView.dequeueCell(for: indexPath)
      cell.title = row
      return cell
    }
  }
}

extension SettingsViewModel {
  struct Section: SectionModelType {
    typealias Item = String

    var items: [Item]

    init(items: [Item]) {
      self.items = items
    }

    init(original: Section, items: [Item]) {
      self.items = items
    }
  }
}
