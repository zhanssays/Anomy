//
//  PhotosViewController.swift
//  Anamyn
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import ImagePicker
import EasyPeasy
import Kingfisher
import SVProgressHUD

final class MyPhotosViewController: UIViewController, UICollectionViewDataSource, ImagePickerDelegate {

    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 160)
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            $0.register(cellType: PhotoCollectionViewCell.self)
            $0.backgroundColor = .white
            $0.dataSource = self
        }
    }()

    fileprivate var selectedIndexPath: IndexPath?

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }

    // MARK: Configurations

    fileprivate func configureViews() {
        edgesForExtendedLayout = UIRectEdge()
        view.addSubviews(collectionView)
    }

    fileprivate func configureConstraints() {
        collectionView <- Edges()
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCollectionViewCell
        cell.titleLabel.text = "Month: \(indexPath.item)"
        Photo.fetch(photoId: "photo\(indexPath.item)") { url, error in
            cell.imageView.kf.setImage(with: url)
        }
        cell.contentView.tap { _ in
            self.selectedIndexPath = indexPath
            var configuration = Configuration()
            configuration.doneButtonTitle = "Finish"
            configuration.noImagesTitle = "Sorry! There are no images here!"
            configuration.recordLocation = false
            let imagePickerController = ImagePickerController(configuration: configuration)
            imagePickerController.delegate = self
            imagePickerController.imageLimit = 1
            self.tabBarController?.present(imagePickerController, animated: true, completion: nil)
        }
        return cell
    }

    // MARK: ImagePickerDelegate

    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        dismiss(animated: true, completion: nil)
        guard let image = images.first, let selectedIndexPath = selectedIndexPath else { return }
        let selectedPhotoId = "photo\(selectedIndexPath.item)"
        SVProgressHUD.show()
        Photo.save(image: image, at: selectedPhotoId) { url, error in
            SVProgressHUD.dismiss()
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else {
                self.collectionView.reloadItems(at: [selectedIndexPath])
            }
        }
    }

    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    }

}
