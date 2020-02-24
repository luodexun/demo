//
//  WealthViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WealthViewController: BaseViewController , collectionRefreshDelegate {
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var wealthCV : WealthCollectionView?
    
    var userModel : UserLoginDataModel?
    
    var walletAmount : String?
    
    var ethRatio = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initViews()
        ethToDwn()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        walletAmount = BusinessEngine.init().getLinkWalletBalance()
        userModel = BusinessEngine.init().getLoginUserModel()
        updateTreasureInfo()
    }
    
    func initViews() {
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT/2))
        barView.backgroundColor = colorWithHex(hex: 0xEE9138)
        self.view.addSubview(barView)
        
        let layout = UICollectionViewFlowLayout.init()
        wealthCV = WealthCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        wealthCV?.refreshDelegate = self
        self.view.addSubview(wealthCV!)
        
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT, width: 44, height: 44));
        backBtn.setImage(UIImage.init(named: "ic_back_white"), for: UIControl.State.normal);
        backBtn.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside);
        self.view.addSubview(backBtn);
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 60, y: STABAR_HEIGHT, width: SCREEN_WIDE-120, height: 44));
        titleNameLbl.textColor = UIColor.white;
        titleNameLbl.font = UIFont.systemFont(ofSize: 17);
        titleNameLbl.text = "数字资产";
        titleNameLbl.textAlignment = NSTextAlignment.center;
        self.view.addSubview(titleNameLbl);
        
        wealthCV?.wealthCandyHandel = {(opera) in
            if opera == 1 {
                let mineCandyVC = MineCandyViewController.init()
                self.navigationController?.pushViewController(mineCandyVC, animated: true)
            } else {
                let exchangeVC = CandyExchangeViewController.init()
                self.navigationController?.pushViewController(exchangeVC, animated: true)
            }
        }
        
        wealthCV?.wealthDwnHandel = {(opera) in
            if opera == 1 {
                let communityWealthVC = CommunityWealthViewController.init()
                self.navigationController?.pushViewController(communityWealthVC, animated: true)
            } else if opera == 2 {
                let depositCommunityVC = DepositCommunityViewController.init()
                self.navigationController?.pushViewController(depositCommunityVC, animated: true)
            } else {
                let drawWalletVC = DrawWalletViewController.init()
                self.navigationController?.pushViewController(drawWalletVC, animated: true)
            }
        }
        
        wealthCV?.wealthEthHandel = {(opera) in
            if opera == 1 {
                let EthCenterVC = EthCenterViewController.init()
                self.navigationController?.pushViewController(EthCenterVC, animated: true)
            } else if opera == 2 {
                let depositEthVC = DepositEthViewController.init()
                self.navigationController?.pushViewController(depositEthVC, animated: true)
            } else {
                let exchangeEthVC = ExchangeEthViewController.init()
                self.navigationController?.pushViewController(exchangeEthVC, animated: true)
            }
        }
        
        wealthCV?.wealthWalletHandel = {(opera) in
           let walletDetailVC = WalletDetailViewController.init()
           self.navigationController?.pushViewController(walletDetailVC, animated: true)
        }
        
    }
    
    func collectionRefreshAction(collectionView: UICollectionView) {
        showLoading(view: self.view)
        getUserInfo()
    }
    
    func ethToDwn() {
        BusinessEngine.init().ethToDwn(successResponse: { (baseModel) in
            let ratioModel = baseModel as! EthRatioModel
            self.ethRatio = ratioModel.data!.ratio!
            self.updateTreasureInfo()
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            let loginModel = BaseModel as! UserLoginModel
            self.userModel = loginModel.data
            self.updateLinkWallet(walletAddress: loginModel.data!.wallet_address!)
        }) { (BaseModel) in
            self.wealthCV?.mj_header!.endRefreshing()
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func updateLinkWallet(walletAddress:String) {
        BusinessEngine.init().updateLinkWallet(walletAddress: walletAddress, successResponse: { (BaseModel) in
            self.wealthCV?.mj_header!.endRefreshing()
            self.view.hideToastActivity()
            let walletModel : WalletModel = BaseModel as! WalletModel
            var balance = "0"
            if walletModel.data != nil {
                balance = walletModel.data!.balance!
            }
            self.walletAmount = balance
            self.updateTreasureInfo()
        }) { (BaseModel) in
            self.wealthCV?.mj_header!.endRefreshing()
            self.view.hideToastActivity()
        }
    }
    
    func updateTreasureInfo() {
        var eth = "0"
        if userModel?.currency?.count != 0 {
            eth = calculateAChuyiB(a: (userModel?.currency![0].balance)!, b: ETH_RATIO)
        }
        let walletDwn = calculateAChuyiB(a: walletAmount!, b: TOKEN_RATIO)
        let communityDwn = calculateAChuyiB(a: self.userModel!.token!, b: TOKEN_RATIO)
        let monthDwn = calculateAChuyiB(a: self.userModel!.profit!, b: TOKEN_RATIO)
        if ethRatio != "0" {
            let totalToken = calculateAJiaB(a: walletAmount!, b: self.userModel!.token!)
            let ratio = calculateAChuyiB(a: self.userModel!.ratio!, b: TOKEN_RATIO)
            let totalDwn = calculateAJiaB(a: calculateAChuyiB(a: totalToken, b: TOKEN_RATIO), b: calculateAChengyiB(a: eth, b: ethRatio))
            let totalRmb = calculateAChengyiB(a: totalDwn, b: ratio)
            wealthCV?.totalDwn = KeepSomeDecimal(num: totalDwn, decimal: 2)
            wealthCV?.totalRmb = KeepSomeDecimal(num: totalRmb, decimal: 2)
            
        }
        wealthCV?.candyNum = userModel!.candy!
        wealthCV?.walletDwn = KeepSomeDecimal(num: walletDwn, decimal: 2)
        wealthCV?.communityDwn = KeepSomeDecimal(num: communityDwn, decimal: 2)
        wealthCV?.monthDwn = KeepSomeDecimal(num: monthDwn, decimal: 2)
        wealthCV?.ethNum = KeepSomeDecimal(num: eth, decimal: 8)
        wealthCV?.reloadData()
    }

    @objc func backAction(sender:UIButton) {
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
