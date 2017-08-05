//
//  CommentViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/29/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//


//
//  QuestionViewController.swift
//  karaoke
//
//  Created by Nurdaulet Bolatov on 7/29/17.
//  Copyright © 2017 Otel Danagul. All rights reserved.
//

import UIKit
import Sugar
import Tactile
import EasyPeasy
import SVProgressHUD
import DateToolsSwift
import ALTextInputBar

final class CommentViewController: UIViewController, UITableViewDataSource, UITextViewDelegate {
    
    var post: Post!
    fileprivate var comments = [Comment]()
    
    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: QuestionTableViewCell.self)
            $0.register(cellType: CommentTableViewCell.self)
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 100
            $0.tableFooterView = UIView()
            $0.separatorStyle = .none
            $0.allowsSelection = false
            $0.separatorStyle = .singleLine
            $0.backgroundColor = .white
            
        }
    }()
    
    let keyboardObserver = ALKeyboardObservingView()
    
    let textInputBar = ALTextInputBar()
    
    lazy var sendButton: UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        return button
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTextInput()
//        configureConstraints()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged(notification:)), name: NSNotification.Name(rawValue: ALKeyboardFrameDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
        textInputBar.frame.size.width = view.bounds.size.width
    }
    
    // MARK: Data
    
    fileprivate func loadData() {
        post.fetchComments { comment in
            guard let comment = comment else { return }
            self.comments.append(comment)
            self.tableView.reloadData()
        }
    }
    
    // MARK: Configurations
    
    fileprivate func configureTextInput() {
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        rightButton.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        rightButton.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        keyboardObserver.isUserInteractionEnabled = false
        textInputBar.showTextViewBorder = true
        textInputBar.rightView = rightButton
        textInputBar.frame = CGRect(x: 0, y: self.view.frame.size.height - textInputBar.defaultHeight, width: self.view.frame.size.width, height: 50)
        textInputBar.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textInputBar.keyboardObserver = keyboardObserver
        view.addSubview(textInputBar)
    }
    
    fileprivate func configureViews() {
//        edgesForExtendedLayout = UIRectEdge()
        navigationItem.title = "Surak"
        view.backgroundColor = .white
        view.addSubviews(tableView)
        
        view.tap { _ in
            self.view.endEditing(true)
        }
        
        //view.addSubview(scrollView)
        
        //scrollView.addSubview(tableView)
        //scrollView.contentSize = tableView.bounds.size
        //scrollView.keyboardDismissMode = .interactive
        //scrollView.backgroundColor = UIColor(white: 0.6, alpha: 1)
    }
    
    fileprivate func configureConstraints() {
        tableView <- Edges()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : comments.count
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as QuestionTableViewCell
            cell.questionLabel.text = post.text
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CommentTableViewCell
            let comment = comments[indexPath.row]
            cell.commentLabel.text = comment.text
            comment.fetchAuthorName(completion: { name in
                cell.usernameLabel.text = name
            })
            cell.dateLabel.text = comment.createdAt?.timeAgoSinceNow
            return cell
        }
        
    }
    
    func sendComment(){
        if (!textInputBar.text.isEmpty){
            post.addComment(with: textInputBar.text, completion: { error in
                if let error = error {
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                }
            })
        textInputBar.text = ""
            
            
        }
    }
    

    
    override var inputAccessoryView: UIView? {
        get {
            return keyboardObserver
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func keyboardFrameChanged(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
}
