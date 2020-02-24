//
//  OpenVipHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class OpenVipHeadView: UIView {

    var vipPriceLbl , offersLbl , originalPriceLbl , communityTitleName , communityDwnLbl : UILabel?
    
    var communityImageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let serviceTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 14*PROSIZE))
        serviceTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        serviceTitleLbl.textColor = colorWithHex(hex: 0x999999)
        serviceTitleLbl.text = "VIP服务"
        self.addSubview(serviceTitleLbl)
        
        let vipBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 36*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 110*PROSIZE))
        vipBarView.layer.cornerRadius = 10
        vipBarView.layer.masksToBounds = true
        vipBarView.backgroundColor = colorWithHex(hex: 0xFFDFE9)
        self.addSubview(vipBarView)
        
        let vipTitleLbl = UILabel.init(frame: CGRect.init(x: 21*PROSIZE, y: 20*PROSIZE, width: vipBarView.frame.size.width-42*PROSIZE, height: 16*PROSIZE))
        vipTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        vipTitleLbl.textColor = colorWithHex(hex: 0x333333)
        vipTitleLbl.text = "蜗牛VIP"
        vipBarView.addSubview(vipTitleLbl)
        
        vipPriceLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 51*PROSIZE, width: 50*PROSIZE, height: 23*PROSIZE))
        vipPriceLbl?.textColor = colorWithHex(hex: 0x333333)
        vipPriceLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        vipBarView.addSubview(vipPriceLbl!)
        
        offersLbl = UILabel.init(frame: CGRect.init(x: vipPriceLbl!.frame.origin.x+vipPriceLbl!.frame.size.width+7*PROSIZE, y: 53*PROSIZE, width: 56*PROSIZE, height: 15*PROSIZE))
        offersLbl?.textAlignment = NSTextAlignment.center
        offersLbl?.text = "限时优惠"
        offersLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        offersLbl?.textColor = UIColor.white
        offersLbl?.backgroundColor = colorWithHex(hex: 0xFF0F59)
        offersLbl?.layer.cornerRadius = 2
        offersLbl?.layer.masksToBounds = true
        vipBarView.addSubview(offersLbl!)
        
        originalPriceLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 75*PROSIZE, width: vipBarView.frame.size.width - 40*PROSIZE, height: 14*PROSIZE))
        originalPriceLbl?.textColor = colorWithHex(hex: 0x999999)
        originalPriceLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        vipBarView.addSubview(originalPriceLbl!)
        
        let payTitleLbl = UILabel.init(frame: CGRect.init(x: 21*PROSIZE, y: vipBarView.frame.origin.y+vipBarView.frame.size.height+29*PROSIZE, width: self.frame.size.width-42*PROSIZE, height: 14*PROSIZE))
        payTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        payTitleLbl.textColor = colorWithHex(hex: 0x999999)
        payTitleLbl.text = "支付方式"
        self.addSubview(payTitleLbl)
        
        let payBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: payTitleLbl.frame.origin.y+payTitleLbl.frame.size.height+13*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 66*PROSIZE))
        payBarView.layer.borderWidth = 1
        payBarView.layer.borderColor = colorWithHex(hex: 0xDDDDDD).cgColor
        payBarView.layer.cornerRadius = 10
        payBarView.layer.masksToBounds = true
        self.addSubview(payBarView)
        
        communityImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 21*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE))
        payBarView.addSubview(communityImageView!)
        
        communityTitleName = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 18*PROSIZE, width: payBarView.frame.size.width - 75*PROSIZE, height: 16*PROSIZE))
        communityTitleName?.textColor = colorWithHex(hex: 0x333333)
        communityTitleName?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        communityTitleName?.text = "社区"
        payBarView.addSubview(communityTitleName!)
        
        communityDwnLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 37*PROSIZE, width: payBarView.frame.size.width - 75*PROSIZE, height: 11*PROSIZE))
        communityDwnLbl?.textColor = colorWithHex(hex: 0x999999)
        communityDwnLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        communityDwnLbl?.text = "可用：1623 DWN"
        payBarView.addSubview(communityDwnLbl!)
    
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
