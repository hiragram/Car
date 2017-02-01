//
//  SettingsViewController.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/28.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(nibWithType: TextFieldCell.self)
      Observable.just(vm.sections).bindTo(tableView.rx.items(dataSource: vm.dataSource)).addDisposableTo(bag)
    }
  }

  @IBOutlet private weak var doneButton: UIBarButtonItem! {
    didSet {
      doneButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
        self.dismiss(animated: true, completion: nil)
      }).addDisposableTo(bag)
    }
  }

  private let vm = SettingsViewModel.init()
}
