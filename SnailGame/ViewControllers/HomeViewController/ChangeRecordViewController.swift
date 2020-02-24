//
//  ChangeRecordViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ChangeRecordViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate {
    
    var changeRecordCV : ChangeRecordCollectionView?
    
    var noneView : SnailNoneView?
    
    var count = 1
    
    var mArr = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "变动记录", titleColor: colorWithHex(hex: 0x333333))
        initChangeRecordCollectionView()
        showLoading(view: self.view)
        getWealthChangeList(pageNum: "1")
    }
    
    func initChangeRecordCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        changeRecordCV = ChangeRecordCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44), collectionViewLayout: layout)
        changeRecordCV?.refreshDelegate = self
        changeRecordCV?.loadMoreDelegate = self
        changeRecordCV!.recordType = 1
        self.view.addSubview(changeRecordCV!)
        
        noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: changeRecordCV!.frame.size.width, height: changeRecordCV!.frame.size.height))
        noneView?.isHidden = true
        changeRecordCV?.addSubview(noneView!)
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        count = 1
        getWealthChangeList(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        count += 1
        getWealthChangeList(pageNum: String(count))
    }
    
    func getWealthChangeList(pageNum:String) {
        BusinessEngine.init().getWealthChangeList(pageNum: pageNum, successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let recordModel:CandyRecordModel = baseModel as! CandyRecordModel
            if self.count == 1 {
                self.noneView?.isHidden = true
                self.changeRecordCV?.mj_header!.endRefreshing()
                let arrData = NSMutableArray.init()
                let timeList = NSMutableArray.init()
                for (_,model) in (recordModel.data?.enumerated())! {
                    if !timeList.contains(model.datetime as Any) {
                        timeList.add(model.datetime as Any)
                    }
                }
                for (_,item) in timeList.enumerated() {
                    let selectTimeStr = item as! String
                    let timeModel = CandyRecordTimeModel.init()
                    timeModel.datetime = selectTimeStr
                    let timeArray = NSMutableArray.init()
                    for (_,listModel) in (recordModel.data?.enumerated())! {
                        if listModel.datetime == selectTimeStr {
                            timeArray.add(listModel)
                        }
                    }
                    timeModel.arrList = (timeArray as! [CandyRecordDataModel])
                    arrData.add(timeModel)
                }
                self.mArr = NSMutableArray.init(array: recordModel.data!)
                self.changeRecordCV?.recordList = arrData
                if recordModel.data?.count == 20 {
                    self.changeRecordCV?.setLoadMoreEnable()
                }
            } else {
                self.mArr.addObjects(from: recordModel.data!)
                let timeList = NSMutableArray.init()
            
                for (_,item) in self.mArr.enumerated() {
                    let model:CandyRecordDataModel = item as! CandyRecordDataModel
                    if !timeList.contains(model.datetime as Any) {
                        timeList.add(model.datetime as Any)
                    }
                }
 
                let arrData = NSMutableArray.init()
                for (_,item) in timeList.enumerated() {
                    let selectTimeStr = item as! String
                    let timeModel = CandyRecordTimeModel.init()
                    timeModel.datetime = selectTimeStr
                    let timeArray = NSMutableArray.init()
                    for (_,model) in self.mArr.enumerated() {
                        let listModel:CandyRecordDataModel = model as! CandyRecordDataModel
                        if listModel.datetime == selectTimeStr {
                            timeArray.add(listModel)
                        }
                    }
                    timeModel.arrList = (timeArray as! [CandyRecordDataModel])
                    arrData.add(timeModel)
                }
                self.changeRecordCV?.recordList = arrData
                if recordModel.data?.count != 20 {
                    self.changeRecordCV?.endLoadMoreWithNoData()
                } else {
                    self.changeRecordCV?.endLoadMore()
                }
            }
            self.changeRecordCV?.reloadData()
        }) { (baseModel) in
            self.noneView?.isHidden = false
            self.view.hideToastActivity()
            self.changeRecordCV?.mj_header!.endRefreshing()
            self.changeRecordCV?.endLoadMoreWithNoData()
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
