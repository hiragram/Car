//
//  PostEntity.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

public struct PostEntity: Identified, JSONMappable {
  public let id: Int
  public let user: UserEntity
  public let date: Date
  public let body: String
  public let media: [MediumEntity]

  // TODO 開発用だから将来消す
  public init(id: Int) {
    self.id = id
    user = UserEntity.init(id: id)
    date = Date.init()
    body = "hogehoge"
    media = []
  }

  public init(jsonDict: [String : Any]) throws {
    self.id = try jsonDict.value(forKey: "id")
    self.user = try UserEntity.init(jsonDict: try jsonDict.value(forKey: "user"))
    self.date = Date.init() // TODO stringからdateの変換つくる
    self.body = try jsonDict.value(forKey: "text")

    let entityDict: [String: Any] = try jsonDict.value(forKey: "entities")
    let mediaDict: [[String: Any]] = (try? entityDict.value(forKey: "media")) ?? []

    self.media = try mediaDict.map { (mediumDict) -> MediumEntity in
      return try MediumEntity.init(jsonDict: mediumDict)
    }
  }
}
