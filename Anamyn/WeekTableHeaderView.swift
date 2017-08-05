//
//  WeekTableHeaderView.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/25/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

protocol WeekTableHeaderViewDelegate: class {
    func didSelectWeek(index:Int)
    func selectRow(index:Int)
    //func didUnselectWeek()
}

protocol WeekTableHeaderViewDelegate2: class {
    func didUnselectWeek()
}

class WeekTableHeaderView: UIView {
    
    weak var delegate: WeekTableHeaderViewDelegate?
    weak var delegate2 :  WeekTableHeaderViewDelegate2?
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: "WeekCollId")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(displayP3Red: 246/255, green: 161/255, blue: 138/255, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView <- [
            Edges()
        ]
    }

}

extension WeekTableHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekCollId", for: indexPath) as! WeekCollectionViewCell
        cell.titleLabel.text = "\(indexPath.item + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: IndexPath(item: indexPath.item, section: indexPath.section)) as? WeekCollectionViewCell {
//            
//            cell.selectedView.isHidden = false
//            cell.titleLabel.textColor = .black
//        }
        delegate?.didSelectWeek(index: indexPath.item+1)
        delegate?.selectRow(index: indexPath.item)
    }
}
