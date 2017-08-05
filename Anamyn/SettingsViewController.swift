//
//  SettingsViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/24/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

//
//  Item1ViewController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/18/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import EasyPeasy
import MessageUI
import MGInstagram
import FirebaseAuth
import FBSDKShareKit

class SettingsViewController: UIViewController {
    
    var instagram = MGInstagram()
    
    //var imagesArray = [UIImageView(image: #imageLiteral(resourceName: "icon1")),UIImageView(image: #imageLiteral(resourceName: "icon2")),UIImageView(image: #imageLiteral(resourceName: "icon3")),UIImageView(image: #imageLiteral(resourceName: "icon4"))]
    var imagesArray = [UIImage(named: "icon1.png"),UIImage(named: "icon2.png")]
    var imagesArray2 = [UIImage(named: "icon3.png"),UIImage(named: "icon4.png")]
    var imagesArray3 = [UIImage(named: "icon5.png"),UIImage(named: "icon6.png")]
    
    var nameArray = ["App Store - да рейтинг қою", "Байланыс"]
    var nameArray2 = ["Instagram", "Facebook"]
    var nameArray3 = ["Мои данные","Сброс и выход"]
    var headerNames = ["ҚОСЫМША ТУРАЛЫ","ДОСТАРМЕН БӨЛІС","МЕН"]
    
    var rightBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        setupViews()
        setupConstraints()
        
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
        //view.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        //tableView.backgroundColor = UIColor(white: 1, alpha: 0.2)
    
//        rightBarButtonItem = UIBarButtonItem(title: "Шығу", style: .plain, target: self, action: #selector(signOut))
////        buttonExit.tintColor = UIColor.white
//        navigationItem.rightBarButtonItem = rightBarButtonItem
//        
        
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCellId")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private func  setupViews(){
        view.addSubview(tableView)
    }
    private func  setupConstraints(){
        tableView <- [
            Top(0),
            Left(0),
            Right(0),
            Bottom(0)
        ]
    }
    
    func addRate(){
        let appID = "(Your App ID on App Store)"
        //let urlStr = "itms-apps://itunes.apple.com/app/id\(appID)" // (Option 1) Open App Page
        let urlStr = "itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=\(appID)" // (Option 2) Open App Review Tab
        //UIApplication.sharedApplication().openURL(NSURL(string: urlStr)!)
        print("Rating")
    }
    
    func sendMail(){
        let composer = MFMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            composer.mailComposeDelegate = self
            composer.setToRecipients(["zhansaya.sikhymbekova@ce.sdu.edu.kz"])
            composer.setSubject("Anamyn")
            composer.setMessageBody("", isHTML: false)
            present(composer, animated: true, completion: nil)
        }
    }
    
    func shareOnInstagram(){
        var image = UIImage(named: "nick.jpg")
        if MGInstagram.isAppInstalled() && MGInstagram.isImageCorrectSize(image){
            self.instagram.post(image, in: self.view)
        }
        else {
            NSLog("Error Instagram is either not installed or image is incorrect size");
        }
    }
    
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("exit")
            (UIApplication.shared.delegate as? AppDelegate)?.loadLogin()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func shareOnFacebook(){
//        var content = FBSDKShareLinkContent()
//        content.contentURL = URL(string: "https://developers.facebook.com")
        
        let image: UIImage? = #imageLiteral(resourceName: "nick")
        let photo = FBSDKSharePhoto()
        photo.image = image
        photo.isUserGenerated = true
        let content = FBSDKSharePhotoContent()
        content.photos = [photo]
        
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = .shareSheet
        dialog.show()
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCellId", for: indexPath) as! SettingsTableViewCell
        cell.line.backgroundColor = indexPath.row == 0 ? self.tableView.separatorColor : .white
        if indexPath.section == 0{
            cell.iconImage.image = imagesArray[indexPath.row]
            cell.nameLabel.text = nameArray[indexPath.row]
        }else if indexPath.section == 1{
            cell.iconImage.image = imagesArray2[indexPath.row]
            cell.nameLabel.text = nameArray2[indexPath.row]
        }
        else if indexPath.section == 2{
            cell.iconImage.image = imagesArray3[indexPath.row]
            cell.nameLabel.text = nameArray3[indexPath.row]
        }
        cell.backgroundColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 52.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let px = 1 / UIScreen.main.scale
        return px
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: px)
        let line = UIView(frame: frame)
        line.backgroundColor = self.tableView.separatorColor
        return line
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x: 9, y: 30, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        //headerLabel.font = UIFont(name: "Lucina Grande", size: 5)
        headerLabel.font = headerLabel.font.withSize(12)
        headerLabel.textColor = UIColor.gray
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        
        let px = 1 / UIScreen.main.scale
        let height: CGFloat = 50
        let frame = CGRect(x: 0, y: height - px, width: UIScreen.main.bounds.width, height: px)
        let line = UIView(frame: frame)
        line.backgroundColor = self.tableView.separatorColor
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        headerView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
        headerView.addSubview(headerLabel)
        headerView.addSubview(line)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0 && indexPath.section == 0){
            addRate()
        }
        if (indexPath.row == 1 && indexPath.section == 0){
            sendMail()
        }
        if (indexPath.row == 0 && indexPath.section == 1){
            shareOnInstagram()
        }
        if (indexPath.row == 1 && indexPath.section == 1){
            shareOnFacebook()
        }
        if (indexPath.row == 1 && indexPath.section == 2){
            signOut()
        }

    }
    

    
}

extension SettingsViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
