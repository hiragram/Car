//
//  UINavigationController.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit

extension UINavigationController {
  convenience init<T: StoryboardInstantiatable>(rootViewControllerType: T.Type, configuration: ((T) -> Void)? = nil) where T: UIViewController {
    let rootVC = T.instantiateFromStoryboard(configuration: configuration)
    self.init(rootViewController: rootVC)
  }
}
