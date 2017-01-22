//
//  TwitterRepository.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Models
import TwitterKit

public struct TwitterRepository {

  private static let bag = DisposeBag.init()

  static func fetch<T: Endpoint>(_ endpoint: T) -> Observable<T.Response.Data> {
    return Observable<T.Response.Data>.create({ (observer) -> Disposable in
      Auth.client.take(1).subscribe(onNext: { (client) in
        let endpointURL = RestAPI.baseURL + T.path
        let request = client.urlRequest(withMethod: T.method.string, url: endpointURL, parameters: endpoint.params, error: nil)

        client.sendTwitterRequest(request) { (response, data, error) in
          guard let response = response else {
            observer.onError(error!)
            return
          }
          guard let data = data else {
            observer.onError(error!)
            return
          }
          do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? T.JSONStructure {
              let data = try T.mapping(jsonDict: json)
              observer.onNext(data)
              observer.onCompleted()
            } else {
              observer.onError(TwitterRepositoryError.castFailed)
            }
          } catch let error {
            observer.onError(error)
          }
        }
      }).addDisposableTo(bag)
      return Disposables.create()
    })
  }
}

// Observable interface

public extension TwitterRepository {
  public static func search(query: String, count: Int = 15) -> ObservablePaging<[PostEntity]> {
    return ObservablePaging.single(fetch(RestAPI.Search.init(query: query, count: count)))
  }
}

public enum TwitterRepositoryError: Error {
  case castFailed
}
