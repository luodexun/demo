//
//  BaseTabBarController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController , UITabBarControllerDelegate {

    var naviArray = NSMutableArray.init()
    
    var mTabBar : BaseTabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.tabBar.isOpaque = false
        self.tabBar.barTintColor = colorWithHex(hex: 0xffffff)
        self.tabBar.tintColor = colorWithHex(hex: 0x0077ff)
        mTabBar = BaseTabBar.init(frame: CGRect.zero)
        self.setValue(mTabBar, forKey: "tabBar")
        
        self.delegate = self
        UITabBar.appearance().isTranslucent = false
        
        initSubViews();
        
        initAllTabBarButtons()
    
    }
    
    func initSubViews() {
        //首页
        let homeVC = HomeViewController.init()
        let homeNavi = BaseNavigationController.init(rootViewController: homeVC)
        self.addChild(homeNavi)
        naviArray.add(homeNavi)
        //资讯
        let infoVC = InfoViewController.init()
        let infoNavi = BaseNavigationController.init(rootViewController: infoVC)
        self.addChild(infoNavi)
        naviArray.add(infoNavi)
        //行情
        let marketVC = MarketViewController.init()
        let marketNavi = BaseNavigationController.init(rootViewController: marketVC)
        self.addChild(marketNavi)
        naviArray.add(marketNavi)
        //游戏
        let findVC = FindViewController.init()
        let findNavi = BaseNavigationController.init(rootViewController: findVC)
        self.addChild(findNavi)
        naviArray.add(findNavi)
        //我的
        let mineVC = MineViewController.init()
        let mineNavi = BaseNavigationController.init(rootViewController: mineVC)
        self.addChild(mineNavi)
        naviArray.add(mineNavi)
    }
    
    func initAllTabBarButtons() {
        let homeNavi:BaseNavigationController = naviArray[0] as! BaseNavigationController
        homeNavi.tabBarItem.title = "首页"
        homeNavi.tabBarItem.image = UIImage.init(named: "ic_tab_home_nol")
        homeNavi.tabBarItem.selectedImage = UIImage.init(named: "ic_tab_home_sel")
        
        let infoNavi:BaseNavigationController = naviArray[1] as! BaseNavigationController
        infoNavi.tabBarItem.title = "资讯"
        infoNavi.tabBarItem.image = UIImage.init(named: "ic_tab_info_nol")
        infoNavi.tabBarItem.selectedImage = UIImage.init(named: "ic_tab_info_sel")
        
        let marketNavi:BaseNavigationController = naviArray[2] as! BaseNavigationController
        marketNavi.tabBarItem.title = "行情"
        marketNavi.tabBarItem.image = UIImage.init(named: "ic_tab_market_nol")
        marketNavi.tabBarItem.selectedImage = UIImage.init(named: "ic_tab_market_sel")
        
        let findNavi:BaseNavigationController = naviArray[3] as! BaseNavigationController
        findNavi.tabBarItem.title = ""
        findNavi.tabBarItem.image = UIImage.init()
        findNavi.tabBarItem.selectedImage = UIImage.init(named: "ic_tab_game_sel")
        
        let mineNavi:BaseNavigationController = naviArray[4] as! BaseNavigationController
        mineNavi.tabBarItem.title = "我的"
        mineNavi.tabBarItem.image = UIImage.init(named: "ic_tab_mine_nol")
        mineNavi.tabBarItem.selectedImage = UIImage.init(named: "ic_tab_mine_sel")
    }
    
    func showTabBarBudge() {
        if isLogin() {
            let noticeNum = BusinessEngine.init().getLoginUserModel().notice_num!
            if noticeNum > 0 {
                mTabBar?.budgeView?.isHidden = false
            } else {
                mTabBar?.budgeView?.isHidden = true
            }
        } else {
            mTabBar?.budgeView?.isHidden = true
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let findNavi:BaseNavigationController = naviArray[3] as! BaseNavigationController
        if tabBarController.selectedIndex == 3 {
            findNavi.tabBarItem.title = "发现"
            mTabBar?.hongBarView?.isHidden = true
        } else {
            findNavi.tabBarItem.title = ""
            mTabBar?.hongBarView?.isHidden = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
