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

  private var tableViewController: PostListViewController!
  private var gridViewController: PostCollectionViewController!

  override func viewDidLoad() {
    super.viewDidLoad()

    UITabBar.appearance().tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

    let table = PostListViewController.instantiateFromStoryboard()
    let tableNavigation = UINavigationController.init(rootViewController: table)
    table.tabBarItem = UITabBarItem.init(title: "コメント付き", image: #imageLiteral(resourceName: "ListTabIconDisabled"), selectedImage: #imageLiteral(resourceName: "ListTabIconEnabled"))
    table.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)


    let grid = PostCollectionViewController.instantiateFromStoryboard()
    let gridNavigation = UINavigationController.init(rootViewController: grid)
    grid.tabBarItem = UITabBarItem.init(title: "グリッド", image: #imageLiteral(resourceName: "CollectionTabIconDisabled"), selectedImage: #imageLiteral(resourceName: "CollectionTabIconEnabled"))
    grid.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)

    tableViewController = table
    gridViewController = grid

    let viewControllers = [
      tableNavigation,
      gridNavigation,
      ]

    setViewControllers(viewControllers, animated: true)

    let viewModelSequence = Search.text.asObservable()
      .throttle(2.0, latest: true, scheduler: MainScheduler.instance)
      .map { (text) -> PostListViewModel in
        let paging: ObservablePaging<[PostEntity]>
        if let text = text {
          paging = TwitterRepository.search(query: "\(text) filter:twimg", count: 100)
        } else {
          paging = .single(Observable<[PostEntity]>.empty())
        }

        let vm = PostListViewModel.init(postsObservable: paging)
        vm.fetch.subscribe().addDisposableTo(vm.bag)
        return vm
    }.shareReplay(1)

    viewModelSequence.bindTo(tableViewController.vm).addDisposableTo(bag)
    viewModelSequence.bindTo(gridViewController.vm).addDisposableTo(bag)

    Search.text.asObservable().map {
      guard let text = $0 else {
        return ""
      }
      return "\"\(text)\""
      }.bindTo(tableViewController.rx.title).addDisposableTo(bag)
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
