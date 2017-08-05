//
//  InformationViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import Sugar
import Tactile
import EasyPeasy
import SVProgressHUD
import DateToolsSwift
import ALTextInputBar

protocol InfoTableHeaderViewDelegate2: class {
    
    func didSelect(selectedButton:Int,row:Int)
    
}

class InformationViewController: UIViewController,InfoTableHeaderViewDelegate {
    
    weak var delegate :  InfoTableHeaderViewDelegate2?
    var foodArray = ["Что можно есть","Что нельзя есть","Витамины и минералы","Набор веса","Сколько нужно есть"]
    
    var foodArray2 = ["Что можно есть2","Что нельзя есть2","Витамины и минералы2","Набор веса2","Сколько нужно есть2"]
    var selectedButton = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Cправочники"
    }
    
    func setupViews(){
        edgesForExtendedLayout = UIRectEdge()
        view.addSubview(tableView)
        view.addSubview(tableHeaderView)
    }
    
    func setupConstraints(){
        tableHeaderView <- [
            Top(0),
            Height(200),
            Left(0),
            Right(0)
        ]
        tableView <- [
            Top().to(tableHeaderView, .bottom),
            Left(),
            Right(),
            Bottom()
        ]
    }

    
    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: InfoTableViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 100
            $0.tableFooterView = UIView()
            $0.allowsSelection = true
            $0.separatorStyle = .singleLine
            
            //$0.backgroundColor = UIColor.red
            
        }
    }()
    
    lazy var tableHeaderView: InfoTableHeaderView = {
        let header = InfoTableHeaderView()
        //header.backgroundColor = UIColor.red
        let screen = UIScreen.main.bounds
        header.frame = CGRect(x: 0, y: 0, width: screen.width, height: 200)
        header.delegate = self
        return header
    }()

    func selectRow(index: Int){
        //let indexPath = IndexPath(row: index, section: 0)
        print(index)
        selectedButton = index
        tableView.reloadData()
        //tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        //tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    }
    

}


extension InformationViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedButton == 0{
            return foodArray.count
        }else if selectedButton == 1{
            return foodArray2.count
        }else {
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as InfoTableViewCell
        if selectedButton == 0{
            cell.foodLabel.text = foodArray[indexPath.row]
        }
        else if selectedButton == 1{
            cell.foodLabel.text = foodArray2[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfooViewController()
        vc.didSelect(selectedButton: selectedButton, row: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

