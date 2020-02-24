//
//  OpenVipFootView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class OpenVipFootView: UIView {

    var payBtn , connectBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        payBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        payBtn?.frame = CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 50*PROSIZE)
        payBtn?.setTitle("立即支付", for: UIControl.State.normal)
        payBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        payBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        payBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        payBtn?.layer.cornerRadius = 5
        payBtn?.layer.masksToBounds = true
        self.addSubview(payBtn!)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 80*PROSIZE, width: self.frame.size.width, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(line)
        
        let getTitleLbl = UILabel.init(frame: CGRect.init(x: 24*PROSIZE, y: line.frame.origin.y+line.frame.size.height+20*PROSIZE, width: self.frame.size.width-48*PROSIZE, height: 15*PROSIZE))
        getTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        getTitleLbl.textColor = colorWithHex(hex: 0xFF0F59)
        getTitleLbl.text = "如何快速获取DWN？"
        self.addSubview(getTitleLbl)
        
        let getDescLbl = UILabel.init(frame: CGRect.init(x: 24*PROSIZE, y: line.frame.origin.y+line.frame.size.height+50*PROSIZE, width: self.frame.size.width-48*PROSIZE, height: 90*PROSIZE))
        getDescLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        getDescLbl.textColor = colorWithHex(hex: 0x333333)
        getDescLbl.text = "DWN是已经上线交易所的数字货币。\n您可以从ZG交易所直接购买您所需的DWN。\n\n如您需要进一步的帮助，请联系我们的在线客服：微信号：digi-snail2"
        getDescLbl.numberOfLines = 0
        self.addSubview(getDescLbl)
        
        let connectTitleLbl = UILabel.init(frame: CGRect.init(x: 24*PROSIZE, y: getDescLbl.frame.origin.y+getDescLbl.frame.size.height+10*PROSIZE, width: self.frame.size.width-48*PROSIZE, height: 15*PROSIZE))
        connectTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        connectTitleLbl.textColor = colorWithHex(hex: 0x0077FF)
        connectTitleLbl.text = "联系客服"
        self.addSubview(connectTitleLbl)
        
        connectBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        connectBtn?.frame = CGRect.init(x: 24*PROSIZE, y: getDescLbl.frame.origin.y+getDescLbl.frame.size.height, width: self.frame.size.width-48*PROSIZE, height: 35*PROSIZE)
        self.addSubview(connectBtn!)
        
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
