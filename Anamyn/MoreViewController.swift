//
//  MoreViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/24/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

class MoreViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = UIColor.white
    }

    var isIphone5 = UIScreen.main.bounds.width == 320
    var isIphone6plus = UIScreen.main.bounds.width == 414
    
    lazy var weightButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "item1"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(weightWindow), for: .touchUpInside)
        return button
    }()
    
    lazy var weigthLabel: UILabel = {
        var label = UILabel()
        label.text = "Салмағым"
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "item2"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(infoWindow), for: .touchUpInside)
        return button
    }()
    
    lazy var infoLabel: UILabel = {
        var label = UILabel()
        label.text = "Справочники"
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var nameButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Item3"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(nameWindow), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Есімдер"
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var birthButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "item4"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var bitrhLabel: UILabel = {
        var label = UILabel()
        label.text = "В роддом"
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var todoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "item5"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    lazy var todoLabel: UILabel = {
        var label = UILabel()
        label.text = "Дела"
        label.font = label.font.withSize(16)
        return label
    }()

    lazy var photoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "item6"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(photosWindow), for: .touchUpInside)
        return button
    }()
    
    lazy var photoLabel: UILabel = {
        var label = UILabel()
        label.text = "Фото"
        label.font = label.font.withSize(16)
        return label
    }()
    
    private func setupConstraints(){
        weightButton <- [
            Top(78),
            isIphone5 ? Left(28) : Left(38),
            isIphone5 ? Size(100) : (isIphone6plus ? Size(130) : Size(117))
        ]
        weigthLabel <- [
            Top(8).to(weightButton),
            //Left(57),
            CenterX(0).to(self.weightButton)
            
        ]
        infoButton <- [
            Top(78),
            isIphone5 ? Right(28) : Right(38),
            isIphone5 ? Size(100) : (isIphone6plus ? Size(130) : Size(117))
        ]
        infoLabel <- [
            Top(8).to(infoButton),
            //Left(228),
            CenterX(0).to(self.infoButton)
            
        ]
        nameButton <- [
            isIphone5 ? Top(16).to(weigthLabel) : Top(40).to(weigthLabel),
            isIphone5 ? Left(28) : Left(38),
            isIphone5 ? Size(100) : (isIphone6plus ? Size(130) : Size(117))
        ]
        nameLabel <- [
            Top(8).to(nameButton),
            //Left(65),
            CenterX(0).to(self.nameButton)
            
        ]
        
        birthButton <- [
            isIphone5 ? Top(16).to(infoLabel) : Top(40).to(infoLabel),
            //Left(77).to(infoButton),
             isIphone5 ? Right(28) : Right(38),
            isIphone5 ? Size(100) : (isIphone6plus ? Size(130) : Size(117))
        ]
        
        bitrhLabel <- [
            Top(8).to(birthButton),
            //Left(245),
            CenterX(0).to(self.birthButton)
            
            
        ]
        
        todoButton <- [
            isIphone5 ? Top(16).to(nameLabel) : Top(40).to(nameLabel),
            isIphone5 ? Left(28) : Left(38),
            isIphone5 ? Size(100) : (isIphone6plus ? Size(130) : Size(117))
        ]
        
        todoLabel <- [
            Top(8).to(todoButton),
            //Left(70),
            CenterX(0).to(self.todoButton)
            
            
        ]
        
        photoButton <- [
            isIphone5 ? Top(16).to(bitrhLabel) : Top(40).to(bitrhLabel),
            isIphone5 ? Right(28) : Right(38),
            isIphone5 ? Size(100) : (isIphone6plus ? Size(130) : Size(117))
        ]
        
        photoLabel <- [
            Top(8).to(photoButton),
            //Left(70),
            CenterX(0).to(self.photoButton)
            
            
        ]
        
    }
    
    private func setupViews() {
        self.view.addSubview(weightButton)
        self.view.addSubview(weigthLabel)
        self.view.addSubview(infoButton)
        self.view.addSubview(infoLabel)
        self.view.addSubview(nameButton)
        self.view.addSubview(nameLabel)
        self.view.addSubview(birthButton)
        self.view.addSubview(bitrhLabel)
        self.view.addSubview(todoButton)
        self.view.addSubview(todoLabel)
        self.view.addSubview(photoButton)
        self.view.addSubview(photoLabel)
    }
    
    func weightWindow(){
        let vc = WeightViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func infoWindow(){
        let vc = InformationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func nameWindow(){
        let vc = NamesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func photosWindow(){
        let vc = MyPhotosViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
