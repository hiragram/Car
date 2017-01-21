//
//  UIViewController.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/16.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit

public extension UIViewController {
  public func present<T: StoryboardInstantiatable>(viewControllerTypeToPresent: T.Type, animated: Bool = true, completion: (() -> Void)? = nil, configuration: ((T) -> Void)?) where T: UIViewController {
    let vc = T.instantiateFromStoryboard(configuration: configuration)
    present(vc, animated: animated, completion: completion)
  }

  public func presentNavigation<T: StoryboardInstantiatable>(viewControllerTypeToPresent: T.Type, animated: Bool = true, completion: (() -> Void)? = nil, configuration: ((T) -> Void)? = nil) where T: UIViewController {
    let vc = UINavigationController.init(rootViewControllerType: T.self, configuration: configuration)
    present(vc, animated: animated, completion: completion)
  }

  public func show<T: StoryboardInstantiatable>(_ vcType: T.Type, sender: Any?, configuration: ((T) -> Void)?) where T: UIViewController {
    let vc = T.instantiateFromStoryboard(configuration: configuration)
    show(vc, sender: sender)
  }
}
