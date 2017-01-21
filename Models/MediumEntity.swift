//
//  MediumEntity.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

public struct MediumEntity: Identified, JSONMappable {
  public let id: Int
  public let displayURL: String
  public let url: URL
  public let type: MediumType

  public enum MediumType {
    case photo
    case unsupported(typeName: String)

    init(rawValue: String) {
      switch rawValue {
      case "photo":
        self = .photo
      default:
        self = .unsupported(typeName: rawValue)
      }
    }
  }

  public init(jsonDict: [String : Any]) throws {
    self.id = try jsonDict.value(forKey: "id")
    self.displayURL = try jsonDict.value(forKey: "display_url")
    self.url = URL.init(string: try jsonDict.value(forKey: "media_url_https"))!
    self.type = MediumType.init(rawValue: try jsonDict.value(forKey: "type"))
  }
}
