//
//  TabViewController.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit

final class TabViewController: UITabBarController, StoryboardInstantitable {
  override func viewDidLoad() {
    super.viewDidLoad()
    let viewControllers = [
      UINavigationController.init(rootViewControllerType: PostListViewController.self, configuration: { (vc) in
        vc.title = "ホーム"
      })
      ]
      +
      [
        UIColor.red,
        ].map { color -> UIViewController in
          let vc = UIViewController.init()
          vc.view.backgroundColor = color
          vc.title = "アルバム"
          return vc
    }

    setViewControllers(viewControllers, animated: true)
  }
}
