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
    
    lazy var weightButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "item1"), for: .normal)
        button.sizeToFit()
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
        button.sizeToFit()
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
        button.sizeToFit()
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
        button.sizeToFit()
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
        button.sizeToFit()
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
        button.sizeToFit()
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
            Left(38),
            
        ]
        weigthLabel <- [
            Top(8).to(weightButton),
            //Left(57),
            CenterX(0).to(self.weightButton)
            
        ]
        infoButton <- [
            Top(78),
            Right(38),
            
        ]
        infoLabel <- [
            Top(8).to(infoButton),
            //Left(228),
            CenterX(0).to(self.infoButton)
            
        ]
        nameButton <- [
            Top(40).to(weigthLabel),
            Left(38),
            
        ]
        nameLabel <- [
            Top(8).to(nameButton),
            //Left(65),
            CenterX(0).to(self.nameButton)
            
        ]
        
        birthButton <- [
            Top(40).to(infoLabel),
            //Left(77).to(infoButton),
             Right(38)
            
        ]
        
        bitrhLabel <- [
            Top(8).to(birthButton),
            //Left(245),
            CenterX(0).to(self.birthButton)
            
            
        ]
        
        todoButton <- [
            Top(40).to(nameLabel),
            Left(38)
            
        ]
        
        todoLabel <- [
            Top(8).to(todoButton),
            //Left(70),
            CenterX(0).to(self.todoButton)
            
            
        ]
        
        photoButton <- [
            Top(40).to(bitrhLabel),
            Right(38)
            
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
