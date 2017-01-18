//
//  PostEntity.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

public struct PostEntity: Identified {
  public let id: Int
  public let user: UserEntity
  public let date: Date
  public let body: String
  public let imageURLStr: String

  // TODO 開発用だから将来消す
  public init(id: Int) {
    self.id = id
    user = UserEntity.init(id: id)
    date = Date.init()
    body = "hogehoge"
    imageURLStr = "https://scontent.cdninstagram.com/t51.2885-15/e35/15876800_224067824668434_4568181517297123328_n.jpg?ig_cache_key=MTQzMDYyMzY2NTYxMjE3MTg0Mg%3D%3D.2"
  }
}
