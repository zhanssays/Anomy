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

final class QuestionViewController: UIViewController, UITableViewDataSource {
    
    fileprivate var posts = [Post]()
     var rightBarButtonItem: UIBarButtonItem?

    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: QuestionTableViewCell.self)
            $0.dataSource = self
            $0.rowHeight = 60
            $0.estimatedRowHeight = 44
            $0.tableFooterView = UIView()
            $0.separatorStyle = .singleLine
            $0.allowsSelection = true
            $0.delegate = self
            
        }
    }()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        loadData()
        
        rightBarButtonItem = UIBarButtonItem(title: "Жазу", style: .plain, target: self, action: #selector(askQuestion))
        rightBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: Data
    
    fileprivate func loadData() {
        SVProgressHUD.show()
        Post.fetchPosts { post in
            SVProgressHUD.dismiss()
            guard let post = post else { return }
            self.posts.append(post)
            self.tableView.reloadData()
        }
    }
    
    // TODO: remove this lines
    //        Post.addPost(with: "Testing post") { error in
    //            if let error = error {
    //                SVProgressHUD.showError(withStatus: error.localizedDescription)
    //            }
    //        }
    //        Post().addComment(with: "Testing comment", to: "-KqCL2J51--voaoGZDYN") { error in
    //            if let error = error {
    //                SVProgressHUD.showError(withStatus: error.localizedDescription)
    //            }
    //        }
//    Post.fetchPosts { post in
//    guard let post = post else { return }
//
//    print(post.toJSONString(prettyPrint: true))
//    post.fetchComments(handler: { comment in
//    print(comment?.toJSONString(prettyPrint: true))
//    })
//    }

    // MARK: Configurations

    fileprivate func configureViews() {
        edgesForExtendedLayout = UIRectEdge()
        navigationItem.title = "Сұрақтар"
        view.backgroundColor = .white
        view.addSubviews(tableView)
    }

    fileprivate func configureConstraints() {
        tableView <- Edges()
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as QuestionTableViewCell
        let post = posts[indexPath.row]
        cell.questionLabel.text = post.text
        
        //if let date = post.createdAt { cell.questionLabel.text = String(describing: date) }
        //cell.questionLabel.textAlignment = .center
//        cell.commentsButton.tap { _ in
//            let vc = CommentViewController()
//            vc.post = post
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
        return cell
    }
    
//    @objc(tableView:didDeselectRowAtIndexPath:) func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: NSIndexPath) {
//        let cell = tableView.dequeueReusableCell(for: indexPath as IndexPath) as QuestionTableViewCell
//        let post = posts[indexPath.row]
//        let vc = CommentViewController()
//        vc.post = post
//        self.navigationController?.pushViewController(vc, animated: true)
//        print(indexPath.row)
//        
//    }
    
    
    func askQuestion(){
        let vc = NewQuestionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension QuestionViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(for: indexPath as IndexPath) as QuestionTableViewCell
        let post = posts[indexPath.row]
        let vc = CommentViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.post = post
        self.navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)

    }
}
