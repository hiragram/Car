//
//  PostListViewModel.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import Models

class PostListViewModel {
  typealias Item = PostEntity

  private let posts: Observable<[Item]>
  let itemContainer = PagedItems<Item>.init()

  var fetch: AnyObserver<Void>!

  private let bag = DisposeBag.init()

  init(postsObservable: Observable<[Item]>) {
    posts = postsObservable

    fetch = AnyObserver<Void>.init(eventHandler: { [weak self] (event) in
      switch event {
      case .next:
        self?.posts.subscribe({ (event) in
          switch event {
          case .next(let items):
            self?.itemContainer.set(items: items, forPage: 1)
          case .error(let error):
            fatalError(error.localizedDescription)
          case .completed:
            break
          }
        }).addDisposableTo(self!.bag)
      case .error(let error):
        fatalError(error.localizedDescription)
      case .completed:
        break
      }
    })
  }
}
