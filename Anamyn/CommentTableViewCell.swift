//
//  CommentTableViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/29/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//


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

//protocol protoc {
//    func addImage()
//
//}

final class CommentTableViewCell: UITableViewCell, Reusable {
    
    lazy var commentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    lazy var iconImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "userIcon"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var dateLabel: UILabel = {
        var time = UILabel()
        time.font = time.font.withSize(10)
        time.textColor = UIColor.gray.withAlphaComponent(2)
        time.text = "2 hours ago"
        return time
    }()
   
    lazy var usernameLabel: UILabel = {
        var userName = UILabel()
        userName.font = userName.font.withSize(12)
        userName.textColor = UIColor.black.withAlphaComponent(50)
        return userName
    }()
    
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
        usernameLabel.text = nil
    }
    
    fileprivate func configureViews() {
        contentView.addSubviews(commentLabel, iconImage, dateLabel, usernameLabel)
    }
    
    fileprivate func configureConstraints() {
       
        iconImage <- [
            Top(14),
            Left(14),
            Size(50)
        ]
        commentLabel <- [
            Left(12).to(iconImage),
            Top(40),
            Right(12),
            Bottom(14)
        ]
         dateLabel <- [
            Left(12).to(iconImage),
            Bottom(6).to(commentLabel)
        ]
        usernameLabel <- [
            Left(12).to(iconImage),
            Bottom(1).to(dateLabel)
        ]
    }
    
    func addImage(){
        
    }
    
    
}

