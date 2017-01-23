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
      photoImageView.layer.cornerRadius = 5
      photoImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var userIconImageView: UIImageView! {
    didSet {
      userIconImageView.layer.cornerRadius = userIconImageView.bounds.width / 10
      userIconImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var retweetedUserIconImageView: UIImageView! {
    didSet {
      retweetedUserIconImageView.layer.cornerRadius = retweetedUserIconImageView.bounds.width / 10
      retweetedUserIconImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var displayNameLabel: UILabel!
  @IBOutlet private weak var usernameLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var bodyLabel: UILabel!
  @IBOutlet private weak var followCountLabel: UILabel!
  @IBOutlet private weak var followerCountLabel: UILabel!

  @IBOutlet private weak var imageHeight: NSLayoutConstraint!
  @IBOutlet private weak var userIconImageViewHeight: NSLayoutConstraint!

  typealias Entity = PostEntity

  func setup(entity: PostEntity) {
    displayNameLabel.text = entity.user.displayName
    bodyLabel.text = entity.body
    userIconImageView.setImageWithFade(url: entity.user.imageURL)
    if let medium = entity.media.filter({ $0.type == .photo }).first {
      photoImageView.setImageWithFade(url: medium.url)
      imageHeight.constant = 250
    } else {
      imageHeight.constant = 0
    }

    if let retweetingUser = entity.retweetingUser {
      retweetedUserIconImageView.setImageWithFade(url: retweetingUser.imageURL)
      retweetedUserIconImageView.isHidden = false
      userIconImageViewHeight.constant = 50
      usernameLabel.text = "@\(entity.user.username) (@\(retweetingUser.username)がリツイート)"
    } else {
      retweetedUserIconImageView.isHidden = true
      userIconImageViewHeight.constant = 60
      usernameLabel.text = "@\(entity.user.username)"
    }

    followCountLabel.text = "\(entity.user.followCount)"
    followerCountLabel.text = "\(entity.user.followerCount)"

    dateLabel.text = entity.date.displayText

    layoutIfNeeded()
  }
}
