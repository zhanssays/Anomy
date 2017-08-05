//
//  InfooViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

class InfooViewController: UIViewController {

    var foodArrayAddition =  ["Что можно естьvfgvbg","Что нельзя естьbgfgb","Витамины и минералыvfrvf","Набор весаvrfvrf","Сколько нужно естьvfrvf"]
    var foodArrayAddition2 =  ["Что можно естьvfgvbg2","Что нельзя естьbgfgb2","Витамины и минералыvfrvf2","Набор весаvrfvrf2","Сколько нужно естьvfrvf2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        self.view.backgroundColor = UIColor.white
    }
    
    func didSelect(selectedButton:Int,row:Int){
        if selectedButton == 0{
            foodLabel.text =  foodArrayAddition[row]
        }else if selectedButton == 1{
            foodLabel.text =  foodArrayAddition2[row]
        }else{
            foodLabel.text =  foodArrayAddition[row]
        }
    }

    lazy var foodLabel: UILabel = {
        var label = UILabel()
        //label.text = "Тамақ"
        label.font = label.font.withSize(16)
        return label
    }()
    
    func setupViews(){
        self.view.addSubview(foodLabel)
    }
    
    func setupConstraints(){
        
        foodLabel <- [
            Top(20),
            Left(18),
            Bottom(21)
        ]
    }
  

}
