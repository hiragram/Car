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

  public enum MediumType: Equatable {
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

    private var id: Int {
      switch self {
      case .photo:
        return 1
      case .unsupported:
        return 0
      }
    }

    public static func ==(lhs: MediumType, rhs: MediumType) -> Bool {
      switch (lhs, rhs) {
      case (.unsupported(typeName: let left), .unsupported(typeName: let right)):
        return left == right
      default:
        return lhs.id == rhs.id
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
