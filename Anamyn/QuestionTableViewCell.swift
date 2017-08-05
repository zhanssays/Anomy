//
//  QuestionTableViewCell.swift
//  karaoke
//
//  Created by Nurdaulet Bolatov on 7/29/17.
//  Copyright © 2017 Otel Danagul. All rights reserved.
//

import UIKit
import Reusable
import EasyPeasy

final class QuestionTableViewCell: UITableViewCell, Reusable {

    lazy var questionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .left
    }

    lazy var commentsButton: UIButton = {
        return UIButton(type: .system).then {
            $0.setTitle("View all comments", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configureViews() {
        contentView.addSubviews(questionLabel)
    }

    fileprivate func configureConstraints() {
        questionLabel <- [
            Top(10),
            Left(10),
            Right(10),
            Bottom(10)//.to(commentsButton, .top)
        ]
//        commentsButton <- [
//            Left(),
//            Right(),
//            Bottom(),
//            Height(40)
//        ]
    }
    
    

}
