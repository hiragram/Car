//
//  PostCollectionViewController.swift
//  Car
//
//  Created by yuya_hirayama on 2017/01/24.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Models

class PostCollectionViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.register(nibWithType: PostCollectionViewCell.self)

      vm.asObservable().filterNil().subscribe(onNext: { [unowned self] (vm) in
        vm.itemContainer.items.bindTo(self.collectionView.rx.items(cellType: PostCollectionViewCell.self)) { number, item, cell in
          cell.setup(entity: item)
        }.addDisposableTo(self.bag)

        let refreshControl = UIRefreshControl.init()
        refreshControl.rx.controlEvent(.valueChanged).flatMap {
          vm.fetch
          }.subscribe().addDisposableTo(vm.bag)
        vm.isLoading.bindTo(refreshControl.rx.isRefreshing).addDisposableTo(vm.bag)
        self.collectionView.refreshControl = refreshControl

      }).addDisposableTo(bag)

      collectionView.delegate = self
    }
  }

  var vm = Variable<PostListViewModel?>.init(nil)


}

extension PostCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let dimension = UIScreen.main.bounds.width / 2
    return CGSize.init(width: dimension, height: dimension)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
