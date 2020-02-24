//
//  EthCenterViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class EthCenterViewController: BaseViewController , collectionRefreshDelegate , collectionLoadMoreDelegate {

    var ethHeadView : EthCenterHeadView?
    
    var ethCenterCV : EthCenterCollectionView?

    var noneView : SnailNoneView?
    
    var mArr = NSMutableArray.init()

    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "ETH", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "帮助", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initViews()
        getCurrencyList(pageNum: "1")
    }
    
    func initViews() {
        ethHeadView = EthCenterHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 159*PROSIZE))
        self.view.addSubview(ethHeadView!)
        
        let layout = UICollectionViewFlowLayout.init()
        ethCenterCV = EthCenterCollectionView.init(frame: CGRect.init(x: 0, y: (ethHeadView?.frame.origin.y)!+(ethHeadView?.frame.size.height)!, width: SCREEN_WIDE, height: SCREEN_HEIGHT-(ethHeadView?.frame.origin.y)!-(ethHeadView?.frame.size.height)!), collectionViewLayout: layout)
        ethCenterCV?.refreshDelegate = self
        ethCenterCV?.loadMoreDelegate = self
        self.view.addSubview(ethCenterCV!)
        
        noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: ethCenterCV!.frame.size.width, height: ethCenterCV!.frame.size.height))
        noneView?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        noneView?.isHidden = true
        ethCenterCV?.addSubview(noneView!)
        
        ethCenterCV!.EthCenterHandel = {(dataModel) in
            let recordDetailVC = EthRecordDetailViewController.init()
            recordDetailVC.detailModel = dataModel
            self.navigationController?.pushViewController(recordDetailVC, animated: true)
        }
        
        ethHeadView?.depositBtn?.addTarget(self, action: #selector(depositAction), for: .touchUpInside)
        
        ethHeadView?.exchangeBtn?.addTarget(self, action: #selector(exchangeAction), for: .touchUpInside)
    }
    
    @objc func depositAction(sender:UIButton) {
        let depositEthVC = DepositEthViewController.init()
        self.navigationController?.pushViewController(depositEthVC, animated: true)
    }
    
    @objc func exchangeAction(sender:UIButton) {
        let exchangeEthVC = ExchangeEthViewController.init()
        self.navigationController?.pushViewController(exchangeEthVC, animated: true)
    }
    
    override func rightImageAction(sender: UIButton) {
        showAlert(currentVC: self, title: "", meg: "如长时间未到账，请做如下确认：\n\n1.确认存入钱包地址是否正确；\n\n2.确认是否存在成功转账记录；\n\n3.如已经确认转账成功，请联系客服帮您进一步查询。客服微信号：digi-snail", sure: "朕知道了") { (action) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var eth = "0"
        let userModel = BusinessEngine.init().getLoginUserModel()
        if userModel.currency?.count != 0 {
            eth = calculateAChuyiB(a: (userModel.currency![0].balance)!, b: ETH_RATIO)
        }
        ethHeadView?.ethNumLbl?.text = KeepSomeDecimal(num: eth, decimal: 8)
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        count = 1
        getUserInfo()
        getCurrencyList(pageNum: "1")
    }
    
    func collectionLoadMoreAction(collectionView: UICollectionView) {
        count += 1
        getCurrencyList(pageNum: String(count))
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            let loginModel = BaseModel as! UserLoginModel
            var eth = "0"
            if loginModel.data!.currency?.count != 0 {
                eth = calculateAChuyiB(a: (loginModel.data!.currency![0].balance)!, b: ETH_RATIO)
            }
            self.ethHeadView?.ethNumLbl?.text = KeepSomeDecimal(num: eth, decimal: 8)
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getCurrencyList(pageNum:String) {
        BusinessEngine.init().getCurrencyList(pageNum: pageNum, currency: "ETH", successResponse: { (baseModel) in
            let recordModel = baseModel as! EthRecordModel
            if self.count == 1 {
                self.noneView?.isHidden = true
                self.ethCenterCV?.mj_header!.endRefreshing()
                let arrData = NSMutableArray.init()
                let timeList = NSMutableArray.init()
                
                for (_,model) in (recordModel.data?.enumerated())! {
                    if !timeList.contains(model.datetime as Any) {
                        timeList.add(model.datetime as Any)
                    }
                }
                
                for (_,item) in timeList.enumerated() {
                    let selectTimeStr = item as! String
                    let timeModel = RecordTimeModel.init()
                    timeModel.datetime = selectTimeStr
                    let timeArray = NSMutableArray.init()
                    for (_,listModel) in (recordModel.data?.enumerated())! {
                        if listModel.datetime == selectTimeStr {
                            timeArray.add(listModel)
                        }
                    }
                    timeModel.arrList = (timeArray as! [EthRecordDataModel])
                    arrData.add(timeModel)
                }
                self.mArr = NSMutableArray.init(array: recordModel.data!)
                self.ethCenterCV?.mArrData = arrData
                if recordModel.data?.count == 10 {
                    self.ethCenterCV?.setLoadMoreEnable()
                }
            } else {
                self.mArr.addObjects(from: recordModel.data!)
                let timeList = NSMutableArray.init()
                
                for (_,item) in self.mArr.enumerated() {
                    let model:EthRecordDataModel = item as! EthRecordDataModel
                    if !timeList.contains(model.datetime as Any) {
                        timeList.add(model.datetime as Any)
                    }
                }

                let arrData = NSMutableArray.init()
                for (_,item) in timeList.enumerated() {
                    let selectTimeStr = item as! String
                    let timeModel = RecordTimeModel.init()
                    timeModel.datetime = selectTimeStr
                    let timeArray = NSMutableArray.init()
                    for (_,model) in self.mArr.enumerated() {
                        let listModel:EthRecordDataModel = model as! EthRecordDataModel
                        if listModel.datetime == selectTimeStr {
                            timeArray.add(listModel)
                        }
                    }
                    timeModel.arrList = (timeArray as! [EthRecordDataModel])
                    arrData.add(timeModel)
                }
                self.ethCenterCV?.mArrData = arrData
                if recordModel.data?.count != 10 {
                    self.ethCenterCV?.endLoadMoreWithNoData()
                } else {
                    self.ethCenterCV?.endLoadMore()
                }
            }
            self.ethCenterCV?.reloadData()
        }) { (baseModel) in
            self.noneView?.isHidden = false
            self.ethCenterCV?.mj_header!.endRefreshing()
            self.ethCenterCV?.endLoadMoreWithNoData()
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
