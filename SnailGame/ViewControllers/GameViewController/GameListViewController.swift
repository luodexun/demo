//
//  GameListViewController.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class GameListViewController: BaseViewController , UIScrollViewDelegate , collectionRefreshDelegate , collectionLoadMoreDelegate {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tabs : [FindListSectionModel]?

    var selectIndex = 0
    
    var type = ""
    
    var firstLoad = true
    
    var gameHeadView : GameListHeadView?
    
    var bottomScrlView : UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "分类", titleColor: colorWithHex(hex: 0x333333))
        initViews()
        getTabs()
    }
    
    func initViews() {
        
        gameHeadView = GameListHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 30*PROSIZE))
        self.view.addSubview(gameHeadView!)
        
        bottomScrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+30*PROSIZE, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44-30*PROSIZE-SAFE_BOTTOM))
        bottomScrlView?.isPagingEnabled = true
        bottomScrlView?.showsHorizontalScrollIndicator = false
        bottomScrlView?.delegate = self
        self.view.addSubview(bottomScrlView!)
        
        bottomScrlView?.contentSize = CGSize.init(width: SCREEN_WIDE * CGFloat(tabs!.count), height: bottomScrlView!.frame.size.height)
        
        gameHeadView!.gameListHeadHandel = {(indexPath) in
            let index = indexPath.item
            self.selectIndex = index
            //let cell:GameListHeadCell = self.gameHeadView?.gameTabCV?.cellForItem(at: indexPath) as! GameListHeadCell
            UIView.animate(withDuration: 0.3) {
                //self.gameHeadView?.selectLine?.center.x = cell.center.x
                self.bottomScrlView?.contentOffset = CGPoint.init(x: CGFloat(index) * SCREEN_WIDE, y: 0)
            }
            for (_,item) in (self.tabs?.enumerated())! {
                item.isSelect = false
            }
            let sectionModel = self.tabs![index]
            sectionModel.isSelect = true
            self.type = sectionModel.id!
            self.gameHeadView?.sections = self.tabs! as NSArray
            self.gameHeadView?.gameTabCV?.reloadData()
            if sectionModel.isFirst! {
                sectionModel.isFirst = false
                sectionModel.currentCount = 1
                showLoading(view: self.view)
                self.getGameList(pageNum: "1")
            }
        }
    }
    
    func getTabs() {
        
        for (i,item) in (tabs?.enumerated())! {
            item.isSelect = false
            item.isFirst = true
            item.currentCount = 1
            let layout = UICollectionViewFlowLayout.init()
            let gameCV = GameCollectionView.init(frame: CGRect.init(x: CGFloat(i)*SCREEN_WIDE, y: 0, width: SCREEN_WIDE, height: bottomScrlView!.frame.size.height), collectionViewLayout: layout)
            gameCV.tag = 5000+i
            gameCV.refreshDelegate = self
            gameCV.loadMoreDelegate = self
            bottomScrlView?.addSubview(gameCV)
            
            gameCV.gameListPushHandel = {(model) in
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
        
        let sectionModel = tabs![selectIndex]
        sectionModel.isSelect = true
        sectionModel.isFirst = false
        type = sectionModel.id!
        gameHeadView?.sections = tabs! as NSArray
        gameHeadView?.gameTabCV?.reloadData()
        
        gameHeadView?.gameTabCV?.scrollToItem(at: IndexPath.init(item: selectIndex, section: 0), at: .centeredHorizontally, animated: false)
        bottomScrlView?.contentOffset = CGPoint.init(x: CGFloat(selectIndex) * SCREEN_WIDE, y: 0)
        showLoading(view: self.view)
        getGameList(pageNum: "1")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int((bottomScrlView?.contentOffset.x)!/SCREEN_WIDE)
        selectIndex = index
        gameHeadView?.gameTabCV?.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        for (_,item) in (tabs?.enumerated())! {
            item.isSelect = false
        }
        let sectionModel = tabs![index]
        sectionModel.isSelect = true
        type = sectionModel.id!
        gameHeadView?.sections = tabs! as NSArray
        gameHeadView?.gameTabCV?.reloadData()
        if sectionModel.isFirst! {
            sectionModel.isFirst = false
            sectionModel.currentCount = 1
            showLoading(view: self.view)
            getGameList(pageNum: "1")
        }
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        let sectionModel = tabs![collectionView.tag-5000]
        sectionModel.currentCount = 1
        getGameList(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        let sectionModel = tabs![collectionView.tag-5000]
        sectionModel.currentCount! += 1
        getGameList(pageNum: String(sectionModel.currentCount!))
    }
    
    func getGameList(pageNum:String) {
        let gameCV:GameCollectionView = bottomScrlView?.viewWithTag(5000+selectIndex) as! GameCollectionView
        let currentCount = Int(pageNum)
        BusinessEngine.init().getGameList(pageNum: pageNum, key: "desc", value: "id",type:type, linkId: "", successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let gameModel:GameListModel = BaseModel as! GameListModel
            if currentCount == 1 {
                gameCV.mj_header!.endRefreshing()
                gameCV.gameList = NSMutableArray.init(array: gameModel.data!)
                if gameModel.data?.count == 20 {
                    gameCV.setLoadMoreEnable()
                }
            } else {
                gameCV.gameList?.addObjects(from: gameModel.data!)
                if gameModel.data?.count != 20 {
                    gameCV.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    gameCV.mj_footer!.endRefreshing()
                }
            }
            gameCV.reloadData()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            gameCV.mj_header!.endRefreshing()
            gameCV.endLoadMoreWithNoData()
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
