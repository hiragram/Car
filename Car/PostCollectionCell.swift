//
//  PostCollectionCell.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/24.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Models

class PostCollectionViewCell: UICollectionViewCell, EntityDisplayable {

  typealias Entity = PostEntity

  @IBOutlet weak var imageView: UIImageView! {
    didSet {
      imageView.layer.cornerRadius = imageView.bounds.width / 20
      imageView.layer.masksToBounds = true
    }
  }

  func setup(entity: PostEntity) {
    if let url = entity.media.first?.url {
      imageView.setImageWithFade(url: url)
    }
  }

}
