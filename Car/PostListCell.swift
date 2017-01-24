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

  @IBOutlet private weak var photoA: UIImageView! {
    didSet {
      photoA.layer.cornerRadius = 5
      photoA.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var photoB: UIImageView! {
    didSet {
      photoB.layer.cornerRadius = 5
      photoB.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var photoC: UIImageView! {
    didSet {
      photoC.layer.cornerRadius = 5
      photoC.layer.masksToBounds = true
    }
  }
  @IBOutlet private weak var photoD: UIImageView! {
    didSet {
      photoD.layer.cornerRadius = 5
      photoD.layer.masksToBounds = true
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

  @IBOutlet private weak var userIconImageViewHeight: NSLayoutConstraint!

  @IBOutlet weak var photoAWidth: NSLayoutConstraint!
  @IBOutlet weak var photoAHeight: NSLayoutConstraint!
  @IBOutlet weak var photoBWidth: NSLayoutConstraint!
  @IBOutlet weak var photoBHeight: NSLayoutConstraint!
  @IBOutlet weak var photoCWidth: NSLayoutConstraint!
  @IBOutlet weak var photoCHeight: NSLayoutConstraint!
  @IBOutlet weak var photoDWidth: NSLayoutConstraint!
  @IBOutlet weak var photoDHeight: NSLayoutConstraint!

  typealias Entity = PostEntity

  func setup(entity: PostEntity) {
    displayNameLabel.text = entity.user.displayName
    bodyLabel.text = entity.body
    userIconImageView.setImageWithFade(url: entity.user.imageURL)

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

    set(media: entity.media)

    layoutIfNeeded()
  }

  private func set(media: [MediumEntity]) {
    let fullWidth: CGFloat = (UIScreen.main.bounds.width - (13 * 2))
    let halfWidth = fullWidth / 2

    let halfHeight: CGFloat = 123
    let fullHeight = halfHeight * 2

    switch media.count {
    case 0:
      photoAWidth.constant = fullWidth
      photoAHeight.constant = 0

      photoBWidth.constant = 0
      photoBHeight.constant = 0

      photoCWidth.constant = fullWidth
      photoCHeight.constant = 0

      photoDWidth.constant = 0
      photoDHeight.constant = 0
    case 1: // Use photoA
      photoAWidth.constant = fullWidth
      photoAHeight.constant = fullHeight

      photoBWidth.constant = 0
      photoBHeight.constant = 0

      photoCWidth.constant = fullWidth
      photoCHeight.constant = 0

      photoDWidth.constant = 0
      photoDHeight.constant = 0

      photoA.setImageWithFade(url: media[0].url)
    case 2: // Use photoA, B
      photoAWidth.constant = halfWidth
      photoAHeight.constant = fullHeight

      photoBWidth.constant = halfWidth
      photoBHeight.constant = fullHeight

      photoCWidth.constant = halfWidth
      photoCHeight.constant = 0

      photoDWidth.constant = halfWidth
      photoDHeight.constant = 0

      photoA.setImageWithFade(url: media[0].url)
      photoB.setImageWithFade(url: media[1].url)
    case 3: // Use photoA, B, D
      photoAWidth.constant = halfWidth
      photoAHeight.constant = fullHeight

      photoBWidth.constant = halfWidth
      photoBHeight.constant = halfHeight

      photoCWidth.constant = halfWidth
      photoCHeight.constant = 0

      photoDWidth.constant = halfWidth
      photoDHeight.constant = halfHeight

      photoA.setImageWithFade(url: media[0].url)
      photoB.setImageWithFade(url: media[1].url)
      photoD.setImageWithFade(url: media[2].url)
    default: // Use photoA, B, C, D
      photoAWidth.constant = halfWidth
      photoAHeight.constant = halfHeight

      photoBWidth.constant = halfWidth
      photoBHeight.constant = halfHeight

      photoCWidth.constant = halfWidth
      photoCHeight.constant = halfHeight

      photoDWidth.constant = halfWidth
      photoDHeight.constant = halfHeight

      photoA.setImageWithFade(url: media[0].url)
      photoB.setImageWithFade(url: media[1].url)
      photoC.setImageWithFade(url: media[2].url)
      photoD.setImageWithFade(url: media[3].url)
    }
    setNeedsLayout()
  }
}
