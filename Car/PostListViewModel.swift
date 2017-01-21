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

  private let posts: ObservablePaging<[Item]>
  let itemContainer = PagedItems<Item>.init()

  let bag = DisposeBag.init()

  var fetch: Observable<Void> {
    return posts.observableFor(page: 1)
      .do(onNext: { [weak self] (items) in
        self?.itemContainer.set(items: items, forPage: 1)
      })
      .map { _ in () }
  }

  init(postsObservable: ObservablePaging<[Item]>) {
    posts = postsObservable
  }
}
