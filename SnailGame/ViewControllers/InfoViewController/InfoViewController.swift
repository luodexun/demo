//
//  InfoViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class InfoViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate , UIScrollViewDelegate , InfoDetailUpdateDelegate {

    var titleList = ["资讯","快讯","牛说"]

    var bottomScrlView : UIScrollView?

    var infoCV : InfoCollectionView?
    
    var AlertsCV : AlertsCollectionView?
    
    var cowSayCV : CowSayCollectionView?
    
    var count1 = 1

    var count2 = 1
    
    var count3 = 1
    
    var currentTag = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentTag != 0 {
            for (index,_) in titleList.enumerated() {
                let tab : UIButton = naviView?.viewWithTag(2000+index) as! UIButton
                tab.setTitleColor(UIColor.init(white: 255/255.0, alpha: 0.5), for: UIControl.State.normal)
            }
            let sender : UIButton = naviView?.viewWithTag(2002) as! UIButton
            sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.slideLine?.center = CGPoint.init(x: sender.center.x, y: (self.slideLine?.center.y)!)
            self.bottomScrlView?.contentOffset = CGPoint.init(x: CGFloat(sender.tag-2000)*SCREEN_WIDE, y: 0)
            currentTag = 0
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x0077FF))
        initNaviTabView(titleList: titleList as NSArray, currentIndex: 0)
        initBottomScrl()
        showLoading(view: self.view)
        getInfoList(pageNum: "1")
        getAlertsList(pageNum: "1")
        getCowSayList(pageNum: "1")
    }
    
    func initBottomScrl() {
        
        bottomScrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-94-SAFE_BOTTOM))
        bottomScrlView?.isPagingEnabled = true
        bottomScrlView?.contentSize = CGSize.init(width: CGFloat(titleList.count) * SCREEN_WIDE, height: (bottomScrlView?.frame.size.height)!)
        bottomScrlView?.delegate = self
        bottomScrlView?.showsVerticalScrollIndicator = false
        bottomScrlView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(bottomScrlView!)
        
        let infoLayout = UICollectionViewFlowLayout.init()
        infoCV = InfoCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: (bottomScrlView?.frame.size.height)!), collectionViewLayout: infoLayout)
        infoCV?.refreshDelegate = self
        infoCV?.loadMoreDelegate = self
        bottomScrlView?.addSubview(infoCV!)
        
        let alertLayout = UICollectionViewFlowLayout.init()
        AlertsCV = AlertsCollectionView.init(frame: CGRect.init(x: SCREEN_WIDE, y: 0, width: SCREEN_WIDE, height: (bottomScrlView?.frame.size.height)!), collectionViewLayout: alertLayout)
        AlertsCV?.refreshDelegate = self
        AlertsCV?.loadMoreDelegate = self
        bottomScrlView?.addSubview(AlertsCV!)
        
        let sayHeadView = CowSayHeadView.init(frame: CGRect.init(x: 2*SCREEN_WIDE, y: 0, width: SCREEN_WIDE, height: 75*PROSIZE))
        sayHeadView.sayBtn?.addTarget(self, action: #selector(cowSayAction), for: UIControl.Event.touchUpInside)
        bottomScrlView?.addSubview(sayHeadView)
        
        let cowSayLayout = UICollectionViewFlowLayout.init()
        cowSayCV = CowSayCollectionView.init(frame: CGRect.init(x: 2*SCREEN_WIDE, y: 75*PROSIZE, width: SCREEN_WIDE, height: (bottomScrlView?.frame.size.height)!-75*PROSIZE), collectionViewLayout: cowSayLayout)
        cowSayCV?.refreshDelegate = self
        cowSayCV?.loadMoreDelegate = self
        bottomScrlView?.addSubview(cowSayCV!)
        
        infoCV!.infoPushHandel = {(infoModel) in
            let detailVC = InfoDetailViewController.init()
            detailVC.pushType = 1
            detailVC.infoModel = infoModel
            detailVC.infoUpdateDelegate = self
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        if collectionView == infoCV {
            count1 = 1
            getInfoList(pageNum: "1")
        }else if collectionView == AlertsCV {
            count2 = 1
            getAlertsList(pageNum: "1")
        } else {
            count3 = 1
            getCowSayList(pageNum: "1")
        }
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        if collectionView == infoCV {
            count1 += 1
            getInfoList(pageNum: String(count1))
        }else if collectionView == AlertsCV {
            count2 += 1
            getAlertsList(pageNum: String(count2))
        } else {
            count3 += 1
            getCowSayList(pageNum: String(count3))
        }
    }
    
    func infoDetailUpdateAction() {
        count1 = 1
        getInfoList(pageNum: "1")
    }
    
    @objc func cowSayAction(sender:UIButton) {
        if judgeLoginAndPush() {
            if BusinessEngine.init().getLoginUserModel().vip! > 0 {
                let releaseSayVC = ReleaseSayViewController.init()
                releaseSayVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.present(releaseSayVC, animated: true, completion: nil)
            } else {
                showTextToast(text: "您未达到内测条件，请等待“牛说”正式上线。", view: self.view)
            }
        }
    }

    func getInfoList(pageNum:String) {
        BusinessEngine.init().getInfoList(pageNum: pageNum, sort: "create_time", linkId: "", successResponse: { (baseModel) in
            let infoModel:InfoListModel = baseModel as! InfoListModel
            if self.count1 == 1 {
                self.infoCV?.mj_header!.endRefreshing()
                self.infoCV?.infoList = NSMutableArray.init(array: infoModel.data!)
                if infoModel.data?.count == 20 {
                    self.infoCV?.setLoadMoreEnable()
                }
            } else {
                self.infoCV?.infoList.addObjects(from: infoModel.data!)
                if infoModel.data?.count != 20 {
                    self.infoCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.infoCV?.mj_footer!.endRefreshing()
                }
            }
            self.view.hideToastActivity()
            self.infoCV?.reloadData()
        }) { (baseModel) in
            self.view.hideToastActivity()
            self.infoCV?.mj_header!.endRefreshing()
            self.infoCV?.endLoadMoreWithNoData()
        }
    }

    func getAlertsList(pageNum:String) {
        BusinessEngine.init().getAlertsList(pageNum: pageNum, sort: "create_time", successResponse: { (BaseModel) in
            let alertModel:AlertsListModel = BaseModel as! AlertsListModel
            if self.count2 == 1 {
                self.AlertsCV?.mj_header!.endRefreshing()
                self.AlertsCV?.alertList = NSMutableArray.init(array: alertModel.data!)
                if alertModel.data?.count == 20 {
                    self.AlertsCV?.setLoadMoreEnable()
                }
            } else {
                self.AlertsCV?.alertList.addObjects(from: alertModel.data!)
                if alertModel.data?.count != 20 {
                    self.AlertsCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.AlertsCV?.mj_footer!.endRefreshing()
                }
            }
            self.AlertsCV?.reloadData()
        }) { (BaseModel) in
            self.AlertsCV?.mj_header!.endRefreshing()
            self.AlertsCV?.endLoadMoreWithNoData()
        }
    }
    
    func getCowSayList(pageNum:String) {
        BusinessEngine.init().getCowSayList(pageNum: pageNum, sort: "create_time", successResponse: { (BaseModel) in
            let cowModel:CowSayModel = BaseModel as! CowSayModel
            if self.count3 == 1 {
                self.cowSayCV?.mj_header!.endRefreshing()
                self.cowSayCV?.sayList = NSMutableArray.init(array: cowModel.data!)
                if cowModel.data?.count == 20 {
                    self.cowSayCV?.setLoadMoreEnable()
                }
            } else {
                self.cowSayCV?.sayList.addObjects(from: cowModel.data!)
                if cowModel.data?.count != 20 {
                    self.cowSayCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.cowSayCV?.mj_footer!.endRefreshing()
                }
            }
            self.cowSayCV?.reloadData()
        }) { (BaseModel) in
            self.cowSayCV?.mj_header!.endRefreshing()
            self.cowSayCV?.endLoadMoreWithNoData()
        }
    }
    
    @objc override func tabSelectAction(sender:UIButton) {
        for (index,_) in titleList.enumerated() {
            let tab : UIButton = naviView?.viewWithTag(2000+index) as! UIButton
            tab.setTitleColor(UIColor.init(white: 255/255.0, alpha: 0.5), for: UIControl.State.normal)
        }
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        UIView .animate(withDuration: 0.3) {
            self.slideLine?.center = CGPoint.init(x: sender.center.x, y: (self.slideLine?.center.y)!)
            self.bottomScrlView?.contentOffset = CGPoint.init(x: CGFloat(sender.tag-2000)*SCREEN_WIDE, y: 0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
