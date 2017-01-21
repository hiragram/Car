//
//  StoryboardInstantiatable.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/16.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiatable {}

public extension StoryboardInstantiatable where Self: UIViewController {
  static var storyboardName: String {
    return String.init(describing: Self.self)
  }

  static var storyboard: UIStoryboard {
    return UIStoryboard.init(name: storyboardName, bundle: nil)
  }

  static func instantiateFromStoryboard(configuration: ((Self) -> Void)? = nil) -> Self {
    let vc = storyboard.instantiateInitialViewController() as! Self
    configuration?(vc)
    return vc
  }
}
