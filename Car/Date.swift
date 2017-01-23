//
//  Date.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/24.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

extension Date {
  var displayText: String {
    let elapsedSeconds = Int.init(-timeIntervalSinceNow)
    switch elapsedSeconds {
    case 0..<60:
      return "\(elapsedSeconds)秒前"
    case 60..<3_600:
      return "\(elapsedSeconds / 60)分前"
    case 3_600..<86_400:
      return "\(elapsedSeconds / 60 / 24)時間前"
    case 86_400..<604_800:
      return "\(elapsedSeconds / 60 / 24 / 7)日前"
    default:
      let dateFormatter = DateFormatter.init()
      dateFormatter.dateFormat = "yyyy/MM/dd"
      return dateFormatter.string(from: self)
    }
  }
}
