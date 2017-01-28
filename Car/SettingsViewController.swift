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
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet {

    }
  }

  private let vm = SettingsViewModel.init()
}
