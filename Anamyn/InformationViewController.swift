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

class InformationViewController: UIViewController {

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
            Top().to(tableHeaderView),
            Left(),
            Right(),
            Bottom()
        ]
    }

    
    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: InfoTableViewCell.self)
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 100
            $0.tableFooterView = UIView()
            $0.allowsSelection = false
            $0.separatorStyle = .singleLine
            
            //$0.backgroundColor = UIColor.red
            
        }
    }()
    
    lazy var tableHeaderView: InfoTableHeaderView = {
        let header = InfoTableHeaderView()
        //header.backgroundColor = UIColor.red
        let screen = UIScreen.main.bounds
        header.frame = CGRect(x: 0, y: 0, width: screen.width, height: 200)
        //header.delegate = self
        return header
    }()

    
    

}


extension InformationViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as InfoTableViewCell
        //let weight = weights[indexPath.row]
        //cell.dateLabel.text  = weight.weight
        return cell
    }
}

