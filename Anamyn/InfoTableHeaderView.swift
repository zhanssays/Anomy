//
//  InfoTableHeaderView.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy

class InfoTableHeaderView: UIView {
    
    var imagesArraySelected = [#imageLiteral(resourceName: "Тамак"),#imageLiteral(resourceName: "Hospital2"),#imageLiteral(resourceName: "Sport2"),#imageLiteral(resourceName: "medicine2")]
    var imagesArrayUnselected = [#imageLiteral(resourceName: "Тамак2"),#imageLiteral(resourceName: "hospital1"),#imageLiteral(resourceName: "Sport1"),#imageLiteral(resourceName: "medicine1")]
    
    var names = ["Тамақ","Роды","Спорт","Медицина"]
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCollId")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
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

extension InfoTableHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollId", for: indexPath) as! InfoCollectionViewCell
        //cell.titleLabel.text = "\(indexPath.item + 1)"
        cell.foodButton.setImage(imagesArraySelected[indexPath.row], for: .normal)
        cell.foodLabel.text = names[indexPath.row]
        cell.frame.size.width = UIScreen.main.bounds.size.width / 3
        cell.frame.size.height = UIScreen.main.bounds.size.width / 3
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if let cell = collectionView.cellForItem(at: IndexPath(item: indexPath.item, section: indexPath.section)) as? WeekCollectionViewCell {
        //
        //            cell.selectedView.isHidden = false
        //            cell.titleLabel.textColor = .black
        //        }
        //delegate?.didSelectWeek(index: indexPath.item+1)
        //delegate?.selectRow(index: indexPath.item)
    }
}

