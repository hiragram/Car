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
import Models

class SettingsViewModel {
  let dataSource = RxTableViewSectionedReloadDataSource<Section>.init()

  let sections: [Section]

  init() {
    dataSource.configureCell = { (dataSource, tableView, indexPath, row) -> UITableViewCell in
      switch row {
      case .textField(title: let title, variable: let variable):
        let cell: TextFieldCell = tableView.dequeueCell(for: indexPath)
        cell.title = title
        variable.asObservable().bindTo(cell.textValue).addDisposableTo(cell.bag)
        cell.textValue.bindTo(variable).addDisposableTo(cell.bag)
        return cell
      default:
        fatalError("未実装")
      }
    }

    sections  = [
      Section.init(items: [.textField(title: "検索文字列", variable: Search.text)])
    ]
  }
}

extension SettingsViewModel {
  struct Section: SectionModelType {
    typealias Item = Row

    var items: [Item]

    init(items: [Item]) {
      self.items = items
    }

    init(original: Section, items: [Item]) {
      self.items = items
    }
  }

  enum Row {
    case textField(title: String, variable: Variable<String?>)
    case boolean(title: String, variable: Variable<Bool>)

    var title: String {
      switch self {
      case .textField(title: let title, variable: _):
        return title
      case .boolean(title: let title, variable: _):
        return title
      }
    }
  }
}
