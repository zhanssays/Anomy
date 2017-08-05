//
//  PhotoCollectionViewCell.swift
//  Anamyn
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import Reusable
import EasyPeasy

final class PhotoCollectionViewCell: UICollectionViewCell, Reusable {

    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 50
        $0.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.6235294118, blue: 0.5529411765, alpha: 1).cgColor
        $0.layer.borderWidth = 2
        $0.clipsToBounds = true
    }

    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configureViews() {
        contentView.addSubviews(imageView, titleLabel)
    }

    fileprivate func configureConstraints() {
        imageView <- [
            Top(20),
            CenterX(),
            Size(100)
        ]
        titleLabel <- [
            Top(8).to(imageView, .bottom),
            CenterX()
        ]
    }

}
