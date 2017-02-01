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

    let table = PostListViewController.instantiateFromStoryboard()
    let tableNavigation = UINavigationController.init(rootViewController: table)

    let grid = PostCollectionViewController.instantiateFromStoryboard()
    let gridNavigation = UINavigationController.init(rootViewController: grid)

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
