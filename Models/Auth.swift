//
//  Auth.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Fabric
import TwitterKit

private let store = UserDefaults.standard
private let accessTokenKey = "Auth.accessToken"
private let accessTokenSecretKey = "Auth.accessTokenSecret"
private let userIDKey = "Auth.userID"

public struct Auth {
  public enum State {
    case notAuthorized
    case authorized(token: String, tokenSecret: String, userID: String)
  }

  public static var client: TWTRAPIClient?

  public static let state: Variable<State> = { _ -> Variable<State> in
    let state: State
    if let token = store.value(forKey: accessTokenKey) as? String, let tokenSecret = store.value(forKey: accessTokenSecretKey) as? String, let userID = store.value(forKey: userIDKey) as? String {
      state = .authorized(token: token, tokenSecret: tokenSecret, userID: userID)
      Twitter.sharedInstance().sessionStore.saveSession(withAuthToken: token, authTokenSecret: tokenSecret, completion: { (session, error) in
        guard let session = session else {
          fatalError(error?.localizedDescription ?? "")
        }
        client = TWTRAPIClient.init(userID: userID)
      })
    } else {
      state = .notAuthorized
    }

    return Variable<State>.init(state)
  }()

  public static var stateObservable: Observable<State> = state.asObservable().do(onNext: { (state) in
    switch state {
    case .notAuthorized:
      store.set(nil, forKey: accessTokenKey)
      store.set(nil, forKey: accessTokenSecretKey)
      store.set(nil, forKey: userIDKey)
    case .authorized(token: let token, tokenSecret: let tokenSecret, userID: let userID):
      store.set(token, forKey: accessTokenKey)
      store.set(tokenSecret, forKey: accessTokenSecretKey)
      store.set(userID, forKey: userIDKey)
      store.synchronize()
    }
  })
}
