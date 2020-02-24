//
//  PromotionRecordViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionRecordViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate {

    var recordHeadView : PromotionRecordHeadView?
    
    var promotionRecordCV : PromotionRecordCollectionView?
    
    var noneView : SnailNoneView?
    
    var count = 1
    
    var configModel : ConfigModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "推广记录", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        configModel = ConfigModel.deserialize(from: str)
        initViews()
        getPromotionRecords(pageNum: "1")
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initViews() {
        recordHeadView = PromotionRecordHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 167*PROSIZE))
        self.view.addSubview(recordHeadView!)
        recordHeadView?.introduceBtn?.addTarget(self, action: #selector(introduceAction), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout.init()
        promotionRecordCV = PromotionRecordCollectionView.init(frame: CGRect.init(x: 0, y: recordHeadView!.frame.origin.y+recordHeadView!.frame.size.height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-recordHeadView!.frame.origin.y-recordHeadView!.frame.size.height), collectionViewLayout: layout)
        promotionRecordCV?.refreshDelegate = self
        promotionRecordCV?.loadMoreDelegate = self
        self.view.addSubview(promotionRecordCV!)
        
        noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: promotionRecordCV!.frame.size.width, height: promotionRecordCV!.frame.size.height))
        noneView?.isHidden = true
        promotionRecordCV?.addSubview(noneView!)
    }
    
    @objc func introduceAction(sender:UIButton) {
        showAlert(currentVC: self, title: "收益说明", meg: configModel!.popularize_reward!, cancel: "", sure: "朕知道了", cancelHandler: { (action) in
        }) { (action) in
        }
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        count = 1
        getPromotionRecords(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        count += 1
        getPromotionRecords(pageNum: String(count))
    }
    
    func getPromotionRecords(pageNum:String) {
        BusinessEngine.init().getPromotionRecords(pageNum: pageNum, successResponse: { (BaseModel) in
            let recordModel : PromotionRecordModel = BaseModel as! PromotionRecordModel
            if self.count == 1 {
                if recordModel.data?.list?.count == 0 {
                    self.noneView?.isHidden = false
                } else {
                    self.noneView?.isHidden = true
                }
                self.recordHeadView?.setPromotionRecordHeadView(dataModel: recordModel.data!)
                self.promotionRecordCV?.mj_header!.endRefreshing()
                self.promotionRecordCV?.recordList = NSMutableArray.init(array: recordModel.data!.list!)
                if recordModel.data?.list?.count == 20 {
                    self.promotionRecordCV?.setLoadMoreEnable()
                }
            } else {
                self.promotionRecordCV?.recordList.addObjects(from: recordModel.data!.list!)
                if recordModel.data?.list?.count != 20 {
                    self.promotionRecordCV?.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.promotionRecordCV?.mj_footer!.endRefreshing()
                }
            }
            self.promotionRecordCV?.reloadData()
        }) { (BaseModel) in
            self.noneView?.isHidden = false
            self.promotionRecordCV?.mj_header!.endRefreshing()
            self.promotionRecordCV?.endLoadMoreWithNoData()
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
