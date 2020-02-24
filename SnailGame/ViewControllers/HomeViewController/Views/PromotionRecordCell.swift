//
//  PromotionRecordCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionRecordCell: UICollectionViewCell {
    
    var userNameLbl ,createTimeLbl , benefitUserNumLbl , earnDwnLbl : UILabel?
    
    var certifiedImageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: 48*PROSIZE, height: 18*PROSIZE))
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        userNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(userNameLbl!)
        
        certifiedImageView = UIImageView.init(frame: CGRect.init(x: userNameLbl!.frame.origin.x + userNameLbl!.frame.size.width + 6*PROSIZE, y: 12*PROSIZE, width: 50*PROSIZE, height: 15*PROSIZE))
        certifiedImageView?.isHidden = true
        certifiedImageView?.image = UIImage.init(named: "ic_promotion_certified")
        self.addSubview(certifiedImageView!)
        
        createTimeLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 33*PROSIZE, width: 160*PROSIZE, height: 14*PROSIZE))
        createTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        createTimeLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(createTimeLbl!)
        
        benefitUserNumLbl = UILabel.init(frame: CGRect.init(x: 205*PROSIZE, y: 10*PROSIZE, width: 80*PROSIZE, height: 35*PROSIZE))
        benefitUserNumLbl?.textColor = colorWithHex(hex: 0x333333)
        benefitUserNumLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        benefitUserNumLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(benefitUserNumLbl!)
        
        earnDwnLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-80*PROSIZE, y: 10*PROSIZE, width: 60*PROSIZE, height: 35*PROSIZE))
        earnDwnLbl?.textColor = colorWithHex(hex: 0xff7700)
        earnDwnLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        earnDwnLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(earnDwnLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 54*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setPromotionRecordCell(listModel:PromotionRecordListModel) {
        let nickSize = NSString.calStrSize(textStr: listModel.nickname! as NSString, height: 14*PROSIZE, fontSize: 15*PROSIZE)
        userNameLbl?.frame.size.width = nickSize.width
        userNameLbl?.text = listModel.nickname
        if listModel.is_certified == 1 {
            certifiedImageView?.isHidden = false
            certifiedImageView?.frame.origin.x = userNameLbl!.frame.origin.x + userNameLbl!.frame.size.width + 6*PROSIZE
        } else {
            certifiedImageView?.isHidden = true
        }
        createTimeLbl?.text = intervalSinceNow(stamp: String(listModel.create_time!))
        benefitUserNumLbl?.text = String(listModel.members!)+"人"
        if listModel.sum_award != 0 {
            earnDwnLbl?.textColor = colorWithHex(hex: 0x333333)
            earnDwnLbl?.text = "+"+KeepSomeDecimal(num: calculateAChuyiB(a: String((listModel.sum_award)!), b: TOKEN_RATIO), decimal: 2)
        } else {
            earnDwnLbl?.textColor = colorWithHex(hex: 0x333333)
            earnDwnLbl?.text = "0.00"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
