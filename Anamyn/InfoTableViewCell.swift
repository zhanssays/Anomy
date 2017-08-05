//
//  InfoTableViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import Reusable
import EasyPeasy

class InfoTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var foodLabel: UILabel = {
        var label = UILabel()
        //label.text = "Тамақ"
        label.font = label.font.withSize(16)
        return label
    }()
    
    func setupViews(){
        self.addSubview(foodLabel)
    }
    
    func setupConstraints(){
    
        foodLabel <- [
            Top(23),
            Left(18),
            Bottom(21)
        ]
    }

}
