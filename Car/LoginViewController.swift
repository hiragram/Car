//
//  LoginViewController.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TwitterKit
import Models

final class LoginViewController: UIViewController, StoryboardInstantiatable {
  @IBOutlet private weak var loginButton: TWTRLogInButton! {
    didSet {
      loginButton.logInCompletion = { [weak self] session, error in
        guard let session = session else {
          print(error)
          return
        }
        Auth.state.value = .authorized(token: session.authToken, tokenSecret: session.authTokenSecret, userID: session.userID)
        self?.dismiss(animated: true, completion: nil)
      }
    }
  }
  
}
