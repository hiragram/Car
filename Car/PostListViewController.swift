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
    }
  }

  var vm = Variable<PostListViewModel?>.init(nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    vm.asObservable().filterNil().subscribe(onNext: { (vm) in
      Observable<Void>.just(()).bindTo(vm.fetch).addDisposableTo(vm.bag)
    }).addDisposableTo(bag)
  }
}
