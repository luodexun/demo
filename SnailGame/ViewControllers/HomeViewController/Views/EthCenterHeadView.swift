//
//  EthCenterHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class EthCenterHeadView: UIView {
    
    var ethNumLbl : UILabel?
    
    var depositBtn , exchangeBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 18*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 15*PROSIZE))
        titleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleLbl.textColor = colorWithHex(hex: 0x999999)
        titleLbl.textAlignment = .center
        titleLbl.text = "ETH"
        self.addSubview(titleLbl)
        
        ethNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: titleLbl.frame.origin.y+titleLbl.frame.size.height+8*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 28*PROSIZE))
        ethNumLbl?.text = "0"
        ethNumLbl?.textColor = colorWithHex(hex: 0xFF7700)
        ethNumLbl?.textAlignment = .center
        ethNumLbl?.font = UIFont.systemFont(ofSize: 28*PROSIZE)
        self.addSubview(ethNumLbl!)
        
        depositBtn = UIButton.init(type: .roundedRect)
        depositBtn?.frame = CGRect.init(x: 70*PROSIZE, y: (ethNumLbl?.frame.origin.y)!+(ethNumLbl?.frame.size.height)!+40*PROSIZE, width: 66*PROSIZE, height: 29*PROSIZE)
        depositBtn?.setTitle("存入", for: .normal)
        depositBtn?.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        depositBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        depositBtn?.layer.borderWidth = 1
        depositBtn?.layer.borderColor = colorWithHex(hex: 0x999999).cgColor
        depositBtn?.layer.cornerRadius = 4
        depositBtn?.layer.masksToBounds = true
        self.addSubview(depositBtn!)
        
        exchangeBtn = UIButton.init(type: .roundedRect)
        exchangeBtn?.frame = CGRect.init(x: SCREEN_WIDE-136*PROSIZE, y: (ethNumLbl?.frame.origin.y)!+(ethNumLbl?.frame.size.height)!+40*PROSIZE, width: 66*PROSIZE, height: 29*PROSIZE)
        exchangeBtn?.setTitle("兑换", for: .normal)
        exchangeBtn?.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        exchangeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        exchangeBtn?.layer.borderWidth = 1
        exchangeBtn?.layer.borderColor = colorWithHex(hex: 0x999999).cgColor
        exchangeBtn?.layer.cornerRadius = 4
        exchangeBtn?.layer.masksToBounds = true
        self.addSubview(exchangeBtn!)
        
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
