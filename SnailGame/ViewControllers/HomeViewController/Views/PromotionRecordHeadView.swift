//
//  PromotionRecordHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionRecordHeadView: UIView {
    
    var inviteNumLbl , phaseNameLbl , detailInfoLbl : UILabel?
    
    var introduceBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 130*PROSIZE))
        bg.image = UIImage.init(named: "ic_promotio_record_bg")
        self.addSubview(bg)
        
        inviteNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 39*PROSIZE, width: 116*PROSIZE, height: 29*PROSIZE))
        inviteNumLbl?.textColor = UIColor.white
        inviteNumLbl?.font = UIFont.systemFont(ofSize: 40*PROSIZE)
        inviteNumLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(inviteNumLbl!)
        
        phaseNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 81*PROSIZE, width: 116*PROSIZE, height: 13*PROSIZE))
        phaseNameLbl?.textColor = UIColor.white
        phaseNameLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        phaseNameLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(phaseNameLbl!)
        
        detailInfoLbl = UILabel.init(frame: CGRect.init(x: 152*PROSIZE, y: 20*PROSIZE, width: 190*PROSIZE, height: 94*PROSIZE))
        detailInfoLbl?.textColor = colorWithHex(hex: 0x333333)
        detailInfoLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        detailInfoLbl?.numberOfLines = 0
        self.addSubview(detailInfoLbl!)
        
        let titleBarView = UIView.init(frame: CGRect.init(x: 0, y: bg.frame.size.height, width: self.frame.size.width, height: 37*PROSIZE))
        titleBarView.backgroundColor = UIColor.white
        self.addSubview(titleBarView)
        
        let userTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 120*PROSIZE, height: 12*PROSIZE))
        userTitleLbl.text = "一级用户/注册时间"
        userTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        userTitleLbl.textColor = colorWithHex(hex: 0x999999)
        titleBarView.addSubview(userTitleLbl)
        
        let benefitTitleLbl = UILabel.init(frame: CGRect.init(x: 200*PROSIZE, y: 17*PROSIZE, width: 83*PROSIZE, height: 12*PROSIZE))
        benefitTitleLbl.text = "受益用户"
        benefitTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        benefitTitleLbl.textColor = colorWithHex(hex: 0x999999)
        benefitTitleLbl.textAlignment = NSTextAlignment.right
        titleBarView.addSubview(benefitTitleLbl)
        
        let earnTitleLbl = UILabel.init(frame: CGRect.init(x: 300*PROSIZE, y: 17*PROSIZE, width: 40*PROSIZE, height: 12*PROSIZE))
        earnTitleLbl.text = "收益"
        earnTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        earnTitleLbl.textColor = colorWithHex(hex: 0x999999)
        earnTitleLbl.textAlignment = NSTextAlignment.right
        titleBarView.addSubview(earnTitleLbl)
        
        let earnIcon = UIImageView.init(frame: CGRect.init(x: earnTitleLbl.frame.origin.x+earnTitleLbl.frame.size.width+4*PROSIZE, y: 16*PROSIZE, width: 14*PROSIZE, height: 14*PROSIZE))
        earnIcon.image = UIImage.init(named: "ic_region_warn")
        titleBarView.addSubview(earnIcon)
        
        introduceBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        introduceBtn?.frame = CGRect.init(x: 300*PROSIZE, y: 0, width: titleBarView.frame.size.width-300*PROSIZE, height: titleBarView.frame.size.height)
        titleBarView.addSubview(introduceBtn!)
    }
    
    func setPromotionRecordHeadView(dataModel:PromotionRecordDataModel) {
        inviteNumLbl?.text = String(dataModel.member_num!)
        if dataModel.member_num == 0 {
            phaseNameLbl?.text = "能量聚集"
            detailInfoLbl?.text = "还没有任何推广奖励，好东西和好朋友分享。\n马上推荐给好友吧！"
        } else if dataModel.member_num! < 10 {
            phaseNameLbl?.text = "初露锋芒"
            let reward = KeepSomeDecimal(num: calculateAChuyiB(a: String((dataModel.award_num)!), b: TOKEN_RATIO), decimal: 2)
            detailInfoLbl?.text = "推广收益 " + reward + " DWN，人数 " + String.init(dataModel.member_num!) + " 人。其中直接推广 " + String.init(dataModel.member_first_num!) + " 人。\n你肯定不止这些能量！"
        } else {
            phaseNameLbl?.text = "初露锋芒"
            let reward = KeepSomeDecimal(num: calculateAChuyiB(a: String((dataModel.award_num)!), b: TOKEN_RATIO), decimal: 2)
            detailInfoLbl?.text = "推广收益 " + reward + " DWN，人数 " + String.init(dataModel.member_num!) + " 人。其中直接推广 " + String.init(dataModel.member_first_num!) + " 人。\n人脉相当了得！"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
