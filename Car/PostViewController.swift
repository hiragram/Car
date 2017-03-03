//
//  PostViewController.swift
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

class PostViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(cellClass: PostImageCell.self)
      tableView.estimatedRowHeight = 100
    }
  }

  let vm = Variable<PostViewModel?>.init(nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    vm.asObservable().filterNil().subscribe(onNext: { [unowned self] (vm) in
      vm.rows.bindTo(self.tableView.rx.items(dataSource: vm.dataSource)).addDisposableTo(self.bag)
    }).addDisposableTo(bag)
  }
}
