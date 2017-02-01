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

class PostViewController: UIViewController, StoryboardInstantiatable {
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet {

    }
  }
}
