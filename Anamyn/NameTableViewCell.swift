//
//  NameTableViewCell.swift
//  Anamyn
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import Reusable
import EasyPeasy

final class NameTableViewCell: UITableViewCell, Reusable {

    var isLiked = false

    lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .left
    }

    fileprivate lazy var likeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    fileprivate var separatorView = UIView().then {
        $0.backgroundColor = .lightGray
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dislike()
    }

    func like() {
        isLiked = true
        likeImageView.image = #imageLiteral(resourceName: "like")
    }

    func dislike() {
        isLiked = false
        likeImageView.image = #imageLiteral(resourceName: "dislike")
    }

    fileprivate func configureViews() {
        contentView.addSubviews(nameLabel, likeImageView, separatorView)
    }

    fileprivate func configureConstraints() {
        nameLabel <- [
            Top(8),
            Bottom(8),
            Left(16),
            Right(16).to(likeImageView, .left)
        ]
        likeImageView <- [
            Right(16),
            CenterY(),
            Size(20)
        ]
        separatorView <- [
            Left(),
            Right(),
            Bottom(),
            Height(1 / UIScreen.main.scale)
        ]
    }

}
