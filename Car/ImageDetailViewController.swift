//
//  ImageDetailViewController.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/26.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageDetailViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var imageView: UIImageView! {
    didSet {
      imageURL.subscribe(onNext: { [unowned self] (url) in
        self.imageView.setImageWithFade(url: url)
      }).addDisposableTo(bag)
    }
  }

  var imageURL: Observable<URL>!
}
