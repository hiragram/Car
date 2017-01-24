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
  public let retweetingUser: UserEntity?

  public var postURL: URL {
    return URL.init(string: "https://twitter.com/\(user.username)/status/\(id)")!
  }

  // TODO 開発用だから将来消す
  public init(id: Int) {
    self.id = id
    user = UserEntity.init(id: id)
    date = Date.init()
    body = "hogehoge"
    media = []
    retweetingUser = nil
  }

  public init(jsonDict: [String : Any]) throws {

    if let originalPostDict = try? jsonDict.value(forKey: "retweeted_status") as [String: Any] {
      let originalPost = try PostEntity.init(jsonDict: originalPostDict)
      self.user = originalPost.user
      self.retweetingUser = try UserEntity.init(jsonDict: try jsonDict.value(forKey: "user"))
      self.body = originalPost.body
    } else {
      self.user = try UserEntity.init(jsonDict: try jsonDict.value(forKey: "user"))
      self.retweetingUser = nil
      self.body = try jsonDict.value(forKey: "text")
    }
    self.id = try jsonDict.value(forKey: "id")
    self.date = Date.init(twitterDateString: try jsonDict.value(forKey: "created_at"))!

    let extendedEntitiesDict: [String: Any] = (try? jsonDict.value(forKey: "extended_entities")) ?? [:]
    let mediaDict: [[String: Any]] = (try? extendedEntitiesDict.value(forKey: "media")) ?? []

    self.media = try mediaDict.map { (mediumDict) -> MediumEntity in
      return try MediumEntity.init(jsonDict: mediumDict)
    }
  }
}
