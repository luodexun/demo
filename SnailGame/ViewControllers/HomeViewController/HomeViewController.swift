//
//  HomeViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController ,collectionRefreshDelegate , HomeScrollDelegate {

    var homeCV : HomeCollectionView?

    var userModel : UserLoginDataModel?
    
    var hotNews = NSArray.init()
    
    var monthModel : InfoDataModel?
    
    var boxDialog : DropBoxDialog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHomeCollectionView()
        initNaviView(bgColor: colorWithHex(hex: 0xE9441F))
        initNaviTitle(titleStr: "大蜗牛社区", titleColor: UIColor.white)
        naviView?.alpha = 0.0
        if isLogin() {
            showLoading(view: self.view)
            getUserInfo()
            showNoticeDialog()
        }
        getUpdateInfo()
        getAppBanner()
        getHotNews()
        if homeCV?.isService == 1 {
            recommentGame()
        }
        getWikipeList()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLogin() {
            self.userModel = BusinessEngine.init().getLoginUserModel()
            let walletAmount = BusinessEngine.init().getLinkWalletBalance()
            self.view.hideToastActivity()
            updateTreasureInfo(walletAmount: walletAmount)
        }
        else {
            if boxDialog != nil {
                boxDialog?.close()
            }
            self.view.hideToastActivity()
            self.homeCV!.isShow = false
            self.homeCV?.reloadItems(at: [IndexPath.init(item: 0, section: 0)])
        }
        self.homeCV?.mj_header?.endRefreshing()
        let mainVC:BaseTabBarController = self.tabBarController as! BaseTabBarController
        mainVC.showTabBarBudge()
    }
    
    func initHomeCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        homeCV = HomeCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT-50-SAFE_BOTTOM), collectionViewLayout: layout)
        if UserDefaults.standard.object(forKey: PASS) != nil {
            homeCV?.isService = UserDefaults.standard.object(forKey: PASS) as! Int
        }
        homeCV?.scrollDelegate = self
        homeCV?.setRefreshEnable()
        homeCV?.refreshDelegate = self
        self.view.addSubview(homeCV!)
        
        homeCV?.homeWealthPushHandel = {(opera) in
            if judgeLoginAndPush() {
                switch opera {
                case 1:
                    let wealthVC = WealthViewController.init()
                    self.navigationController?.pushViewController(wealthVC, animated: true)
                    break
                case 2:
                    let walletVC = WalletDetailViewController.init()
                    self.navigationController?.pushViewController(walletVC, animated: true)
                    break
                case 3:
                    let communityVC = CommunityWealthViewController.init()
                    self.navigationController?.pushViewController(communityVC, animated: true)
                    break
                case 4:
                    if self.monthModel != nil {
                        let detailVC = InfoDetailViewController.init()
                        detailVC.pushType = 1
                        detailVC.infoModel = self.monthModel
                        self.navigationController?.pushViewController(detailVC, animated: true)
                    }
                    break
                default:
                    break
                }
            }
        }
        
        homeCV?.homeBannerSelectHandel = {(dataModel) in
            showLoading(view: self.view)
            if dataModel.cate == 1 {
                self.getInfoList(linkId: dataModel.link_id!)
            } else if dataModel.cate == 2 || dataModel.cate == 3 {
                if judgeLoginAndPush() {
                    self.getGameList(linkId: dataModel.link_id!)
                }
            }
        }
        
        homeCV?.homeTaskPushHandel = {(opera) in
            if judgeLoginAndPush() {
                switch opera {
                case 1:
                    let dailyClockVC = DailyClockViewController.init()
                    self.navigationController?.pushViewController(dailyClockVC, animated: true)
                    break
                case 2:
                    let promotionVC = PromotionViewController.init()
                    self.navigationController?.pushViewController(promotionVC, animated: true)
                    break
                case 3:
                    let taskRewardVC = TaskRewardViewController.init()
                    self.navigationController?.pushViewController(taskRewardVC, animated: true)
                    break
                case 4:
                    let promotionShareVC = PromotionShareViewController.init()
                    promotionShareVC.modalPresentationStyle = .fullScreen
                    promotionShareVC.pushType = 2
                    self.present(promotionShareVC, animated: true, completion: nil)
                    break
                default:
                    break
                }
            }
        }
        
        homeCV!.homeBannerHandel = {(index) in
            let infoModel = self.hotNews[index]
            let detailVC = InfoDetailViewController.init()
            detailVC.pushType = 1
            detailVC.infoModel = (infoModel as! InfoDataModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        homeCV!.homeWikipeHandel = {(dataModel) in
            let detailVC = InfoDetailViewController.init()
            detailVC.pushType = 1
            detailVC.infoModel = dataModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        homeCV!.homeGameHandel = {(detailModel) in
            if judgeLoginAndPush() {
                showLoading(view: self.view)
                self.getGameList(linkId: detailModel.id!)
            }
        }
        
        homeCV!.homeGameMoreHandel = {(_) in
            let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            delegate.mainVC!.mTabBar?.hongBarView?.isHidden = true
            let findNavi:BaseNavigationController = delegate.mainVC!.naviArray[3] as! BaseNavigationController
            findNavi.tabBarItem.title = "发现"
            self.tabBarController?.selectedIndex = 3
        }
    }

    func showNoticeDialog() {
        BusinessEngine.init().noticePush(successResponse: { (baseModel) in
            let noticeModel = baseModel as! NoticePushModel
            if noticeModel.data != nil {
                showAlert(currentVC: self, title: "重要消息", meg: noticeModel.data!.title!, cancel: "取消", sure: "查看", cancelHandler: { (action) in
                }) { (action) in
                    let noticeDetailVC = NoticeDetailViewController.init()
                    noticeDetailVC.pushType = 1
                    noticeDetailVC.noticeId = noticeModel.data!.id!
                    self.navigationController?.pushViewController(noticeDetailVC, animated: true)
                }
            }
        }) { (baseModel) in
        }
    }
    
    func showDropDialog() {
        if boxDialog == nil {
            boxDialog = DropBoxDialog.init(frame: CGRect.init(x: SCREEN_WIDE-88*PROSIZE, y: -87*PROSIZE, width: 72*PROSIZE, height: 87*PROSIZE))
            self.view.addSubview(boxDialog!)
            boxDialog!.dropBoxHandel = {
                let luckyDropVC = LuckyDropViewController.init()
                self.navigationController?.pushViewController(luckyDropVC, animated: true)
            }
        }
        boxDialog!.show()
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        if judgeLoginAndPush() {
            showLoading(view: self.view)
            getUserInfo()
            showNoticeDialog()
        } else {
            homeCV?.mj_header?.endRefreshing()
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            let loginModel = BaseModel as! UserLoginModel
            self.userModel = loginModel.data
            self.updateLinkWallet(walletAddress: loginModel.data!.wallet_address!)
            let mainVC:BaseTabBarController = self.tabBarController as! BaseTabBarController
            mainVC.showTabBarBudge()
        }) { (BaseModel) in
            self.homeCV?.mj_header!.endRefreshing()
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func updateLinkWallet(walletAddress:String) {
        BusinessEngine.init().updateLinkWallet(walletAddress: walletAddress, successResponse: { (BaseModel) in
            self.homeCV?.mj_header!.endRefreshing()
            self.view.hideToastActivity()
            let walletModel : WalletModel = BaseModel as! WalletModel
            var balance = "0"
            if walletModel.data != nil {
                balance = walletModel.data!.balance!
            }
            self.updateTreasureInfo(walletAmount: balance)
        }) { (BaseModel) in
            let walletAmount = BusinessEngine.init().getLinkWalletBalance()
            self.updateTreasureInfo(walletAmount: walletAmount)
            self.homeCV?.mj_header!.endRefreshing()
            self.view.hideToastActivity()
        }
    }
    
    func updateTreasureInfo(walletAmount:String) {
        if self.userModel?.air_drop != 0 {
            showDropDialog()
        } else {
            if boxDialog != nil {
                boxDialog?.close()
            }
        }
        
        let totalToken = calculateAJiaB(a: calculateAJiaB(a: walletAmount, b: self.userModel!.token!), b: self.userModel!.freeze!)
            
        let ratio = calculateAChuyiB(a: self.userModel!.ratio!, b: TOKEN_RATIO)
        
        let totalDwn = calculateAChuyiB(a: totalToken, b: TOKEN_RATIO)
        
        let totalRmb = calculateAChengyiB(a: totalDwn, b: ratio)
        
        self.homeCV!.totalDwn = KeepSomeDecimal(num: totalDwn, decimal: 2)
        
         self.homeCV!.totalRmb = KeepSomeDecimal(num: totalRmb, decimal: 2)
        
        self.homeCV?.reloadItems(at: [IndexPath.init(item: 0, section: 0)])
    }

    func getAppBanner() {
        BusinessEngine.init().appBanner(key: "", value: "", pageNum: "1", type: "1", successResponse: { (BaseModel) in
            let bannerModel : BannerModel = BaseModel as! BannerModel
            self.homeCV?.bannerList = NSMutableArray.init(array: bannerModel.data!)
            self.homeCV?.reloadItems(at: [IndexPath.init(item: 1, section: 0)])
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getHotNews() {
        BusinessEngine.init().getInfoList(pageNum: "1", sort: "create_time", linkId: "", successResponse: { (BaseModel) in
            let infoModel : InfoListModel = BaseModel as! InfoListModel
            var count = infoModel.data?.count
            if count! > 5 {
                count = 5
            }
            let titles = NSMutableArray.init()
            for (i,item) in (infoModel.data?.enumerated())! {
                let itemModel:InfoDataModel = item
                if i < count! {
                    titles.add(itemModel.title as Any)
                }
            }
            self.hotNews = infoModel.data! as NSArray
            self.homeCV!.hotNews = titles
            self.homeCV?.reloadItems(at: [IndexPath.init(item: 3, section: 0)])
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func recommentGame() {
        BusinessEngine.init().recommentGame(successResponse: { (baseModel) in
            let gameModel = baseModel as! RecommentGameModel
            self.homeCV!.gameTitle = gameModel.data?.name
            self.homeCV!.gameBanners = (gameModel.data?.banner! as NSArray?)!
            self.homeCV?.gameList = (gameModel.data?.app_list! as NSArray?)!
            self.homeCV?.reloadItems(at: [IndexPath.init(item: 2, section: 0)])
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getWikipeList() {
        BusinessEngine.init().getWikipeList(successResponse: { (BaseModel) in
            let infoModel : InfoListModel = BaseModel as! InfoListModel
            if infoModel.data!.count > 0 {
                self.monthModel = infoModel.data![0]
            }
            self.homeCV!.wikipeList = infoModel.data! as NSArray
            self.homeCV?.reloadItems(at: [IndexPath.init(item: 5, section: 0)])
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getInfoList(linkId:String) {
        BusinessEngine.init().getInfoList(pageNum: "1", sort: "create_time", linkId: linkId, successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let infoModel : InfoListModel = baseModel as! InfoListModel
            if infoModel.data?.count != 0 {
                let dataModel = infoModel.data?[0]
                let detailVC = InfoDetailViewController.init()
                detailVC.pushType = 1
                detailVC.infoModel = dataModel
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }) { (baseModel) in
            self.view.hideToastActivity()
        }
    }
    
    func getGameList(linkId:String) {
        BusinessEngine.init().getGameList(pageNum: "1", key: "desc", value: "id",type:"", linkId: linkId, successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let gameModel:GameListModel = baseModel as! GameListModel
            if gameModel.data?.count != 0 {
                let model:GameDataModel = (gameModel.data?[0])!
                if model.app_id == "7hG9Q8v4" {
                    let timeStamp = UserDefaults.standard.object(forKey: AUTHORY_DATE)
                    if timeStamp != nil {
                        let timeInterval: TimeInterval = NSDate.init().timeIntervalSince1970
                        let nowStamp = Int(timeInterval)
                        let less = nowStamp - (timeStamp as! Int)
                        if less / 3600 / 24 > 7 {
                            let authoryThirdVC = AuthoryThirdViewController.init()
                            authoryThirdVC.detailModel = model
                            authoryThirdVC.modalPresentationStyle = .fullScreen
                            self.present(authoryThirdVC, animated: true, completion: nil)
                        } else {
                            let url:URL? = URL.init(string: model.address!)
                            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                        }
                    } else {
                        let authoryThirdVC = AuthoryThirdViewController.init()
                        authoryThirdVC.detailModel = model
                        authoryThirdVC.modalPresentationStyle = .fullScreen
                        self.present(authoryThirdVC, animated: true, completion: nil)
                    }
                } else {
                    let sessionStr : String = UserDefaults.standard.object(forKey:SESSION) as! String
                    let gameDetailVC = GameDetailViewController.init()
                    gameDetailVC.across = model.across!
                    gameDetailVC.gameName = model.name
                    gameDetailVC.app_id = model.app_id
                    gameDetailVC.gameDetails = model.details
                    gameDetailVC.gameIcon = model.icon
                    gameDetailVC.gameDesc = model.desc
                    if model.cate == 2 {
                        gameDetailVC.loadUrl = model.address! + "&session=" + sessionStr + "&b=" + model.app_id!
                    } else {
                        gameDetailVC.loadUrl = model.address! + "?session=" + sessionStr + "&b=" + model.app_id!
                    }
                    self.navigationController?.pushViewController(gameDetailVC, animated: true)
                }
            }
        }) { (baseModel) in
            self.view.hideToastActivity()
        }
    }
    
    func getUpdateInfo() {
        BusinessEngine.init().update(successResponse: { (baseModel) in
            let versionModel = baseModel as! VersionModel
            if versionModel.data?.prompt != 0 && versionModel.data?.is_update != 0 {
                if versionModel.data?.force != 0 {
                    DispatchQueue.main.async {
                        showAlert(currentVC: self, title: "更新提示", meg: versionModel.data!.message!, sure: "更新") { (action) in
                            UIApplication.shared.open(URL.init(string: versionModel.data!.address!)!, options: [:], completionHandler: nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        showAlert(currentVC: self, title: "更新提示", meg: versionModel.data!.message!, cancel: "取消", sure: "更新", cancelHandler: { (action) in
                    
                        }) { (action) in
                            UIApplication.shared.open(URL.init(string: versionModel.data!.address!)!, options: [:], completionHandler: nil)
                        }
                    }
                }
            } else {
              
            }
        }) { (baseModel) in
        }
    }
    
    func homeScrollDidScrl(scrol_y: CGFloat) {
        if scrol_y/150 <= 1 {
            naviView?.alpha = scrol_y/150
        } else {
            naviView?.alpha = 1.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let cell = homeCV?.cellForItem(at: NSIndexPath.init(item: 1, section: 0) as IndexPath)
        if cell != nil {
            let currentCell:HomeCarouselCell = cell as! HomeCarouselCell
            currentCell.carousel?.controllerWillDisAppear()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cell = homeCV?.cellForItem(at: NSIndexPath.init(item: 1, section: 0) as IndexPath)
        if cell != nil {
            let currentCell:HomeCarouselCell = cell as! HomeCarouselCell
            currentCell.carousel?.controllerWillAppear()
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
