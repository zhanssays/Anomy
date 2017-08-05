//
//  TableViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/24/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

//import TLYShyNavBar

class TableViewController: UIViewController, WeekTableHeaderViewDelegate {
    
    lazy var tableHeaderView: WeekTableHeaderView = {
        let header = WeekTableHeaderView()
        let screen = UIScreen.main.bounds
        header.frame = CGRect(x: 0, y: 0, width: screen.width, height: 50)
        header.delegate = self
        return header
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(BalaTableViewCell.self, forCellReuseIdentifier: "BalaCellId")
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(tableHeaderView)
    }
    
    private func setupConstraints() {
        tableHeaderView <- [
            Top(64),
            Height(50),
            Left(0),
            Right(0)
        ]
        tableView <- [
            //Top(0).to(tableHeaderView, .bottom),
            Top(50),
            Bottom(0),
            Left(0),
            Right(0)
        ]
    }
    
    func didSelectWeek(index: Int) {
        print(index)
    }
    func selectRow(index: Int){
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    }
}




extension TableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BalaCellId", for: indexPath) as!BalaTableViewCell
        cell.textLabel?.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200.0;//Choose your custom row height
        //return UITableViewAutomaticDimension
    }
    
}
