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

  private var posts: ObservablePaging<[Item]>
  let itemContainer = PagedItems<Item>.init()

  let bag = DisposeBag.init()

  private let _isLoading = Variable.init(false)

  var isLoading: Observable<Bool>

  var fetch: Observable<Void> {
    return Observable<Void>.create { [unowned self] (observer) -> Disposable in
      self._isLoading.value = true
      observer.onNext(())
      observer.onCompleted()
      return Disposables.create()
      }.flatMap { [unowned self] in
        self.posts.observableFor(page: 1)
      }.do(onNext: { [weak self] (items) in
        self?.itemContainer.set(items: items, forPage: 1)
        }, onError: { [unowned self] (error) in
          self._isLoading.value = false
        }, onCompleted: { [unowned self] in
          self._isLoading.value = false
      })
      .map { _ in () }
  }

  init(postsObservable: ObservablePaging<[Item]>) {
    posts = postsObservable

    isLoading = _isLoading.asObservable()
  }
}
