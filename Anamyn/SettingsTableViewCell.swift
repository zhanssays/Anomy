//
//  SettingsTableViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/26/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

class SettingsTableViewCell: UITableViewCell {
    
    let px = 1 / UIScreen.main.scale
    let line = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImage : UIImageView={
        let image = UIImageView(image: #imageLiteral(resourceName: "icon1"))
        image.sizeToFit()
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(18)
        label.text = "AppStore"
        return label
    }()
    
    private func setupViews(){
        line.frame = CGRect(x: 55, y: 52 - px, width: UIScreen.main.bounds.width - 55, height: px)
        self.addSubview(line)
        self.addSubview(iconImage)
        self.addSubview(nameLabel)
    }
    
    private func setupConstraints(){
        iconImage <- [
            Top(8),
            Left(9)
        ]
        
        nameLabel <- [
            Top(14),
            Left(10).to(iconImage)
        ]
    }

}
