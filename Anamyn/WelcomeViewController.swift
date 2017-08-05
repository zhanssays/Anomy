//
//  WelcomeViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/29/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import FirebaseDatabase
import EasyPeasy

class WelcomeViewController: UIViewController {
    
    var ref: DatabaseReference!
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    

    override func viewDidLoad() {
        //inputsContainerViewHeightAnchor?.constant = 200
        super.viewDidLoad()
        ref = Database.database().reference()
        self.view.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7490196078, blue: 0.6862745098, alpha: 1)
        setupViews()
        setupConstraints()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: remove this line
//        signUp(with: "Nurdaulet", email: "b.nurdaulet.b@gmail.com", password: "qwerty")
//        signIn(with: "Test1@mail.com", password: "Qwerty")
    }
    
    func signUp(with name: String?, email: String?, password: String?) {
        guard let name = name, let email = email, let password = password, !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else if let user = user {
                self.ref.child("users/\(user.uid)/name").setValue(name)
                (UIApplication.shared.delegate as? AppDelegate)?.loadMain()
            }
        }
    }
    
    func signIn(with email: String?, password: String?) {
        guard let email = email, let password = password, !email.isEmpty, !password.isEmpty else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else if let _ = user {
                (UIApplication.shared.delegate as? AppDelegate)?.loadMain()
            }
        }
    }
    
    
    private func setupConstraints(){
        inputsContainerView <- [
          
            CenterX(),
            CenterY(),
            Left(33),
            Right(33),
//            Height((inputsContainerViewHeightAnchor?.constant)!)
            Height(200)
            
        ]
        loginRegisterButton <- [
            Top(22).to(inputsContainerView),
            Left(33),
            Right(33),
            Height(50)
        ]
        
        emailTextField <- [
            Top().to(inputsContainerView),
            Left(12),
            Right(),
            Height(66)
            //Bottom( inputsContainerView.height.divided(by: 3) )
        ]
        
        emailSeperator <- [
            Left(),
            Top().to(emailTextField),
            Right(),
            Height(1)
            
            
        ]
        
        passwordTextField <- [
            Top().to(emailSeperator),
            Left(12),
            Right(),
            Height(66)
            //Bottom( inputsContainerView.height.divided(by: 3) )
        ]
        
        passwordSeperator <- [
            Left(),
            Top().to(passwordTextField),
            Right(),
            Height(1)
            
            
        ]
        
        nameTextField <- [
            Top().to(passwordSeperator),
            Left(12),
            Right(),
            Height(66)
            //Bottom( inputsContainerView.height.divided(by: 3) )
        ]
        
        nameSeperator <- [
            Left(),
            Top().to(nameTextField),
            Right(),
            Height(1)
            
            
        ]
        
        loginRegisterSegmentControl <- [
            CenterX(),
            Bottom(22).to(inputsContainerView),
            Left(33),
            Right(33),
            Height(40)
        ]

    }
    
    private func setupViews(){
        self.view.addSubview(inputsContainerView)
        self.view.addSubview(loginRegisterButton)
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeperator)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeperator)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(passwordSeperator)
        self.view.addSubview(loginRegisterSegmentControl)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var loginRegisterSegmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Логин","Регистрация"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.layer.cornerRadius = 10
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    lazy var inputsContainerView: UIView = {
        var inputsView = UIView()
        inputsView.backgroundColor = UIColor.white
        inputsView.translatesAutoresizingMaskIntoConstraints = false
        inputsView.layer.cornerRadius = 10
        inputsView.layer.masksToBounds = true
        return inputsView
    }()
    
    lazy var loginRegisterButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 242/255, green: 159/255, blue: 141/255, alpha: 1)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Регистрация", for: .normal)
       button.addTarget(self, action: #selector(regiterOrLogin), for: .touchUpInside)
        
        return button
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Есім"
        //tf.attributedPlaceholder =
        tf.translatesAutoresizingMaskIntoConstraints = false
        //tf.backgroundColor = UIColor.red
        return tf
    }()
    
    lazy var nameSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        //tf.backgroundColor = UIColor.red
        return tf
    }()
    
    lazy var emailSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Пароль"
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        //tf.backgroundColor = UIColor.red
        return tf
    }()
    
    lazy var passwordSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.gray
        return view
    }()

    func regiterOrLogin(){
        if loginRegisterSegmentControl.selectedSegmentIndex == 0{
            signIn(with: emailTextField.text, password: passwordTextField.text)
        }
        else{
            signUp(with: nameTextField.text, email: emailTextField.text, password: passwordTextField.text)
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func handleLoginRegisterChange(){
        let title = loginRegisterSegmentControl.titleForSegment(at: loginRegisterSegmentControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //Change height of inputContainerView
        let height: CGFloat = loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 133 : 200
        inputsContainerView <- [
            Height(height)
        ]
    }

}
