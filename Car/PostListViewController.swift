//
//  PostListViewController.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Models

final class PostListViewController: UIViewController, StoryboardInstantitable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(nibWithType: PostListCell.self)
      tableView.estimatedRowHeight = 360

      vm.itemContainer.items.bindTo(tableView.rx.items(cellType: PostListCell.self)) { row, item, cell in
        cell.setup(entity: item)
      }.addDisposableTo(bag)
    }
  }

  // vm must be initialized before viewDidLoad
  private let vm = PostListViewModel.init(postsObservable: debugObservable())

  override func viewDidLoad() {
    super.viewDidLoad()
    Observable<Void>.just(()).bindTo(vm.fetch).addDisposableTo(bag)
  }
}

private func debugObservable() -> Observable<[PostListViewModel.Item]> {
  let items = [1,2,3,4,5].map {
    PostListViewModel.Item.init(id: $0)
  }

  return Observable.just(items)
}

