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
      case .textField(title: let title, observable: let observable, observer: let observer):
        let cell: TextFieldCell = tableView.dequeueCell(for: indexPath)
        cell.title = title
        observable?.bindTo(cell.textValue).addDisposableTo(cell.bag)
        if let observer = observer {
          cell.textValue.bindTo(observer).addDisposableTo(cell.bag)
        }
        return cell
      default:
        fatalError("未実装")
      }
    }

    sections  = [
      Section.init(items: [.textField(title: "検索文字列", observable: Search.text.asObservable(), observer: Search.text.asObserver())])
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
    case textField(title: String, observable: Observable<String?>?, observer: AnyObserver<String?>?)
    case boolean(title: String, observable: Observable<Bool>?, observer: AnyObserver<Bool>?)

    var title: String {
      switch self {
      case .textField(title: let title, observable: _, observer: _):
        return title
      case .boolean(title: let title, observable: _, observer: _):
        return title
      }
    }
  }
}
