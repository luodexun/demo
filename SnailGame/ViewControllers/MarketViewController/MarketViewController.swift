//
//  MarketViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MarketViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate , UIScrollViewDelegate {

    var titleList = ["自选","所有"]

    var bottomScrlView : UIScrollView?
    
    var allSortView : MarketSortView?
    
    var mineSortView : MarketSortView?
    
    var noneView : SnailNoneView?
    
    var count1 = 1
    
    var count2 = 1
    
    var mineKey = ""
    
    var mineValue = ""
    
    var allKey = ""
    
    var allValue = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x0077FF))
        initRightImageButton(imageStr: "ic_market_search")
        initNaviTabView(titleList: titleList as NSArray,currentIndex: 1)
        initViews()
        getMarketList(pageNum: "1", tag: 701)
        bottomScrlView?.contentOffset = CGPoint.init(x: SCREEN_WIDE, y: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLogin() == false {
            tabSelect(currentTag: 2001)
        } else {
            count1 = 1
            getMarketList(pageNum: "1", tag: 700)
        }
    }
    
    func initViews() {
        bottomScrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-94-SAFE_BOTTOM))
        bottomScrlView?.isPagingEnabled = true
        bottomScrlView?.contentSize = CGSize.init(width: CGFloat(titleList.count) * SCREEN_WIDE, height: (bottomScrlView?.frame.size.height)!)
        bottomScrlView?.delegate = self
        bottomScrlView?.showsVerticalScrollIndicator = false
        bottomScrlView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(bottomScrlView!)
        
        mineSortView = MarketSortView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 35*PROSIZE))
        bottomScrlView?.addSubview(mineSortView!)
        
        allSortView = MarketSortView.init(frame: CGRect.init(x: SCREEN_WIDE, y: 0, width: SCREEN_WIDE, height: 35*PROSIZE))
        bottomScrlView?.addSubview(allSortView!)
        
        for (index,_) in titleList.enumerated() {
            let layout = UICollectionViewFlowLayout.init()
            let marketCV = MarketCollectionView.init(frame: CGRect.init(x: CGFloat(index)*SCREEN_WIDE, y: 35*PROSIZE, width: SCREEN_WIDE, height: (bottomScrlView?.frame.size.height)!-35*PROSIZE), collectionViewLayout: layout)
            marketCV.tag = 700+index
            marketCV.refreshDelegate = self
            marketCV.loadMoreDelegate = self
            bottomScrlView?.addSubview(marketCV)
            if index == 0 {
                noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: marketCV.frame.size.height))
                noneView?.isHidden = true
                marketCV.addSubview(noneView!)
            }
            marketCV.marketPushHandel = {(dataModel:MarketDataModel) in
                let detailVC = InfoDetailViewController.init()
                detailVC.pushType = 2
                detailVC.marketModel = dataModel
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        
        mineSortView?.marketSortHandel = { (key,value) in
            self.mineKey = key
            self.mineValue = value
            self.count1 = 1
            self.getMarketList(pageNum: "1", tag: 700)
        }
        
        allSortView?.marketSortHandel = { (key,value) in
            self.allKey = key
            self.allValue = value
            self.count2 = 1
            self.getMarketList(pageNum: "1", tag: 701)
        }
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        if collectionView.tag == 700 {
            count1 = 1
        } else {
            count2 = 1
        }
        getMarketList(pageNum: "1", tag: collectionView.tag)
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        if collectionView.tag == 700 {
            count1 += 1
            getMarketList(pageNum: String(count1), tag: collectionView.tag)
        } else {
            count2 += 1
            getMarketList(pageNum: String(count2), tag: collectionView.tag)
        }
    }
    
    func getMarketList(pageNum:String,tag:Int) {
        
        let marketCV : MarketCollectionView  = bottomScrlView?.viewWithTag(tag) as! MarketCollectionView
        
        let count = Int(pageNum)
        
        var key = ""
        
        var value = ""
        
        var range = ""
        
        
        if tag == 700 {
            key = mineKey
            value = mineValue
            range = "own"
        } else {
            key = allKey
            value = allValue
            range = "all"
        }
        
        BusinessEngine.init().getMarketList(pageNum: pageNum, key: key, value: value, range: range, successResponse: { (BaseModel) in
            let marketModel:MarketListModel = BaseModel as! MarketListModel
            if  marketCV.tag == 700 {
                self.noneView?.isHidden = true
            }
            if count == 1 {
                var hotCount = 0
                for (_,item) in marketModel.data!.enumerated() {
                    if item.is_hot == 1 {
                        hotCount += 1
                    }
                }
                marketCV.mj_header!.endRefreshing()
                marketCV.marketList = NSMutableArray.init(array: marketModel.data!)
                if (marketModel.data!.count - hotCount) == 20 {
                    marketCV.setLoadMoreEnable()
                }
            } else {
                marketCV.marketList.addObjects(from: marketModel.data!)
                if marketModel.data?.count != 20 {
                    marketCV.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    marketCV.mj_footer!.endRefreshing()
                }
            }
            marketCV.reloadData()
        }) { (BaseModel) in
            if BaseModel.code == 2000 && marketCV.tag == 700 {
                self.noneView?.isHidden = false
            }
            marketCV.mj_header!.endRefreshing()
            marketCV.endLoadMoreWithNoData()
        }
    }
    
    override func rightImageAction(sender: UIButton) {
        let marketSearchVC = MarketSearchViewController.init()
        self.navigationController?.pushViewController(marketSearchVC, animated: true)
    }
    
    override func tabSelectAction(sender: UIButton) {
        if judgeLoginAndPush() {
            count1 = 1
            getMarketList(pageNum: "1", tag: 700)
        }
        tabSelect(currentTag: sender.tag)
    }
    
    func tabSelect(currentTag:Int) {
        
        for (index,_) in titleList.enumerated() {
            let tab : UIButton = naviView?.viewWithTag(2000+index) as! UIButton
            tab.setTitleColor(UIColor.init(white: 255/255.0, alpha: 0.5), for: UIControl.State.normal)
        }
        
        let sender : UIButton = naviView?.viewWithTag(currentTag) as! UIButton
    
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        UIView .animate(withDuration: 0.3) {
            self.slideLine?.center = CGPoint.init(x: sender.center.x, y: (self.slideLine?.center.y)!)
            self.bottomScrlView?.contentOffset = CGPoint.init(x: CGFloat(sender.tag-2000)*SCREEN_WIDE, y: 0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if judgeLoginAndPush() {
            count1 = 1
            getMarketList(pageNum: "1", tag: 700)
        }
        for (index,_) in titleList.enumerated() {
            let tab : UIButton = naviView?.viewWithTag(2000+index) as! UIButton
            tab.setTitleColor(UIColor.init(white: 255/255.0, alpha: 0.5), for: UIControl.State.normal)
        }
        
        let sender = naviView?.viewWithTag(2000+Int((bottomScrlView?.contentOffset.x)!/SCREEN_WIDE)) as! UIButton
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        UIView .animate(withDuration: 0.3) {
            self.slideLine?.center = CGPoint.init(x: sender.center.x, y: (self.slideLine?.center.y)!)
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
