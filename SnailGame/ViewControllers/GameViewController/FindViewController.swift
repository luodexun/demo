//
//  FindViewController.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class FindViewController: BaseViewController , collectionRefreshDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var findCV : FindCollectionView?
    
    var gameCV : GameCollectionView?
    
    var isPass = 0
    
    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x0077FF))
        initNaviTitle(titleStr: "发现", titleColor: colorWithHex(hex: 0xffffff))
        if UserDefaults.standard.object(forKey: PASS) != nil {
            isPass = UserDefaults.standard.object(forKey: PASS) as! Int
        }
        initFindCollectionView()
        showLoading(view: self.view)
        getFindList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isLogin() {
            getGameRecord()
        } else {
            isFirst = false
            findCV?.records = NSArray.init()
            findCV?.reloadItems(at: [IndexPath.init(row: 0, section: 0)])
        }
    }
    
    func initFindCollectionView(){
        
        let layout = UICollectionViewFlowLayout.init()
        findCV = FindCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-SAFE_BOTTOM-94), collectionViewLayout: layout)
        findCV?.refreshDelegate = self
        self.view.addSubview(findCV!)
        
        findCV!.findMoreHandel = { (section) in
            let gameListVC = GameListViewController.init()
            gameListVC.selectIndex = section
            gameListVC.tabs = self.findCV?.sections as? [FindListSectionModel]
            self.navigationController?.pushViewController(gameListVC, animated: true)
        }
        
        findCV!.findBannerHandel = {(bannerModel) in
            if bannerModel.cate == 1 {
                showLoading(view: self.view)
                self.getInfoList(linkId: bannerModel.link_id!)
            } else if bannerModel.cate == 2 || bannerModel.cate == 3 {
                if judgeLoginAndPush() {
                    showLoading(view: self.view)
                    self.getGameList(linkId: bannerModel.link_id!)
                }
            }
        }
        
        findCV!.findGameHandel = {(detailModel) in
            if judgeLoginAndPush() {
                showLoading(view: self.view)
                self.getGameList(linkId: detailModel.id!)
            }
        }
        
        if isPass == 0 {
            findCV?.isHidden = true
            let layout = UICollectionViewFlowLayout.init()
            gameCV = GameCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-SAFE_BOTTOM-94), collectionViewLayout: layout)
            gameCV?.refreshDelegate = self
            self.view.addSubview(gameCV!)
            getPassGameList()
            
            gameCV!.gameListPushHandel = {(model) in
                if judgeLoginAndPush() {
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
            }
        }
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        if isLogin() {
            getGameRecord()
        }
        getFindList()
        if isPass == 0 {
            getPassGameList()
        }
    }
    
    func getFindList() {
        BusinessEngine.init().getFindList(successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let listModel = baseModel as! FindListModel
            self.findCV?.banners = (listModel.data?.head?.banner! as NSArray?)!
            self.findCV?.sections = (listModel.data?.list! as NSArray?)!
            self.findCV?.mj_header?.endRefreshing()
            self.findCV?.reloadData()
        }) { (baseModel) in
            self.view.hideToastActivity()
            self.findCV?.mj_header?.endRefreshing()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getGameRecord() {
        BusinessEngine.init().gameRecord(appId: "", successResponse: { (baseModel) in
            let recordModel:FindRecordModel = baseModel as! FindRecordModel
            if recordModel.data != nil {
                self.findCV?.records = (recordModel.data! as NSArray?)!
            } else {
                self.findCV?.records = NSArray.init()
            }
            if self.isFirst {
                self.isFirst = false
                self.findCV?.reloadData()
            } else {
                self.findCV?.reloadItems(at: [IndexPath.init(row: 0, section: 0)])
            }
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getPassGameList() {
        BusinessEngine.init().getUnPassGameList( successResponse: { (BaseModel) in
            let gameModel:GameListModel = BaseModel as! GameListModel
            self.gameCV?.gameList = NSMutableArray.init(array: gameModel.data!)
            self.gameCV?.mj_header?.endRefreshing()
            self.gameCV?.reloadData()
        }) { (BaseModel) in
            self.gameCV?.mj_header?.endRefreshing()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
