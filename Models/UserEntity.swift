//
//  UserEntity.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

public struct UserEntity: Identified {
  public let id: Int
  public let displayName: String
  public let username: String
  public let imageURLStr: String

  // TODO 開発用だから将来消す
  public init(id: Int) {
    self.id = id
    displayName = "かなこ"
    username = "@kanako3465"
    imageURLStr = "https://scontent.cdninstagram.com/t51.2885-15/e35/16124012_639016082970592_4415292462654816256_n.jpg?ig_cache_key=MTQzMDYyNjUwNzAzNTEzNzI2MQ%3D%3D.2"
  }
}
