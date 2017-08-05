//
//  NewQuestionViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/2/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy
import Sugar
import Tactile
import SVProgressHUD

class NewQuestionViewController: UIViewController {
    
    var rightBarButtonItem: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupViews()
        configureViews()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        rightBarButtonItem = UIBarButtonItem(title: "Отправить", style: .plain, target: self, action: #selector(askQuestion))
        rightBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightBarButtonItem

    }
    
    lazy var questionTextView: UITextView = {
        var tv  = UITextView()
        tv.backgroundColor = UIColor.white
        tv.font = .systemFont(ofSize: 18)
        return tv
    }()
  
    private func setupConstraints() {
        questionTextView <- [
            Left(0),
            Right(0),
            Top(),
            Height(view.height/2),
            Width(view.width)
        ]
    }
    
    private func setupViews() {
        view.addSubview(questionTextView)
    }
    
    fileprivate func configureViews() {
        edgesForExtendedLayout = UIRectEdge()
        navigationItem.title = "Жаңа сұрақ"
        view.backgroundColor = .white
       
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func askQuestion(){
        if (!questionTextView.text.isEmpty){
            Post.addPost(with: questionTextView.text) { error in
                            if let error = error {
                                SVProgressHUD.showError(withStatus: error.localizedDescription)
                            }
                        }
            _ = navigationController?.popViewController(animated: true)
        }
    }

}
