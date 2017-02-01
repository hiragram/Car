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
      vm.asObservable().filterNil().subscribe(onNext: { (vm) in

      }).addDisposableTo(bag)
    }
  }

  let vm = Variable<PostViewModel?>.init(nil)
}
