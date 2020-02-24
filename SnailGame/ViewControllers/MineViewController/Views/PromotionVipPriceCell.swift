//
//  PromotionVipPriceCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol PromotionVipPriceDelegate {
    func promotionVipPriceAction(opera:Int)
}

class PromotionVipPriceCell: UICollectionViewCell {
    
    var vipPriceLbl , offersLbl , originalPriceLbl : UILabel?
    
    var priceDelegate : PromotionVipPriceDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: self.frame.size.height))
        barView.backgroundColor = UIColor.white
        barView.layer.cornerRadius = 10
        barView.layer.masksToBounds = true
        self.addSubview(barView)
        
        let oneIcon = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 34*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        oneIcon.image = UIImage.init(named: "ic_promotion_vip_one")
        barView.addSubview(oneIcon)
        
        vipPriceLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 24*PROSIZE, width: 50*PROSIZE, height: 23*PROSIZE))
        vipPriceLbl?.textColor = colorWithHex(hex: 0x333333)
        vipPriceLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        barView.addSubview(vipPriceLbl!)
        
        offersLbl = UILabel.init(frame: CGRect.init(x: vipPriceLbl!.frame.origin.x+vipPriceLbl!.frame.size.width+11*PROSIZE, y: 30*PROSIZE, width: 56*PROSIZE, height: 15*PROSIZE))
        offersLbl?.textAlignment = NSTextAlignment.center
        offersLbl?.text = "限时优惠"
        offersLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        offersLbl?.textColor = UIColor.white
        offersLbl?.backgroundColor = colorWithHex(hex: 0xFF0F59)
        offersLbl?.layer.cornerRadius = 2
        offersLbl?.layer.masksToBounds = true
        barView.addSubview(offersLbl!)
        
        originalPriceLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 51*PROSIZE, width: barView.frame.size.width - 75*PROSIZE, height: 14*PROSIZE))
        originalPriceLbl?.textColor = colorWithHex(hex: 0x999999)
        originalPriceLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        barView.addSubview(originalPriceLbl!)
        
        let openBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        openBtn.frame = CGRect.init(x: 20*PROSIZE, y: 85*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        openBtn.setTitle("立即开通", for: UIControl.State.normal)
        openBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        openBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        openBtn.backgroundColor = colorWithHex(hex: 0x0077FF)
        openBtn.layer.cornerRadius = 5
        openBtn.layer.masksToBounds = true
        openBtn.addTarget(self, action: #selector(openAction), for: UIControl.Event.touchUpInside)
        barView.addSubview(openBtn)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: openBtn.frame.origin.y+openBtn.frame.size.height+30*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let twoIcon = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        twoIcon.image = UIImage.init(named: "ic_promotion_vip_two")
        barView.addSubview(twoIcon)
        
        let twoTitleLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: 120*PROSIZE, height: 20*PROSIZE))
        twoTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        twoTitleLbl.text = "财大气粗获得"
        twoTitleLbl.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(twoTitleLbl)
        
        let getTitleLbl = UILabel.init(frame: CGRect.init(x: barView.frame.size.width-100*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: 80*PROSIZE, height: 20*PROSIZE))
        getTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        getTitleLbl.text = "如何获取"
        getTitleLbl.textColor = colorWithHex(hex: 0x0077FF)
        getTitleLbl.textAlignment = NSTextAlignment.right
        barView.addSubview(getTitleLbl)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: twoIcon.frame.origin.y+twoIcon.frame.size.height+15*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+10*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 43*PROSIZE))
        promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        promptTitleLbl.textColor = colorWithHex(hex: 0x0077FF)
        promptTitleLbl.numberOfLines = 0
        barView.addSubview(promptTitleLbl)
        let promptAttrStr = NSMutableAttributedString.init(string: "如您符合“财大气粗获得”条件，您购买的VIP 有效期将不会消耗。详细规则")
        promptAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x999999), range:NSRange.init(location:0, length: 32))
        promptTitleLbl.attributedText = promptAttrStr
        
        let ruleBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        ruleBtn.frame = CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+15*PROSIZE, width: barView.frame.size.width, height: 80*PROSIZE)
        ruleBtn.addTarget(self, action: #selector(ruleAction), for: UIControl.Event.touchUpInside)
        barView.addSubview(ruleBtn)
        
    }
    
    func setPromotionVipPriceCell(infoModel:VipInfoDataModel) {
        let priceStr = KeepSomeDecimal(num: calculateAChuyiB(a: (infoModel.price)!, b: TOKEN_RATIO), decimal: 2)
        let priceShowStr = priceStr + " DWN/年"
        let priceSize = NSString.calStrSize(textStr: priceShowStr as NSString, height: 23*PROSIZE, fontSize: 24*PROSIZE)
        vipPriceLbl?.frame.size.width = priceSize.width
        let priceAttrStr = NSMutableAttributedString.init(string: priceShowStr)
        priceAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xFF0F59), range:NSRange.init(location:0, length: priceStr.count))
        vipPriceLbl?.attributedText = priceAttrStr
        offersLbl?.frame.origin.x = vipPriceLbl!.frame.origin.x+vipPriceLbl!.frame.size.width+11*PROSIZE
    
        let originalPriceStr = KeepSomeDecimal(num: calculateAChuyiB(a: (infoModel.price_old)!, b: TOKEN_RATIO), decimal: 2) + " DWN/年"
        let originalAttrStr = NSMutableAttributedString.init(string: originalPriceStr)
        originalAttrStr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber.init(value: 1), range:NSRange.init(location:0, length: originalAttrStr.length))
        originalPriceLbl?.attributedText = originalAttrStr
    }
    
    @objc func openAction(sender:UIButton) {
        priceDelegate?.promotionVipPriceAction(opera: 1)
    }
    
    @objc func ruleAction(sender:UIButton) {
        priceDelegate?.promotionVipPriceAction(opera: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
