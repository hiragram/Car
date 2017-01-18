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

  @IBOutlet private weak var photoImageView: UIImageView!
  @IBOutlet private weak var userIconImageView: UIImageView!
  @IBOutlet private weak var displayNameLabel: UILabel!
  @IBOutlet private weak var usernameLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var bodyLabel: UILabel!

  typealias Entity = PostEntity

  func setup(entity: PostEntity) {
    // TODO ダミーデータあててるから綺麗にする
    displayNameLabel.text = entity.user.displayName
    usernameLabel.text = entity.user.username
    bodyLabel.text = entity.body
  }
}
