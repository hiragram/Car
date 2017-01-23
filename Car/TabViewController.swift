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

    let commonViewModel = PostListViewModel.init(postsObservable: TwitterRepository.search(query: "#裏垢女子 filter:twimg", count: 100))

    commonViewModel.fetch.subscribe(onError: { (error) in
      print(error)
    }).addDisposableTo(self.bag)

    let table = UINavigationController.init(rootViewControllerType: PostListViewController.self, configuration: { (vc) in
      vc.title = "ホーム"
      vc.vm.value = commonViewModel
    })

    let grid = UINavigationController.init(rootViewControllerType: PostCollectionViewController.self) { (vc) in
      vc.title = "写真一覧"
      vc.vm.value = commonViewModel
    }

    let viewControllers = [
      table,
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
