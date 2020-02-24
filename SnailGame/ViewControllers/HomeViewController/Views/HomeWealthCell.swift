//
//  HomeWealthCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import ASHorizontalScrollView

protocol HomeWealthPushDelegate {
    func homeWealthPushAction(opera:Int)
    func homeWealthUpdateShowAction(isShow:Bool)
}

class HomeWealthCell: UICollectionViewCell {
    
    var totalDwnLbl , totalMoneyLbl : UILabel?
    
    var eyeBtn : UIButton?
    
    var wealthDelegate : HomeWealthPushDelegate?
    
    var isShow : Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 154*PROSIZE+STABAR_HEIGHT))
        bg.image = UIImage.init(named: "ic_home_top_bg")
        bg.contentMode = .scaleAspectFill
        self.addSubview(bg)
        
        let logoIcon = UIImageView.init(frame: CGRect.init(x: 20, y: 25*PROSIZE+STABAR_HEIGHT, width: 25*PROSIZE, height: 20*PROSIZE))
        logoIcon.image = UIImage.init(named: "ic_home_logo")
        self.addSubview(logoIcon)
        
        let appNameLbl = UILabel.init(frame: CGRect.init(x: 51*PROSIZE, y: 25*PROSIZE+STABAR_HEIGHT, width: SCREEN_WIDE-71*PROSIZE, height: 20*PROSIZE))
        appNameLbl.text = "大蜗牛社区"
        appNameLbl.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        appNameLbl.textColor = UIColor.white
        self.addSubview(appNameLbl)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: appNameLbl.frame.size.height+appNameLbl.frame.origin.y+10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 17*PROSIZE))
        titleNameLbl.text = "基于区块链的数字资产社区"
        titleNameLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        titleNameLbl.textColor = UIColor.white
        self.addSubview(titleNameLbl)
        
        let subtitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: titleNameLbl.frame.size.height+titleNameLbl.frame.origin.y+5*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 14*PROSIZE))
        subtitleLbl.text = "安全、平等、价值"
        subtitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        subtitleLbl.textColor = UIColor.white
        self.addSubview(subtitleLbl)
                
        let wealthBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 108*PROSIZE+STABAR_HEIGHT, width: SCREEN_WIDE-40*PROSIZE, height: 84*PROSIZE))
        wealthBarView.backgroundColor = UIColor.white
        wealthBarView.layer.shadowColor = colorWithHex(hex: 0x999999).cgColor
        wealthBarView.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        wealthBarView.layer.shadowOpacity = 0.5
        wealthBarView.layer.shadowRadius = 5
        wealthBarView.layer.cornerRadius = 10
        self.addSubview(wealthBarView)
        
        let totalTitleLbl = UILabel.init(frame: CGRect.init(x: 16*PROSIZE, y: 15*PROSIZE, width: 108*PROSIZE, height: 15*PROSIZE))
        totalTitleLbl.text = "总资产(DWN）"
        totalTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        totalTitleLbl.textColor = colorWithHex(hex: 0x333333)
        wealthBarView.addSubview(totalTitleLbl)
        
        eyeBtn = UIButton.init(type: .custom)
        eyeBtn!.frame = CGRect.init(x: totalTitleLbl.frame.origin.x+totalTitleLbl.frame.size.width, y: 10.5*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE)
        eyeBtn!.setImage(UIImage.init(named: "icon_home_eye_nol"), for: .normal)
        eyeBtn!.addTarget(self, action: #selector(eyeAction), for: .touchUpInside)
        wealthBarView.addSubview(eyeBtn!)

        totalDwnLbl = UILabel.init(frame: CGRect.init(x: 16*PROSIZE, y: 40*PROSIZE, width: 80*PROSIZE, height: 35*PROSIZE))
        totalDwnLbl?.text = "登录/注册"
        totalDwnLbl?.font = UIFont.systemFont(ofSize: 28*PROSIZE)
        totalDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        wealthBarView.addSubview(totalDwnLbl!)
        
        totalMoneyLbl = UILabel.init(frame: CGRect.init(x: (totalDwnLbl?.frame.size.width)!+26*PROSIZE, y: 56*PROSIZE, width: 120*PROSIZE, height: 15*PROSIZE))
        totalMoneyLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        totalMoneyLbl?.textColor = colorWithHex(hex: 0x999999)
        wealthBarView.addSubview(totalMoneyLbl!)
        
        let totalBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        totalBtn.frame = CGRect.init(x: 0, y: 36*PROSIZE, width: wealthBarView.frame.size.width, height: 50*PROSIZE)
        totalBtn.addTarget(self, action: #selector(pushWealthAction), for: UIControl.Event.touchUpInside)
        wealthBarView.addSubview(totalBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHomeWealthCell(totalRmb:String,totalDwn:String,isShow:Bool) {
        self.isShow = isShow
        if isLogin() {
            eyeBtn?.isHidden = false
            if isShow {
                eyeBtn!.setImage(UIImage.init(named: "icon_home_eye_sel"), for: .normal)
                let totalSize = NSString.calStrSize(textStr: totalDwn as NSString, height: 35*PROSIZE, fontSize: 28*PROSIZE)
                totalDwnLbl?.frame.size.width = totalSize.width
                totalDwnLbl?.text = totalDwn
                totalMoneyLbl?.frame.origin.x = totalSize.width+26*PROSIZE
                totalMoneyLbl?.text = "≈ ¥ " + totalRmb
            } else {
                eyeBtn!.setImage(UIImage.init(named: "icon_home_eye_nol"), for: .normal)
                let totalSize = NSString.calStrSize(textStr: "***" as NSString, height: 35*PROSIZE, fontSize: 28*PROSIZE)
                totalDwnLbl?.frame.size.width = totalSize.width
                totalDwnLbl?.text = "***"
                totalMoneyLbl?.frame.origin.x = totalSize.width+26*PROSIZE
                totalMoneyLbl?.text = ""
            }
        } else{
            eyeBtn?.isHidden = true
            let totalSize = NSString.calStrSize(textStr: "登录/注册" as NSString, height: 35*PROSIZE, fontSize: 28*PROSIZE)
            totalDwnLbl?.frame.size.width = totalSize.width
            totalDwnLbl?.text = "登录/注册"
            totalMoneyLbl?.frame.origin.x = totalSize.width+26*PROSIZE
            totalMoneyLbl?.text = ""
        }
    }
    
    @objc func eyeAction(sender:UIButton) {
        if isShow! {
            isShow = false
        } else {
            isShow = true
        }
        wealthDelegate?.homeWealthUpdateShowAction(isShow: isShow!)
    }
    
    @objc func pushWealthAction(sender:UIButton) {
        wealthDelegate?.homeWealthPushAction(opera: 1)
    }
  
    @objc func pushWalletAction(sender:UIButton) {
        wealthDelegate?.homeWealthPushAction(opera: 2)
    }
    
    @objc func pushCommunityAction(sender:UIButton) {
        wealthDelegate?.homeWealthPushAction(opera: 3)
    }
    
    @objc func pushMonthAction(sender:UIButton) {
        wealthDelegate?.homeWealthPushAction(opera: 4)
    }
}
