//
//  Deeplink.swift
//  Car
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit

struct Deeplink {

  enum OpenType {
    case safari(url: URL)
    case app(url: URL)
  }

  struct Twitter: LinkedApp {
    static var urlScheme = "twitter"

    static func tweet(fromUser screenName: String, forID id: Int) -> OpenType {
      return isInstalled() ? .app(url: urlForApp(path: "status?id=\(id)")) : .safari(url: URL.init(string: "https://twitter.com/\(screenName)/status/\(id)")!)
    }
  }

}

protocol LinkedApp {

  static var urlScheme: String { get }

  static func isInstalled() -> Bool

}

extension LinkedApp {
  static func isInstalled() -> Bool {
    return UIApplication.shared.canOpenURL(URL.init(string: "\(urlScheme)://")!)
  }

  static func urlForApp(path: String) -> URL {
    return URL.init(string: "\(urlScheme)://\(path)")!
  }
}
