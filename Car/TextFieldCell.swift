//
//  TextFieldCell.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/29.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldCell: UITableViewCell {

  @IBOutlet private weak var titleLabel: UILabel!

  @IBOutlet private weak var contentTextField: UITextField!

  var textValue: ControlProperty<String?> {
    return contentTextField.rx.text
  }

  var title: String {
    set {
      titleLabel.text = newValue
    }

    get {
      return titleLabel.text ?? ""
    }
  }
}
