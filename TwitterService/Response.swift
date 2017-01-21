//
//  Response.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Models

public protocol ResponseDefinition {
  associatedtype Element
  associatedtype Data
  associatedtype ProcessableJSONStructure
  var content: Data { get }
  init(jsonDict: ProcessableJSONStructure) throws
}

struct SingleResponse<T: JSONMappable>: ResponseDefinition {
  typealias Element = T
  typealias Data = T
  typealias ProcessableJSONStructure = [String: Any]

  var content: Data

  init(jsonDict: ProcessableJSONStructure) throws {
    content = try T.init(jsonDict: jsonDict)
  }
}

struct ArrayResponse<T: JSONMappable>: ResponseDefinition {
  typealias Element = T
  typealias Data = [T]
  typealias ProcessableJSONStructure = [[String: Any]]

  var content: Data

  init(jsonDict: ProcessableJSONStructure) throws {
    content = try jsonDict.map({ (singleElementDict) -> T in
      return try T.init(jsonDict: singleElementDict)
    })
  }
}
