//
//  BalaTableViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/25/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

class BalaTableViewCell: UITableViewCell {
    
    lazy var weekImage : UIImageView={
        let image = UIImageView(image: UIImage(named: "weekOvals"))
        return image
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.text = "4 Апта"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var secondTitle: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.text = "Маковое зерно"
        return label
    }()
    
    lazy var lengthLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.text = "Длина: 0.3"
        return label
    }()
    
    lazy var weigthLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.text = "Вес: 0.2г"
        return label
    }()
    
    lazy var urBabyTitle: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(18)
        label.text = "Твой ребенок"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.addSubview(weekImage)
        self.addSubview(mainTitle)
        self.addSubview(secondTitle)
        self.addSubview(lengthLabel)
        self.addSubview(weigthLabel)
        self.addSubview(urBabyTitle)
    }
    
    private func setupConstraints(){
        weekImage <- [
            Top(15),
            Left(16)
        ]
        mainTitle <- [
            Top(15),
            Left(117)
            
        ]
        secondTitle <- [
            Top(40),
            Left(117)
            
        ]
        lengthLabel <- [
            Top(65),
            Left(117)
            
        ]
        weigthLabel <- [
            Top(90),
            Left(117)
            
        ]
        urBabyTitle <- [
            Top(120),
            Left(22)
            
        ]
    }

}
