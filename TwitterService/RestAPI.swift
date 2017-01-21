//
//  RestAPI.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Models

struct RestAPI {

  static let baseURL = "https://api.twitter.com/1.1"

  struct Search: Endpoint {
    typealias Response = ArrayResponse<PostEntity>
    typealias JSONStructure = [String: Any]
    static var path = "/search/tweets.json"
    static var method = Method.get

    let params: [String: String]

    init(query: String) {
      params = [
        "q": query,
      ]
    }

    static func mapping(jsonDict: JSONStructure) throws -> Response.Data {
      let response = try Response.init(jsonDict: try jsonDict.value(forKey: "statuses"))

      return response.content
    }
  }
}
