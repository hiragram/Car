//
//  PostViewModel.swift
//  Car
//
//  Created by yuya_hirayama on 2017/02/02.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Models
import TwitterService

class PostViewModel {
  typealias Item = PostEntity

  let dataSource = RxTableViewSectionedReloadDataSource<Section>.init()
  private let context: Context

  var rows = Observable<[Section]>.just([Section.init(items: [.images, .main, .control])])

  init(context: Context) {
    self.context = context

    dataSource.configureCell = { (dataSource, tableView, indexPath, row) -> UITableViewCell in
      switch dataSource[indexPath] {
      case .images:
        let cell: PostImageCell = tableView.dequeueCell(for: indexPath)
        return cell
      default:
        let cell = UITableViewCell.init()
        cell.contentView.backgroundColor = UIColor.cyan
        return cell
      }
    }
  }
}

extension PostViewModel {
  enum Context {
    case id(Int)
    case entity(PostEntity)

    private var id: Int {
      switch self {
      case .id(let id):
        return id
      case .entity(let post):
        return post.id
      }
    }

    var content: Observable<Item> {
      let apiObservable = TwitterRepository.getTweet(id: id)
      switch self {
      case .id:
        return apiObservable
      case .entity(let post):
        return Observable.of(Observable.just(post), apiObservable).merge()
      }
    }
  }
}

extension PostViewModel {
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
    case images
    case main
    case control
  }
}
