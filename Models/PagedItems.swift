//
//  PagedItems.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public struct PagedItems<Element: Identified> {

  private let bag = DisposeBag.init()

  public typealias PageNumber = Int
  public typealias ID = Int

  private let itemsForEachPage = Variable<[PageNumber: [ID: Element]]>.init([:])
  private let itemForID = Variable<[ID: Element]>.init([:])

  private let orderForEachPage = Variable<[PageNumber: [ID]]>.init([:])
  private let order = Variable<[ID]>.init([])

  public let items: Observable<[Element]>

  public init() {

    itemsForEachPage.asObservable().map { (pages: [PageNumber: [ID: Element]]) -> [ID: Element] in
      return pages.map { $1 }.reduce([ID: Element].init(), { (result, page) -> [ID: Element] in
        var result = result
        page.forEach({ (key: Int, value: Element) in
          result[key] = value
        })

        return result
      })
      }.bindTo(itemForID).addDisposableTo(bag)

    orderForEachPage.asObservable().map { (page) -> [ID] in
      return Array.init(page.keys).sorted().flatMap { page[$0] }.flatMap { $0 }
      }.bindTo(order).addDisposableTo(bag)


    items = Observable.zip(order.asObservable(), itemForID.asObservable(), resultSelector: { (order, itemForID) -> [Element] in
      order.flatMap { itemForID[$0] }
    })
  }

  public func set(items: [Element], forPage page: PageNumber) {
    var dict: [ID: Element] = [:]
    items.forEach {
      dict[$0.id] = $0
    }

    itemsForEachPage.value[page] = dict
    orderForEachPage.value[page] = items.map { $0.id }
  }

  public func refresh() {
    itemsForEachPage.value = [:]
    orderForEachPage.value = [:]
  }

  public func get(entityHasID id: ID) -> Element? {
    return itemForID.value[id]
  }

  public func get(entityForIndexPath indexPath: IndexPath) -> Element {
    let id = order.value[indexPath.row]
    return get(entityHasID: id)!
  }

  public func update(newElement element: Element) {
    guard itemForID.value[element.id] != nil else {
      print("id:\(element.id) is not contained in this container.")
      return
    }
    
    itemForID.value[element.id] = element
  }
}
