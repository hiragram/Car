//
//  ImageDetailViewController.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/26.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebImage
import Photos

class ImageDetailViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var imageView: UIImageView! {
    didSet {
      imageURL.subscribe(onNext: { [unowned self] (url) in
        self.imageView.setImageWithFade(url: url)
      }).addDisposableTo(bag)
    }
  }

  @IBOutlet weak var saveButton: UIBarButtonItem! {
    didSet {
      saveButton.rx.tap.asObservable()
        .flatMap { [unowned self] in self.imageURL }
        .flatMap { url in
          return Observable<UIImage>.create({ (observer) -> Disposable in
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, error, _, _, _) in
              guard let image = image else {
                observer.onError(error!)
                return
              }

              observer.onNext(image)
              observer.onCompleted()
            })
            return Disposables.create()
          })
        }.subscribe(onNext: { [unowned self] (image) in
          Permission.photoLibrary.subscribe(onNext: { (status) in
            switch status {
            case .authorized:
              break
            default:
              return
            }
            PHPhotoLibrary.shared().performChanges({
              PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: { [unowned self] (succeeded, error) in
              if succeeded {
                let alert = UIAlertController.init(title: "画像の保存", message: "カメラロールに保存しました", preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
              }
            })
          }).addDisposableTo(self.bag)
        })

    }
  }

  var imageURL: Observable<URL>!
}
