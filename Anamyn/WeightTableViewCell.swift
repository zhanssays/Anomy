//
//  WeightTableViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/4/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import Reusable
import EasyPeasy

class WeightTableViewCell: UITableViewCell, Reusable {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews(){
        self.addSubview(dateLabel)
        self.addSubview(weigthLabel)
        self.addSubview(diferenceWeigthLabel)
    }
    
    func configureConstraints(){
        dateLabel <- [
            Top(15),
            Bottom(15),
            Left(10)
            
        ]
        
        weigthLabel <- [
            Top(15),
            Bottom(15),
            CenterX()
        ]
        
        diferenceWeigthLabel <- [
            Top(15),
            Bottom(15),
            Right(10)
        ]
    }
    
    lazy var dateLabel: UILabel = {
        var label  = UILabel()
        label.text = "12.08.2017"
        label.textColor = UIColor.black
        label.font = label.font.withSize(14)
        return label
    }()
    
    lazy var weigthLabel: UILabel = {
        var label  = UILabel()
        label.text = "45.0 "
        label.textColor = UIColor.black
        label.font = label.font.withSize(14)
        return label
    }()

    lazy var diferenceWeigthLabel: UILabel = {
        var label  = UILabel()
        label.text = "+ 6.0 "
        label.textColor = UIColor.black
        label.font = label.font.withSize(14)
        return label
    }()
}
