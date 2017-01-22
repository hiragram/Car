//
//  UIImageView.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import WebImage

extension UIImageView {
  func setImageWithFade(url: URL!) {
    sd_setImage(with: url, placeholderImage: nil, options: .avoidAutoSetImage) { [weak self] (image, error, cacheType, url) in
      guard let image = image else {
        print(error)
        return
      }
      switch cacheType {
      case .none:
        self?.alpha = 0
        self?.image = image
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
          self?.alpha = 1
        }, completion: nil)
      default:
        self?.image = image
      }
    }
  }
}
