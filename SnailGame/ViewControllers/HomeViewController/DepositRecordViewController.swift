//
//  DepositRecordViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositRecordViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate {
    
    var depositRecordCV : DepositRecordCollectionView?
    
    var noneView : SnailNoneView?
    
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "记录", titleColor: colorWithHex(hex: 0x333333))
        initDepositRecordCollectionView()
        getRecordList(pageNum: "1")
    }
    
    func initDepositRecordCollectionView() {
        let recordHeadView = DepositRecordHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 65*PROSIZE))
        self.view.addSubview(recordHeadView)
    
        let layout = UICollectionViewFlowLayout.init()
        depositRecordCV = DepositRecordCollectionView.init(frame: CGRect.init(x: 0, y: recordHeadView.frame.origin.y+recordHeadView.frame.size.height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-recordHeadView.frame.origin.y-recordHeadView.frame.size.height), collectionViewLayout: layout)
        depositRecordCV?.refreshDelegate = self
        depositRecordCV?.loadMoreDelegate = self
        self.view.addSubview(depositRecordCV!)
        
        noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: depositRecordCV!.frame.size.width, height: depositRecordCV!.frame.size.height))
        noneView?.isHidden = true
        depositRecordCV?.addSubview(noneView!)
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        count = 1
        getRecordList(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        count += 1
        getRecordList(pageNum: String(count))
    }
    
    func getRecordList(pageNum:String) {
        BusinessEngine.init().depositRecordList(pageNum: pageNum, successResponse: { (baseModel) in
            let recordModel:EscrowRecordModel = baseModel as! EscrowRecordModel
            if self.count == 1 {
                self.noneView?.isHidden = true
                self.depositRecordCV?.mj_header!.endRefreshing()
                self.depositRecordCV?.recordList = NSMutableArray.init(array: recordModel.data!)
                if recordModel.data?.count == 20 {
                    self.depositRecordCV?.setLoadMoreEnable()
                }
            } else {
                self.depositRecordCV?.recordList.addObjects(from: recordModel.data!)
                if recordModel.data?.count != 20 {
                    self.depositRecordCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.depositRecordCV?.mj_footer!.endRefreshing()
                }
            }
            self.depositRecordCV?.reloadData()
        }) { (baseModel) in
            self.noneView?.isHidden = false
            self.depositRecordCV?.mj_header!.endRefreshing()
            self.depositRecordCV?.endLoadMoreWithNoData()
        }
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
