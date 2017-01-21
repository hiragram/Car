//
//  TabViewController.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TabViewController: UITabBarController, StoryboardInstantitable {
  override func viewDidLoad() {
    super.viewDidLoad()

    let home = UINavigationController.init(rootViewControllerType: PostListViewController.self, configuration: { (vc) in
      vc.title = "ホーム"
      vc.vm.value = PostListViewModel.init(postsObservable: debugObservable())
    })

    let grid = { _ -> UIViewController in
      let vc = UIViewController.init()
      vc.title = "アルバム"
      vc.view.backgroundColor = UIColor.cyan
      return vc
    }()

    let viewControllers = [
      home,
      grid,
    ]

    setViewControllers(viewControllers, animated: true)
  }
}

private func debugObservable() -> Observable<[PostListViewModel.Item]> {
  let items = [1,2,3,4,5].map {
    PostListViewModel.Item.init(id: $0)
  }

  return Observable.just(items)
}
