//
//  NewNamesViewController.swift
//  Anamyn
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

final class NewNamesViewController: UIViewController, UITableViewDataSource {

    var likedNames = [Name]()
    fileprivate var names = [Name]()

    fileprivate var filteredNames: [Name] {
        return names.filter({ segmentedControl.selectedSegmentIndex == 0 ?
            $0.gender == "f" : $0.gender == "m" })
    }

    fileprivate var wrapperView = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.6235294118, blue: 0.5529411765, alpha: 1)
    }

    fileprivate var segmentedControl: UISegmentedControl = {
        return UISegmentedControl(items: ["Qyz", "Erkek"]).then {
            $0.tintColor = .white
            $0.selectedSegmentIndex = 0
            $0.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        }
    }()

    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: NameTableViewCell.self)
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 44
            $0.tableFooterView = UIView()
            $0.separatorStyle = .none
            $0.allowsSelection = false
        }
    }()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        loadData()
    }

    // MARK: Data

    fileprivate func loadData() {
        Name.fetchAllNames { name in
            guard let name = name else { return }
            self.names.append(name)
            self.tableView.reloadData()
        }
    }

    // MARK: Configurations

    fileprivate func configureViews() {
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = .white
        wrapperView.addSubview(segmentedControl)
        view.addSubviews(wrapperView, tableView)
    }

    fileprivate func configureConstraints() {
        wrapperView <- [
            Top(),
            Left(),
            Right()
        ]
        segmentedControl <- [
            Top(8),
            Left(60),
            Right(60),
            Bottom(8),
            Height(30)
        ]
        tableView <- [
            Top().to(wrapperView, .bottom),
            Left(),
            Right(),
            Bottom()
        ]
    }

    // MARK: Actions

    func segmentChanged() {
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as NameTableViewCell
        cell.nameLabel.text = filteredNames[indexPath.row].name
        if let _ = likedNames.findFirst({ $0.name == filteredNames[indexPath.row].name }) {
            cell.like()
        } else {
            cell.dislike()
        }

        cell.contentView.tap { _ in
            if cell.isLiked {
                if let index = self.likedNames.index(where: { $0.name == self.filteredNames[indexPath.row].name }) {
                    self.likedNames.remove(at: index)
                }
                self.filteredNames[indexPath.row].dislike()
                cell.dislike()
            } else {
                self.likedNames.append(self.filteredNames[indexPath.row])
                self.filteredNames[indexPath.row].like()
                cell.like()
            }
        }
        return cell
    }
    
}
