//
//  NoticeListViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class NoticeListViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var noticeListCV : NoticeListCollectionView?
    
    var noneView : SnailNoneView?
    
    var count = 1
    
    var mArrData = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "消息", titleColor: colorWithHex(hex: 0x333333))
        initNoticeListCollectionView()
        showLoading(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count = 1
        getNoticeList(pageNum: "1")
    }
    
    func initNoticeListCollectionView() {
        
        let layout = UICollectionViewFlowLayout.init()
        noticeListCV = NoticeListCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44), collectionViewLayout: layout)
        noticeListCV?.refreshDelegate = self
        noticeListCV?.loadMoreDelegate = self
        self.view.addSubview(noticeListCV!)
        
        noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: noticeListCV!.frame.size.width, height: noticeListCV!.frame.size.height))
        noneView?.isHidden = true
        noticeListCV?.addSubview(noneView!)
        
        noticeListCV!.noticeListHandel = {(noticeId) in
            let noticeDetailVC = NoticeDetailViewController.init()
            noticeDetailVC.pushType = 1
            noticeDetailVC.noticeId = noticeId
            self.navigationController?.pushViewController(noticeDetailVC, animated: true)
        }
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        count = 1
        getNoticeList(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        count += 1
        getNoticeList(pageNum: String(count))
    }
    
    func getNoticeList(pageNum:String) {
        BusinessEngine.init().getNoticeList(pageNum: pageNum, successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let noticeModel : NoticeModel = baseModel as! NoticeModel
            if self.count == 1 {
                if (noticeModel.data!.count == 0)
                {
                    self.noneView!.isHidden = false
                }
                else
                {
                    self.noneView!.isHidden = true
                }
                self.noticeListCV?.mj_header!.endRefreshing()
                let arrData = NSMutableArray.init()
                let timeList = NSMutableArray.init()
                for (_,item) in noticeModel.data!.enumerated() {
                    if !timeList.contains(item.push_time as Any) {
                        timeList.add(item.push_time as Any)
                    }
                }

                for (_,timeStr) in timeList.enumerated() {
                    let selectTimeStr:String = timeStr as! String
                    let timeModel = NoticeTimeModel.init()
                    timeModel.push_time = timeStr as? String
                    let timeArray = NSMutableArray.init()
                    for (_,item) in noticeModel.data!.enumerated() {
                        if selectTimeStr == item.push_time {
                            timeArray.add(item)
                        }
                    }
                    timeModel.list = timeArray
                    arrData.add(timeModel)
                }
                self.mArrData = NSMutableArray.init(array: noticeModel.data!)
                self.noticeListCV!.noticeList = arrData
                if noticeModel.data?.count == 20 {
                    self.noticeListCV?.setRefreshEnable()
                }
            } else {
                self.mArrData.addObjects(from: noticeModel.data!)
                let timeList = NSMutableArray.init()
                for (_,item) in self.mArrData.enumerated() {
                    let model:NoticeListModel = item as! NoticeListModel
                    if !timeList.contains(model.push_time as Any) {
                        timeList.add(model.push_time as Any)
                    }
                }
                let arrData = NSMutableArray.init()
                for (_,timeStr) in timeList.enumerated() {
                    let selectTimeStr:String = timeStr as! String
                    let timeModel = NoticeTimeModel.init()
                    timeModel.push_time = timeStr as? String
                    let timeArray = NSMutableArray.init()
                    for (_,item) in noticeModel.data!.enumerated() {
                        if selectTimeStr == item.push_time {
                            timeArray.add(item)
                        }
                    }
                    timeModel.list = timeArray
                    arrData.add(timeModel)
                }
                self.noticeListCV!.noticeList = arrData
                if noticeModel.data?.count != 20 {
                    self.noticeListCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.noticeListCV?.mj_footer!.endRefreshing()
                }
            }
            self.noticeListCV?.reloadData()
        }) { (baseModel) in
            self.noneView!.isHidden = false
            self.noticeListCV?.mj_header!.endRefreshing()
            self.noticeListCV?.endLoadMoreWithNoData()
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
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
