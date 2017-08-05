//
//  CustomTabBarController.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/18/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        //self.tabBar.selectedItem?.badgeColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        let item1 = UINavigationController(rootViewController: TableViewController())
        let icon1 = UITabBarItem(title: "Bala", image: UIImage(named: "baby1.png"), selectedImage: UIImage(named: "baby2.png"))
         item1.tabBarItem = icon1
        
        let itemMore = UINavigationController(rootViewController: MoreViewController())
        let iconMore = UITabBarItem(title: "Еще", image:  UIImage(named: "more.png"), selectedImage:  UIImage(named: "more2.png"))
        itemMore.tabBarItem = iconMore
        
        let itemAsk = UINavigationController(rootViewController: QuestionViewController())
        let iconAsk = UITabBarItem(title: "Сурақ", image:  UIImage(named: "ask.png"), selectedImage:  UIImage(named: "ask2.png"))
        itemAsk.tabBarItem = iconAsk
        
        let itemSettings = UINavigationController(rootViewController: SettingsViewController())
        let iconSettings = UITabBarItem(title: "Настройки", image:  UIImage(named: "settings.png"), selectedImage:  UIImage(named: "settings2.png"))
        itemSettings.tabBarItem = iconSettings
        
        let controllers = [item1,itemMore,itemAsk,itemSettings]
        self.viewControllers = controllers
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}
