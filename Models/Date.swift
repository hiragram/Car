//
//  Date.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/24.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

extension Date {
  init?(twitterDateString dateString: String) {
    let formatter = DateFormatter.init()
    // Wed Aug 27 13:08:45 +0000 2008
    formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    if let timestamp = formatter.date(from: dateString)?.timeIntervalSince1970 {
      self.init(timeIntervalSince1970: timestamp)
    } else {
      return nil
    }
  }
}
