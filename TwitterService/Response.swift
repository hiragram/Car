//
//  Response.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/22.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

public protocol ResponseDefinition {
  associatedtype Element
}

struct SingleResponse<T>: ResponseDefinition {
  typealias Element = T
}

struct ArrayResponse<T>: ResponseDefinition {
  typealias Element = [T]
}
