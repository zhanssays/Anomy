//
//  WeekCollectionViewCell.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/25/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy


class WeekCollectionViewCell: UICollectionViewCell, WeekTableHeaderViewDelegate2 {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            isSelected ? didSelect() : didUnselectWeek()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor(displayP3Red: 246/255, green: 161/255, blue: 138/255, alpha: 1)
        self.addSubview(selectedView)
        self.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel <- Center()
        selectedView <- [
            Height(30),
            Width(30)
        ]
        selectedView <- Center()
    }
    
    func didSelect() {
        titleLabel.textColor = .black
        selectedView.isHidden = false
    }
    
    func didUnselectWeek() {
        titleLabel.textColor = .white
        selectedView.isHidden = true
        print("da")
    }
    
}
