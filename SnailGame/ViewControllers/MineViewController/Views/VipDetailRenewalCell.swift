//
//  VipDetailRenewalCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol VipDetailRenewalDelegate {
    func vipDetailRenewalAction()
    func vipRightRuleAction()
}

class VipDetailRenewalCell: UICollectionViewCell {
    
    var deepObtainLbl , remainDateLbl : UILabel?
    
    var obtainImageView , remainImageView : UIImageView?
    
    var renewalBtn : UIButton?
    
    var renewalDelegate : VipDetailRenewalDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: self.frame.size.height))
        barView.backgroundColor = UIColor.white
        barView.layer.cornerRadius = 10
        barView.layer.masksToBounds = true
        self.addSubview(barView)
    
        obtainImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 25*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        barView.addSubview(obtainImageView!)
        
        deepObtainLbl = UILabel.init(frame: CGRect.init(x: 48*PROSIZE, y: 25*PROSIZE, width: barView.frame.size.width-68*PROSIZE, height: 20*PROSIZE))
        deepObtainLbl?.textColor = colorWithHex(hex: 0x333333)
        deepObtainLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        deepObtainLbl?.text = "财大气粗获得"
        barView.addSubview(deepObtainLbl!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 60*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(fstLine)
        
        remainImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        barView.addSubview(remainImageView!)
        
        remainDateLbl = UILabel.init(frame: CGRect.init(x: 48*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: barView.frame.size.width-118*PROSIZE, height: 20*PROSIZE))
        remainDateLbl?.textColor = colorWithHex(hex: 0x333333)
        remainDateLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        barView.addSubview(remainDateLbl!)
        
        renewalBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        renewalBtn?.frame = CGRect.init(x: barView.frame.size.width-70*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: 70*PROSIZE, height: 20*PROSIZE)
        renewalBtn?.setTitle("续费", for: UIControl.State.normal)
        renewalBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        renewalBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        renewalBtn?.addTarget(self, action: #selector(renewalAction), for: UIControl.Event.touchUpInside)
        barView.addSubview(renewalBtn!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+50*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(secLine)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+10*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 43*PROSIZE))
        promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        promptTitleLbl.textColor = colorWithHex(hex: 0x0077FF)
        promptTitleLbl.numberOfLines = 0
        barView.addSubview(promptTitleLbl)
        let promptAttrStr = NSMutableAttributedString.init(string: "如您符合“财大气粗获得”条件，您购买的VIP 有效期将不会消耗。详细规则")
        promptAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x999999), range:NSRange.init(location:0, length: 32))
        promptTitleLbl.attributedText = promptAttrStr
     
        let ruleBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        ruleBtn.frame = CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+15*PROSIZE, width: barView.frame.size.width, height: 80*PROSIZE)
        ruleBtn.addTarget(self, action: #selector(ruleAction), for: UIControl.Event.touchUpInside)
        barView.addSubview(ruleBtn)
        
    }
    
    func setVipDetailRenewalCell(infoModel:VipInfoDataModel) {
        if infoModel.type == 1 {
            obtainImageView?.image = UIImage.init(named: "ic_vip_detail_open_n")
            remainImageView?.image = UIImage.init(named: "ic_vip_detail_open_y")
        } else if infoModel.type == 2 {
            obtainImageView?.image = UIImage.init(named: "ic_vip_detail_open_y")
            remainImageView?.image = UIImage.init(named: "ic_vip_detail_open_n")
        } else {
            obtainImageView?.image = UIImage.init(named: "ic_vip_detail_open_n")
            remainImageView?.image = UIImage.init(named: "ic_vip_detail_open_n")
        }
        
        remainDateLbl?.text = "已购买·剩余有效"+String(infoModel.effective_days!)+"天"
    }
    
    @objc func renewalAction(sender:UIButton) {
        renewalDelegate?.vipDetailRenewalAction()
    }
    
    @objc func ruleAction(sender:UIButton) {
        renewalDelegate?.vipRightRuleAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
