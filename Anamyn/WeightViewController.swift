//
//  WeightViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/3/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import Sugar
import Tactile
import EasyPeasy
import SVProgressHUD
import DateToolsSwift
import ALTextInputBar

class WeightViewController: UIViewController {
    
    fileprivate var weights = [Weight]()
    var weight: Weight!
    
    lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "dd.MM.yyyy"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Салмағым"        
        loadData()
    }
    
    fileprivate func loadData() {
        Weight.fetchWeight{ kilos in
            guard let kilos = kilos else { return }
            self.weights.append(kilos)
            self.tableView.reloadData()
        }
    }
    
    
    
    lazy var tableHeaderView: UIView = {
        let header = UIView()
        let screen = UIScreen.main.bounds
        header.frame = CGRect(x: 0, y: 0, width: screen.width, height: 200)
        header.backgroundColor = UIColor(red: 112/255, green: 197/255, blue: 183/255, alpha: 1)
        //header.delegate = self
        return header
    }()
    
    
    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: WeightTableViewCell.self)
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 100
            $0.tableFooterView = UIView()
            $0.separatorStyle = .none
            $0.allowsSelection = false
            $0.separatorStyle = .singleLine
            
            //$0.backgroundColor = UIColor.red
            
        }
    }()

    func setupViews(){
        view.addSubview(tableView)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableHeaderView?.addSubview(weigthAddButton)
        tableView.tableHeaderView?.addSubview(beginnerLabel)
        tableView.tableHeaderView?.addSubview(beginnerLabelWeigth)
        tableView.tableHeaderView?.addSubview(lastLabel)
        tableView.tableHeaderView?.addSubview(lastLabelWeigth)
        tableView.tableHeaderView?.addSubview(differenceLabelWeigth)
        tableView.tableHeaderView?.addSubview(dateLabel)
        tableView.tableHeaderView?.addSubview(dateWeightLabel)
        tableView.tableHeaderView?.addSubview(dateWeightDiferrenceLabel)
    }
    
    func setupConstraints(){
        
        tableView <- Edges()

//        
//       mainView <- [
//            Top(),
//            Left(),
//            Right(),
//            Height(250)
//        ]
//        
        weigthAddButton <- [
            Top(100),
            Left(),
            Right()
        ]

        beginnerLabel <- [
            Left(10),
            Top(15)
        ]
        
        beginnerLabelWeigth <- [
            Top(2).to(beginnerLabel),
            Left(10)
        ]
        
        lastLabel <- [
            Left(30).to(beginnerLabel),
            Top(15)
        ]
        
        lastLabelWeigth <- [
            Top(2).to(lastLabel),
            Left(30).to(beginnerLabel)
        ]
        
        differenceLabelWeigth <- [
            Top(25),
            Right(20)
        ]
        
        dateLabel <- [
            Top(25).to(weigthAddButton),
            Left(10)
        ]
        
        dateWeightLabel <- [
            Top(25).to(weigthAddButton),
            CenterX()
        ]
        dateWeightDiferrenceLabel <- [
            Top(25).to(weigthAddButton),
            Right(10)
        ]
        
    }

    lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 112/255, green: 197/255, blue: 183/255, alpha: 1)
        return view
    }()
    
    lazy var weigthAddButton: UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "buttonAddWeight"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(addOrEditWeight), for: .touchUpInside)
        return button
    }()
    
    lazy var beginnerLabel : UILabel = {
        var label = UILabel()
        label.text = "Бастыпқы"
        label.textColor = UIColor.white
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var beginnerLabelWeigth : UILabel = {
        var label = UILabel()
        label.text = "50"
        label.textColor = UIColor.white
        label.font = label.font.withSize(18)
        return label
    }()
    
    lazy var lastLabel : UILabel = {
        var label = UILabel()
        label.text = "Қазіргі"
        label.textColor = UIColor.white
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var lastLabelWeigth : UILabel = {
        var label = UILabel()
        label.text = "55"
        label.textColor = UIColor.white
        label.font = label.font.withSize(18)
        return label
    }()
    
    lazy var differenceLabelWeigth : UILabel = {
        var label = UILabel()
        label.text = "+5.0"
        label.textColor = UIColor.white
        label.font = label.font.withSize(26)
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        var date = UILabel()
        date.text = "Дата"
        date.font = date.font.withSize(14)
        date.textColor = UIColor.white
        return date
    }()
    
    lazy var dateWeightLabel : UILabel = {
        var date = UILabel()
        date.text = "Салмақ"
        date.font = date.font.withSize(14)
        date.textColor = UIColor.white
        return date
    }()
    
    lazy var dateWeightDiferrenceLabel : UILabel = {
        var date = UILabel()
        date.text = "Өзгеріс"
        date.font = date.font.withSize(14)
        date.textColor = UIColor.white
        return date
    }()
    
    func addOrEditWeight(){
        let vc = AddWeightViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WeightViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weights[indexPath.row].remove(completion: { error in
                if let error = error?.localizedDescription {
                    SVProgressHUD.showError(withStatus: error)
                } else {
                    self.weights.removeAll()
                    self.loadData()
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weights.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as WeightTableViewCell
        let weight = weights[indexPath.row]
        if let date = weight.createdAt {
            cell.dateLabel.text = dateFormatter.string(from: date)
        }
        cell.weigthLabel.text = weight.weight
        return cell
    }
}
