//
//  Permission.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/27.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

struct Permission {
  static let photoLibrary = Observable<PHAuthorizationStatus>.create { (observer) -> Disposable in
    switch PHPhotoLibrary.authorizationStatus() {
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization({ (status) in
        observer.onNext(status)
        observer.onCompleted()
      })
    default:
      observer.onNext(PHPhotoLibrary.authorizationStatus())
      observer.onCompleted()
    }

    return Disposables.create()
  }
}
