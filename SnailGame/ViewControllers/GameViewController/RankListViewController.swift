//
//  RankListViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RankListViewController: BaseViewController , UIScrollViewDelegate {

    var gameName : String?
    
    var app_id : String?

    var titleList = ["日榜","周榜","月榜"]
    
    var tabView : RankListTabView?
    
    var gameScrlView : UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: gameName!, titleColor: colorWithHex(hex: 0x333333))
        showLoading(view: self.view)
        initViews()
    }
    
    func initViews() {
        
        tabView = RankListTabView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 74*PROSIZE), list: titleList as NSArray)
        self.view.addSubview(tabView!)
        
        gameScrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: (tabView?.frame.origin.y)!+(tabView?.frame.size.height)!, width: SCREEN_WIDE, height: SCREEN_HEIGHT-(tabView?.frame.origin.y)!-(tabView?.frame.size.height)!))
        gameScrlView?.showsHorizontalScrollIndicator = false
        gameScrlView?.isPagingEnabled = true
        gameScrlView?.contentSize = CGSize.init(width: 3*SCREEN_WIDE, height: (gameScrlView?.frame.size.height)!)
        gameScrlView?.delegate = self
        self.view.addSubview(gameScrlView!)
        
        tabView!.rankListTabHandel = {(tagIndex) in
            UIView .animate(withDuration: 0.3) {
                self.gameScrlView?.contentOffset = CGPoint.init(x: CGFloat(tagIndex) * SCREEN_WIDE, y: 0)
            }
        }
        
        for (index,_) in titleList.enumerated() {
            let layout = UICollectionViewFlowLayout.init()
            let rankListCV = RankListCollectionView.init(frame: CGRect.init(x: CGFloat(index)*SCREEN_WIDE, y: 0, width: SCREEN_WIDE, height: (gameScrlView?.frame.size.height)!-50*PROSIZE-SAFE_BOTTOM), collectionViewLayout: layout)
            rankListCV.tag = 3000+index
            gameScrlView?.addSubview(rankListCV)
            
            let rankView = RankListBottomView.init(frame: CGRect.init(x: CGFloat(index)*SCREEN_WIDE, y: (gameScrlView?.frame.size.height)!-50*PROSIZE-SAFE_BOTTOM, width: SCREEN_WIDE, height: 50*PROSIZE+SAFE_BOTTOM))
            rankView.tag = 4000+index
            gameScrlView?.addSubview(rankView)
            
            getRankList(index: 3000+index)
        }
    }
    
    func getRankList(index:Int) {
        
        var rang = ""
        if index == 3000 {
            rang = "today"
        } else if index == 3001 {
            rang = "week"
        } else {
            rang = "month"
        }
        
        let rankListCV : RankListCollectionView  = gameScrlView?.viewWithTag(index) as! RankListCollectionView
        
        let rankView : RankListBottomView = gameScrlView?.viewWithTag(index+1000) as! RankListBottomView
        
        BusinessEngine.init().getRankingList(range: rang, appId: app_id!, successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let listModel:RankListModel = baseModel as! RankListModel
            if listModel.data?.nowrank?.ranknum != nil {
                rankView.rankNumLbl?.text = listModel.data!.nowrank!.ranknum!
            }
            if listModel.data?.nowrank?.avatar != nil {
                rankView.userImageVeiw?.dwn_setImageView(urlStr: listModel.data!.nowrank!.avatar!, imageName: "")
            }
            if listModel.data?.nowrank?.nickname != nil {
                rankView.userNameLbl?.text = listModel.data!.nowrank!.nickname!
            }
            if listModel.data?.nowrank?.award != nil {
                rankView.rewardNumLbl?.text = listModel.data!.nowrank!.award!
            }
            if listModel.data?.nowrank?.integral != nil {
                rankView.integralNumLbl?.text = listModel.data!.nowrank!.integral!
            }
            rankListCV.rankList = NSMutableArray.init(array: listModel.data!.list!)
            rankListCV.remainTimeStr = listModel.data!.remaining_time!
            rankListCV.reloadData()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
     
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for (index,_) in titleList.enumerated() {
            let tab : UIButton = tabView?.viewWithTag(4000+index) as! UIButton
            tab.setTitleColor(colorWithHex(hex: 0x333333), for: UIControl.State.normal)
        }
        
        let sender = tabView?.viewWithTag(4000+Int((gameScrlView?.contentOffset.x)!/SCREEN_WIDE)) as! UIButton
        sender.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        
        UIView .animate(withDuration: 0.3) {
            self.tabView?.tabLine?.center = CGPoint.init(x: sender.center.x, y: (self.tabView?.tabLine?.center.y)!)
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
