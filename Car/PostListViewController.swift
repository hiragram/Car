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
import RxOptional
import Models
import SafariServices

final class PostListViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(nibWithType: PostListCell.self)
      tableView.estimatedRowHeight = 360

      vm.asObservable().filterNil().subscribe(onNext: { [unowned self] (vm) in
        vm.itemContainer.items.bindTo(self.tableView.rx.items(cellType: PostListCell.self)) { row, item, cell in
          cell.setup(entity: item)
          }.addDisposableTo(vm.bag)
      }).addDisposableTo(bag)

      tableView.rx.modelSelected(PostListViewModel.Item.self).subscribe(onNext: { [weak self] (item) in
        self?.present(SFSafariViewController.init(url: item.postURL), animated: true, completion: nil)
      }).addDisposableTo(bag)

      tableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] (indexPath) in
        self?.tableView.deselectRow(at: indexPath, animated: true)
      }).addDisposableTo(bag)
    }
  }

  @IBOutlet private weak var refreshControl: UIRefreshControl! {
    didSet {
      vm.asObservable().filterNil().subscribe(onNext: { [unowned self] (vm) in
        self.refreshControl.rx.controlEvent(.valueChanged).flatMap {
          vm.fetch
        }.subscribe().addDisposableTo(vm.bag)
        vm.isLoading.bindTo(self.refreshControl.rx.isRefreshing).addDisposableTo(vm.bag)
      }).addDisposableTo(bag)
    }
  }

  var vm = Variable<PostListViewModel?>.init(nil)

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
