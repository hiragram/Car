//
//  PostListCell.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import Models

final class PostListCell: UITableViewCell, EntityDisplayable {

  @IBOutlet private weak var photoImageView: UIImageView! {
    didSet {
      photoImageView.layer.cornerRadius = 10
      photoImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var userIconImageView: UIImageView! {
    didSet {
      userIconImageView.layer.cornerRadius = userIconImageView.bounds.width / 2
      userIconImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var displayNameLabel: UILabel!
  @IBOutlet private weak var usernameLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var bodyLabel: UILabel!

  @IBOutlet weak var imageHeight: NSLayoutConstraint!

  typealias Entity = PostEntity

  func setup(entity: PostEntity) {
    // TODO ダミーデータあててるから綺麗にする
    displayNameLabel.text = entity.user.displayName
    usernameLabel.text = entity.user.username
    bodyLabel.text = entity.body
    userIconImageView.setImageWithFade(url: entity.user.imageURL)
    if let medium = entity.media.filter({ $0.type == .photo }).first {
      photoImageView.setImageWithFade(url: medium.url)
      imageHeight.constant = 250
    } else {
      imageHeight.constant = 0
    }

    layoutIfNeeded()
  }
}
