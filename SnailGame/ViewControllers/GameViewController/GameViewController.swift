//
//  GameViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate {

    var gameCV : GameCollectionView?
    
    var count : Int = 1

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x0077FF))
        initNaviTitle(titleStr: "发现", titleColor: colorWithHex(hex: 0xffffff))
        initGameCollectionView()
        getGameList(pageNum: "1")
    }
    
    func initGameCollectionView() {
        
        let layout = UICollectionViewFlowLayout.init()
        gameCV = GameCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-SAFE_BOTTOM-94) , collectionViewLayout: layout)
        gameCV?.refreshDelegate = self
        gameCV?.loadMoreDelegate = self
        self.view.addSubview(gameCV!)
        
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
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        count = 1
        getGameList(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        count += 1
        getGameList(pageNum: String(count))
    }
    
    func getGameList(pageNum:String) {
        BusinessEngine.init().getGameList(pageNum: pageNum, key: "desc", value: "id",type:"", linkId: "", successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let gameModel:GameListModel = BaseModel as! GameListModel
            if self.count == 1 {
                self.gameCV?.mj_header!.endRefreshing()
                self.gameCV?.gameList = NSMutableArray.init(array: gameModel.data!)
                if gameModel.data?.count == 20 {
                    self.gameCV?.setLoadMoreEnable()
                }
            } else {
                self.gameCV?.gameList?.addObjects(from: gameModel.data!)
                if gameModel.data?.count != 20 {
                    self.gameCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.gameCV?.mj_footer!.endRefreshing()
                }
            }
            self.gameCV?.reloadData()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            self.gameCV?.mj_header!.endRefreshing()
            self.gameCV?.endLoadMoreWithNoData()
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
