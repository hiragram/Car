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
import Models
import TwitterService

final class TabViewController: UITabBarController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  override func viewDidLoad() {
    super.viewDidLoad()

    let home = UINavigationController.init(rootViewControllerType: PostListViewController.self, configuration: { (vc) in
      vc.title = "ホーム"
      vc.vm.value = PostListViewModel.init(postsObservable: TwitterRepository.search(query: "#プリクラ filter:media", count: 100))
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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Auth.stateObservable.subscribe(onNext: { [unowned self] (state) in
      switch state {
      case .notAuthorized:
        self.presentNavigation(viewControllerTypeToPresent: LoginViewController.self)
      case .authorized:
        break
      }
      }).addDisposableTo(bag)
  }
}

private func debugObservable() -> ObservablePaging<[PostListViewModel.Item]> {

  let items = [1,2,3,4,5].map {
    PostListViewModel.Item.init(id: $0)
  }

  return ObservablePaging.single(Observable.just(items))
}
