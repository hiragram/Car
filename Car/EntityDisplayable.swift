//
//  EntityDisplayable.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit

protocol EntityDisplayable {
  associatedtype Entity
  func setup(entity: Entity)
}
