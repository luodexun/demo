//
//  MineCandyViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineCandyViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mineCandyCV : MineCandyCollectionView?
    
    var configModel : ConfigModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMineCandyCollectionView()
        initTitleView()
        getCandyValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         mineCandyCV?.candy = BusinessEngine.init().getLoginUserModel().candy
         mineCandyCV?.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initMineCandyCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        mineCandyCV = MineCandyCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        self.view.addSubview(mineCandyCV!)
        
        mineCandyCV!.mineCandyHandel = { (currentIndex) in
            if currentIndex == 0 {
                let sessionStr : String = UserDefaults.standard.object(forKey:SESSION) as! String
                let gameDetailVC = GameDetailViewController.init()
                gameDetailVC.across = 0
                gameDetailVC.gameName = self.configModel!.LuckDraw!.name
                gameDetailVC.app_id = self.configModel!.LuckDraw!.app_id
                gameDetailVC.loadUrl = self.configModel!.LuckDraw!.address! + "&session=" + sessionStr + "&b=" + self.configModel!.LuckDraw!.app_id!
                gameDetailVC.gameIcon = self.configModel!.LuckDraw!.icon
                gameDetailVC.gameDetails = self.configModel!.LuckDraw!.details
                gameDetailVC.gameDesc = self.configModel!.LuckDraw!.desc
                self.navigationController?.pushViewController(gameDetailVC, animated: true)
                
            } else if currentIndex == 1 {
                let temp:BaseNavigationController = super.tabBarController?.viewControllers![1] as! BaseNavigationController
                let infoVC : InfoViewController = temp.topViewController as! InfoViewController
                infoVC.currentTag = 2
                self.tabBarController?.selectedIndex = 1
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                let exchangeVC = CandyExchangeViewController.init()
                self.navigationController?.pushViewController(exchangeVC, animated: true)
            }
        }
    }
    
    func initTitleView() {
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 60, y: STABAR_HEIGHT, width: SCREEN_WIDE-120, height: 44));
        titleNameLbl.textColor = UIColor.white;
        titleNameLbl.font = UIFont.systemFont(ofSize: 17);
        titleNameLbl.text = "蜗牛糖果";
        titleNameLbl.textAlignment = NSTextAlignment.center;
        self.view.addSubview(titleNameLbl);
        
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT, width: 44, height: 44));
        backBtn.setImage(UIImage.init(named: "ic_back_white"), for: UIControl.State.normal);
        backBtn.addTarget(self, action: #selector(candyBackAction), for: UIControl.Event.touchUpInside);
        self.view.addSubview(backBtn);
        
        let rightBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        rightBtn.frame = CGRect.init(x: SCREEN_WIDE-100*PROSIZE, y: STABAR_HEIGHT, width: 80*PROSIZE, height: 44)
        rightBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rightBtn.setTitleColor( UIColor.white, for: UIControl.State.normal)
        rightBtn.setTitle("变动记录", for: UIControl.State.normal)
        rightBtn.addTarget(self, action: #selector(pushRecordAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(rightBtn)
    }
    
    func getCandyValues() {
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        configModel = ConfigModel.deserialize(from: str)
        mineCandyCV?.activeList = configModel!.candy_active! as NSArray
        mineCandyCV?.reloadData()
    }
    
    @objc func candyBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushRecordAction() {
        let candyRecordVC = CandyRecordViewController.init()
        self.navigationController?.pushViewController(candyRecordVC, animated: true)
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
