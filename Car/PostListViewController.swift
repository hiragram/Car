//
//  PostListViewController.swift
//  Car
//
//  Created by yuyahirayama on 2017/01/19.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Models
import SafariServices

final class PostListViewController: UIViewController, StoryboardInstantiatable {

  private let bag = DisposeBag.init()

  @IBOutlet fileprivate weak var tableView: UITableView! {
    didSet {
      tableView.register(nibWithType: PostListCell.self)
      tableView.estimatedRowHeight = 360

      vm.asObservable().filterNil().subscribe(onNext: { [unowned self] (vm) in
        vm.itemContainer.items.bindTo(self.tableView.rx.items(cellType: PostListCell.self)) { row, item, cell in
          cell.setup(entity: item)
          cell.imageViews.enumerated().forEach({ (index: Int, imageView: UIImageView?) in
            let recognizer = UITapGestureRecognizer.init()
            imageView?.addGestureRecognizer(recognizer)
            recognizer.rx.event.map{_ in ()}.subscribe(onNext: { (_) in
              self.show(ImageDetailViewController.self, sender: nil) { vc in
                vc.imageURL = Observable.just(item.media[index].url)
              }
            }).addDisposableTo(cell.bag)
          })
          }.addDisposableTo(vm.bag)
      }).addDisposableTo(bag)

      tableView.rx.modelSelected(PostListViewModel.Item.self).subscribe(onNext: { [weak self] (item) in
        self?.present(SFSafariViewController.init(url: item.postURL), animated: true, completion: nil)
      }).addDisposableTo(bag)

      tableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] (indexPath) in
        self?.tableView.deselectRow(at: indexPath, animated: true)
      }).addDisposableTo(bag)
    }
  }

  @IBOutlet private weak var refreshControl: UIRefreshControl! {
    didSet {
      vm.asObservable().filterNil().subscribe(onNext: { [unowned self] (vm) in
        self.refreshControl.rx.controlEvent(.valueChanged).flatMap {
          vm.fetch
        }.subscribe().addDisposableTo(vm.bag)
        vm.isLoading.bindTo(self.refreshControl.rx.isRefreshing).addDisposableTo(vm.bag)
      }).addDisposableTo(bag)
    }
  }

  @IBOutlet private weak var settingsButton: UIBarButtonItem! {
    didSet {
      settingsButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
        let vc = UINavigationController.init(rootViewControllerType: SettingsViewController.self)
        self.present(vc, animated: true, completion: nil)
      }).addDisposableTo(bag)
    }
  }

  var vm = Variable<PostListViewModel?>.init(nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    switch traitCollection.forceTouchCapability {
    case .available:
      registerForPreviewing(with: self, sourceView: tableView)
    default:
      break
    }
  }
}

extension PostListViewController: UIViewControllerPreviewingDelegate {
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    guard let indexPath = tableView.indexPathForRow(at: location) else {
      return nil
    }
    guard let cell = tableView.cellForRow(at: indexPath) as? PostListCell else {
      return nil
    }
    let images = cell.imageViews.flatMap { $0 }
    for (index, view) in images.enumerated() where touchedView(view, location: location) {
      let viewRectInTableView = tableView.convert(view.frame, from: view.superview!)
      previewingContext.sourceRect = viewRectInTableView

      return ImageDetailViewController.instantiateFromStoryboard(configuration: { (vc) in
        vc.imageURL = Observable.just(cell.images[index].url)
      })
    }
    return nil
  }

  func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    navigationController?.pushViewController(viewControllerToCommit, animated: true)
  }

  private func touchedView(_ view: UIView, location: CGPoint) -> Bool {
    let locationInView = view.convert(location, from: tableView)
    return view.bounds.contains(locationInView)
  }
}
