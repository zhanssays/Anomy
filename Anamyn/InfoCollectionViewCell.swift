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
        button.setImage(#imageLiteral(resourceName: "Тамак"), for: .normal)
        button.sizeToFit()
        //button.addTarget(self, action: #selector(infoWindow), for: .touchUpInside)
        return button
    }()
    
    func setupViews(){
        self.addSubview(foodButton)
    }
    
    func setupConstraints(){
        foodButton <- [
            Top(30),
            Left(30),
            Bottom(70)
        ]
    }
}
