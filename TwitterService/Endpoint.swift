//
//  Endpoint.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

protocol Endpoint {
  associatedtype Response: ResponseDefinition

  static var path: String { get }
  static var method: Method { get }

  var params: [String: String] { get }
}

enum Method: CustomStringConvertible {
  case get
  case post

  var string: String {
    switch self {
    case .get:
      return "GET"
    case .post:
      return "POST"
    }
  }

  public var description: String {
    return string
  }
}
