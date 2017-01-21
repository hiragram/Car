//
//  JSONMappable.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

public protocol JSONMappable {
  init(jsonDict: [String: Any]) throws
}

enum JSONMappingError: Error {
  case invalidField(fieldName: AnyHashable, actualValue: Any)
}

public extension Dictionary {
  func value<T>(forKey key: Key) throws -> T {
    guard let value = self[key] as? T else {
      throw JSONMappingError.invalidField(fieldName: key, actualValue: self[key])
    }
    return value
  }
}
