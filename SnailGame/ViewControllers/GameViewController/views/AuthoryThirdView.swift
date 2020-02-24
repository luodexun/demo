//
//  AuthoryThirdView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AuthoryThirdView: UIView {
    
    var logoIcon : UIImageView?
    
    var appNameLbl : UILabel?
    
    var agreeBtn , refuseBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        logoIcon = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-80*PROSIZE)/2, y: 56*PROSIZE, width: 80*PROSIZE, height: 80*PROSIZE))
        self.addSubview(logoIcon!)
        
        appNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (logoIcon?.frame.origin.y)!+(logoIcon?.frame.size.height)!+12*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 24*PROSIZE))
        appNameLbl?.textAlignment = .center
        appNameLbl?.textColor = colorWithHex(hex: 0x333333)
        appNameLbl?.font = UIFont.boldSystemFont(ofSize: 22*PROSIZE)
        self.addSubview(appNameLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 41*PROSIZE, y: (appNameLbl?.frame.origin.y)!+(appNameLbl?.frame.size.height)!+31*PROSIZE, width: self.frame.size.width-82*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let authoryTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: line.frame.origin.y+line.frame.size.height+32*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 21*PROSIZE))
        authoryTitleLbl.textAlignment = .center
        authoryTitleLbl.textColor = colorWithHex(hex: 0x333333)
        authoryTitleLbl.font = UIFont.boldSystemFont(ofSize: 15*PROSIZE)
        authoryTitleLbl.text = "你正授权第三方应用"
        self.addSubview(authoryTitleLbl)
        
        let authoryDescLbl = UILabel.init(frame: CGRect.init(x: 40*PROSIZE, y: authoryTitleLbl.frame.origin.y+authoryTitleLbl.frame.size.height+21*PROSIZE, width: self.frame.size.width-80*PROSIZE, height: 63*PROSIZE))
        authoryDescLbl.textColor = colorWithHex(hex: 0x999999)
        authoryDescLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        authoryDescLbl.numberOfLines = 0
        authoryDescLbl.text = "你在第三方应用上的使用行为将适用该应用的《用户协议》和《隐私政策》，由该应用直接并单独向你承担责任。"
        self.addSubview(authoryDescLbl)
        
        agreeBtn = UIButton.init(type: .roundedRect)
        agreeBtn?.frame = CGRect.init(x: (self.frame.size.width-166*PROSIZE)/2, y: authoryDescLbl.frame.origin.y+authoryDescLbl.frame.size.height+86*PROSIZE, width: 166*PROSIZE, height: 36*PROSIZE)
        agreeBtn?.setTitle("同意授权", for: .normal)
        agreeBtn?.setTitleColor(UIColor.white, for: .normal)
        agreeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        agreeBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        agreeBtn?.layer.cornerRadius = 4
        agreeBtn?.layer.masksToBounds = true
        self.addSubview(agreeBtn!)
        
        refuseBtn = UIButton.init(type: .roundedRect)
        refuseBtn?.frame = CGRect.init(x: (self.frame.size.width-166*PROSIZE)/2, y: (agreeBtn?.frame.origin.y)!+(agreeBtn?.frame.size.height)!+21*PROSIZE, width: 166*PROSIZE, height: 36*PROSIZE)
        refuseBtn?.setTitle("拒绝授权", for: .normal)
        refuseBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: .normal)
        refuseBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        refuseBtn?.backgroundColor = colorWithHex(hex: 0xF4F4F4)
        refuseBtn?.layer.cornerRadius = 4
        refuseBtn?.layer.masksToBounds = true
        self.addSubview(refuseBtn!)
        
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
