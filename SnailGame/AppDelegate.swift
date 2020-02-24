//
//  AppDelegate.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , WelcomePushDelegate {

    var window: UIWindow?

    var mainVC: BaseTabBarController?
    
    var blockRotation = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        UMConfigure.initWithAppkey("5dfb23e4cb23d211390000ce", channel: nil)
        configUSharePlatforms()
        ArkDwnWallet.arkWalletConfig()
        setRootView()
        return true
    }
    
    func configUSharePlatforms() {
        UMSocialManager.default()?.setPlaform(.wechatSession, appKey: "wx5a6e8e88c871beda", appSecret: "410e3d74fef2a20e6fd82ebbb26c4b87", redirectURL: BASE_HOST)
        UMSocialManager.default()?.setPlaform(.wechatTimeLine, appKey: "wx5a6e8e88c871beda", appSecret: "410e3d74fef2a20e6fd82ebbb26c4b87", redirectURL: BASE_HOST)
    }
    
    func setRootView() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let welcomeVC = WelcomeViewController.init()
        welcomeVC.welcomeDelegate = self
        window?.rootViewController = welcomeVC
        window?.makeKeyAndVisible()
    }
    
    func welcomePushAction() {
        mainVC = BaseTabBarController.init()
        window?.rootViewController = mainVC
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result:Bool = (UMSocialManager.default()?.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation))!
        if !result {
            
        }
        return result
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let result:Bool = (UMSocialManager.default()?.handleOpen(url, options: options))!
        if !result {
            
        }
        return result
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation {
            return .landscapeRight
        }
        return .portrait
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let viewController = currentViewController()
        BusinessEngine.init().update(successResponse: { (baseModel) in
            let versionModel = baseModel as! VersionModel
            if versionModel.data?.prompt != 0 && versionModel.data?.is_update != 0 {
                if versionModel.data?.force != 0 {
                    DispatchQueue.main.async {
                        showAlert(currentVC: viewController, title: "更新提示", meg: versionModel.data!.message!, sure: "更新") { (action) in
                            UIApplication.shared.open(URL.init(string: versionModel.data!.address!)!, options: [:], completionHandler: nil)
                        }
                    }
                } else {
                   DispatchQueue.main.async {
                        showAlert(currentVC: viewController, title: "更新提示", meg: versionModel.data!.message!, cancel: "取消", sure: "更新", cancelHandler: { (action) in

                        }) { (action) in
                            UIApplication.shared.open(URL.init(string: versionModel.data!.address!)!, options: [:], completionHandler: nil)
                        }
                    }
                }
            }
        }) { (baseModel) in
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

