//
//  InfoCollectionViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

class InfoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var foodButton: UIButton = {
        let button = UIButton()
        //var image = UIImage()
        //button.setImage(image, for: .normal)
        button.sizeToFit()
        button.sizeToFit()
        //button.addTarget(self, action: #selector(infoWindow), for: .touchUpInside)
        return button
    }()
    
    lazy var foodLabel: UILabel = {
        var label = UILabel()
        //label.text = "Тамақ"
        label.font = label.font.withSize(16)
        return label
    }()
    
    func setupViews(){
        self.addSubview(foodButton)
        self.addSubview(foodLabel)
    }
    
    func setupConstraints(){
        foodButton <- [
            Top(20),
            Left(30),
            //Right(100)
            //Bottom(70)
        ]
        foodLabel <- [
            Top(7).to(foodButton),
            CenterX().to(foodButton)
        ]
    }
}
