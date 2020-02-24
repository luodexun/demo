//
//  CandyExchangeInvalidView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/4.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CandyExchangeInvalidView: UIScrollView {
    
    var amountNumLbl : UILabel?
    
    var timeBarView , useBarView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let amountBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 100*PROSIZE))
        amountBarView.backgroundColor = UIColor.white
        self.addSubview(amountBarView)
        
        let amountTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 14*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 21*PROSIZE))
        amountTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        amountTitleLbl.text = "我的糖果总数"
        amountTitleLbl.textColor = colorWithHex(hex: 0x333333)
        amountBarView.addSubview(amountTitleLbl)
        
        amountNumLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 45*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 35*PROSIZE))
        amountNumLbl?.textColor = colorWithHex(hex: 0x333333)
        amountNumLbl?.font = UIFont.systemFont(ofSize: 35*PROSIZE)
        amountBarView.addSubview(amountNumLbl!)
        
        timeBarView = UIView.init(frame: CGRect.init(x: 0, y: amountBarView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE, height: 392*PROSIZE))
        timeBarView?.isHidden = true
        timeBarView?.backgroundColor = UIColor.white
        self.addSubview(timeBarView!)
        
        let timeIcon = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-210*PROSIZE)/2, y: 83*PROSIZE, width: 210*PROSIZE, height: 179*PROSIZE))
        timeIcon.image = UIImage.init(named: "ic_candy_exchange_time")
        timeBarView?.addSubview(timeIcon)
        
        let timeTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: timeIcon.frame.origin.y+timeIcon.frame.size.height+24*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 24*PROSIZE))
        timeTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        timeTitleLbl.text = "还未到兑换时间"
        timeTitleLbl.textColor = colorWithHex(hex: 0xFF1059)
        timeTitleLbl.textAlignment = .center
        timeBarView?.addSubview(timeTitleLbl)
        
        useBarView = UIView.init(frame: CGRect.init(x: 0, y: amountBarView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE, height: 392*PROSIZE))
        useBarView?.backgroundColor = UIColor.white
        self.addSubview(useBarView!)
        
        let useIcon = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-96*PROSIZE)/2, y: 110*PROSIZE, width: 96*PROSIZE, height: 96*PROSIZE))
        useIcon.image = UIImage.init(named: "ic_candy_exchange_use")
        useBarView?.addSubview(useIcon)
        
        let useTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: useIcon.frame.origin.y+useIcon.frame.size.height+24*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 24*PROSIZE))
        useTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        useTitleLbl.text = "您已兑完本次可用额度"
        useTitleLbl.textColor = colorWithHex(hex: 0xFF1059)
        useTitleLbl.textAlignment = .center
        useBarView?.addSubview(useTitleLbl)
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        let ruleSize = NSString.calStrSize(textStr: configModel!.candy_exchange_rule! as NSString, width: SCREEN_WIDE-36*PROSIZE, fontSize: 14*PROSIZE)
        let ruleTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: (timeBarView?.frame.origin.y)!+(timeBarView?.frame.size.height)!+20*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: ruleSize.height))
        ruleTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        ruleTitleLbl.text = configModel!.candy_exchange_rule!
        ruleTitleLbl.textColor = colorWithHex(hex: 0x333333)
        ruleTitleLbl.numberOfLines = 0
        self.addSubview(ruleTitleLbl)
        
        self.contentSize = CGSize.init(width: SCREEN_WIDE, height: ruleTitleLbl.frame.origin.y+ruleTitleLbl.frame.size.height+26*PROSIZE)
    }
    
    required init?(coder: NSCoder) {
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
