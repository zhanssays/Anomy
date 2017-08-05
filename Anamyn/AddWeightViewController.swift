//
//  AddWeightViewController.swift
//  karaoke
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Otel Danagul. All rights reserved.
//

import UIKit
import Sugar
import EasyPeasy
import SVProgressHUD

final class AddWeightViewController: UIViewController, UIScrollViewDelegate {
    
    fileprivate var rightBarButtonItem: UIBarButtonItem?

    fileprivate var weightView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "clock")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 500
        $0.layer.masksToBounds = true
    }

    fileprivate lazy var scrollView: UIScrollView = {
        return UIScrollView().then {
            $0.delegate = self
            $0.backgroundColor = .clear
            $0.contentSize = CGSize(width: UIScreen.main.bounds.width + 360 * 100, height: 100)
            $0.contentOffset = CGPoint(x: 50 * 360, y: 0)
            $0.showsHorizontalScrollIndicator = false
        }
    }()

    fileprivate var wrapperView = UIView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7490196078, blue: 0.6862745098, alpha: 1)
    }

    fileprivate var lineView = UIView().then {
        $0.backgroundColor = .red
    }

    fileprivate lazy var weightLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.numberOfLines = 1
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    fileprivate lazy var datePicker: UIDatePicker = {
        return UIDatePicker().then {
            $0.datePickerMode = .date
        }
    }()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }

    // MARK: Configurations

    fileprivate func configureViews() {
        rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addWeight))
        rightBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = .white
        wrapperView.addSubviews(weightView, lineView, weightLabel, scrollView)
        view.addSubviews(wrapperView, datePicker)
    }

    fileprivate func configureConstraints() {
        wrapperView <- [
            Top(),
            Left(),
            Right(),
            Height(250)
        ]
        scrollView <- Edges()
        weightView <- [
            CenterX(),
            Top(-150).to(wrapperView, .bottom),
            Size(1000)
        ]
        lineView <- [
            CenterX(),
            Bottom(),
            Height(80),
            Width(4)
        ]
        weightLabel <- [
            CenterX(),
            Top(30)
        ]
        datePicker <- [
            Top().to(wrapperView, .bottom),
            Left(),
            Right(),
            Bottom()
        ]
    }
    
    // MARK: Actions
    
    func addWeight() {
        guard let weight = weightLabel.text else { return }
        Weight.addWeight(with: weight, createdAt: datePicker.date) { (error) in
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let angle = -(scrollView.contentOffset.x / 10)
        let remainder = abs(angle.truncatingRemainder(dividingBy: 360))
        weightLabel.text = String(format: "%.1f", 40 + (remainder * 120) / 360)
        weightView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 180 * angle)
    }

}
