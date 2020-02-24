//
//  WalletDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WalletDetailViewController: BaseViewController , collectionRefreshDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var walletHeadView : WalletDetailHeadView?
    
    var walletDetailCV : WalletDetailCollectionView?
    
    var noneView : SnailNoneView?
    
    var walletAddress : String?
    
    var userModel : UserLoginDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_white")
        initNaviTitle(titleStr: "钱包", titleColor: colorWithHex(hex: 0xffffff))
        initRightImageButton(imageStr: "ic_wallet_detail_more")
        initViews()
        userModel = BusinessEngine.init().getLoginUserModel()
        walletAddress = userModel!.wallet_address
        walletHeadView?.walletAddressLbl?.text = walletAddress
        tradeRecordList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let balance = BusinessEngine.init().getLinkWalletBalance()
        walletHeadView?.walletDwnLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: balance, b: TOKEN_RATIO), decimal: 2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initViews() {
        walletHeadView = WalletDetailHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 300*PROSIZE))
        self.view.addSubview(walletHeadView!)
        
        walletHeadView?.coppyBtn?.addTarget(self, action: #selector(coppyAction), for: UIControl.Event.touchUpInside)
        
        walletHeadView?.rollOutBtn?.addTarget(self, action: #selector(rollOutAction), for: UIControl.Event.touchUpInside)
        
        walletHeadView?.rollInBtn?.addTarget(self, action: #selector(rollInAction), for: UIControl.Event.touchUpInside)
        
        let layout = UICollectionViewFlowLayout.init()
        walletDetailCV = WalletDetailCollectionView.init(frame: CGRect.init(x: 0, y: walletHeadView!.frame.origin.y+walletHeadView!.frame.size.height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-walletHeadView!.frame.origin.y-walletHeadView!.frame.size.height), collectionViewLayout: layout)
        walletDetailCV?.refreshDelegate = self
        self.view.addSubview(walletDetailCV!)
        
        noneView = SnailNoneView.init(frame: CGRect.init(x: 0, y: 0, width: walletDetailCV!.frame.size.width, height: walletDetailCV!.frame.size.height))
        noneView?.isHidden = true
        walletDetailCV?.addSubview(noneView!)
        
        walletDetailCV!.walletDetailHandel = {(dataModel) in
            let detailVC = RecordDetailViewController.init()
            detailVC.dataModel = dataModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        updateWalletBalance()
        tradeRecordList()
    }
    
    func tradeRecordList() {
        BusinessEngine.init().getWalletRecord(walletAddress: walletAddress!, pageNum: "1", successResponse: { (baseModel) in
            self.walletDetailCV?.mj_header!.endRefreshing()
            let recordModel:TradeRecordModel = baseModel as! TradeRecordModel
            if recordModel.data != nil {
                if recordModel.data?.count == 0 {
                    self.noneView?.isHidden = false
                } else {
                    self.noneView?.isHidden = true
                }
                self.walletDetailCV?.recordList = NSMutableArray.init(array: recordModel.data!)
            } else {
                self.noneView?.isHidden = false
            }
            self.walletDetailCV?.reloadData()
        }) { (baseModel) in
            self.noneView?.isHidden = false
            self.walletDetailCV?.mj_header!.endRefreshing()
        }
    }

    func updateWalletBalance() {
        BusinessEngine.init().updateLinkWallet(walletAddress: walletAddress!, successResponse: { (baseModel) in
            let walletModel : WalletModel = baseModel as! WalletModel
            var balance = "0"
            if walletModel.data != nil {
                balance = walletModel.data!.balance!
            }
            self.walletHeadView?.walletDwnLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: balance, b: TOKEN_RATIO), decimal: 2)
        }) { (baseModel) in
            
        }
    }
    
    @objc func coppyAction(sender:UIButton) {
        UIPasteboard.general.string = BusinessEngine.init().getLoginUserModel().wallet_address
        showTextToast(text: "复制成功!!", view: self.view)
    }
    
    @objc func rollOutAction(sender:UIButton) {
        let rollOutVC = RollOutViewController.init()
        self.navigationController?.pushViewController(rollOutVC, animated: true)
    }
    
    @objc func rollInAction(sender:UIButton) {
        let rollInVC = RollInViewController.init()
        self.navigationController?.pushViewController(rollInVC, animated: true)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func rightImageAction(sender: UIButton) {
        let moreDialog = MorePushDialog.init()
        moreDialog.show()
        moreDialog.morePushHandel = {(tag) in
            if tag == 1 {
                let rightDetailVC = RightDetailViewController.init()
                rightDetailVC.pushType = 3
                self.navigationController?.pushViewController(rightDetailVC, animated: true)
            } else if tag == 2 {
                let secretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: self.userModel?.mobile)
                if secretStr != nil {
                    let magagerThirdVC = SecretMagagerThirdViewController.init()
                    self.navigationController?.pushViewController(magagerThirdVC, animated: true)
                } else {
                    let magagerFirstVC = SecretMagagerFirstViewController.init()
                    self.navigationController?.pushViewController(magagerFirstVC, animated: true)
                }
                
            } else {
                let replaceNoteVC = ReplacePurseNoteViewController.init()
                self.navigationController?.pushViewController(replaceNoteVC, animated: true)
            }
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
