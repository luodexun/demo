//
//  WealthEthCell.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol WealthEthDelegate {
    func wealthEthAction(opera:Int)
}

class WealthEthCell: UICollectionViewCell {
    
    var ethNumLbl : UILabel?
    
    var ethDelegate : WealthEthDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.white
        
        let icon = UIImageView.init(frame: CGRect.init(x: 18*PROSIZE, y: 19*PROSIZE, width: 32*PROSIZE, height: 32*PROSIZE))
        icon.image = UIImage.init(named: "icon_wealth_eth")
        self.addSubview(icon)
        
        let ethTitleLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 19*PROSIZE, width: SCREEN_WIDE-82*PROSIZE, height: 15*PROSIZE))
        ethTitleLbl.text = "ETH"
        ethTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        ethTitleLbl.textColor = colorWithHex(hex: 0x666666)
        self.addSubview(ethTitleLbl)
        
        ethNumLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 40*PROSIZE, width: SCREEN_WIDE-82*PROSIZE, height: 20*PROSIZE))
        ethNumLbl?.textColor = colorWithHex(hex: 0x333333)
        ethNumLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        ethNumLbl?.text = "0.0"
        self.addSubview(ethNumLbl!)
        
        let ethBtn = UIButton.init(type: .roundedRect)
        ethBtn.frame = CGRect.init(x: 18*PROSIZE, y: 0, width: SCREEN_WIDE-32*PROSIZE, height: 74*PROSIZE)
        ethBtn.addTarget(self, action: #selector(ethDetailAction), for: .touchUpInside)
        self.addSubview(ethBtn)
        
        let depositBtn = UIButton.init(type: .roundedRect)
        depositBtn.frame = CGRect.init(x: 65*PROSIZE, y: 76*PROSIZE, width: 66*PROSIZE, height: 29*PROSIZE)
        depositBtn.setTitle("存入", for: .normal)
        depositBtn.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        depositBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        depositBtn.layer.borderWidth = 1
        depositBtn.layer.borderColor = colorWithHex(hex: 0x999999).cgColor
        depositBtn.layer.cornerRadius = 4
        depositBtn.layer.masksToBounds = true
        depositBtn.addTarget(self, action: #selector(depositAction), for: .touchUpInside)
        self.addSubview(depositBtn)
        
        let exchangeBtn = UIButton.init(type: .roundedRect)
        exchangeBtn.frame = CGRect.init(x: 147*PROSIZE, y: 76*PROSIZE, width: 66*PROSIZE, height: 29*PROSIZE)
        exchangeBtn.setTitle("兑换", for: .normal)
        exchangeBtn.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        exchangeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        exchangeBtn.layer.borderWidth = 1
        exchangeBtn.layer.borderColor = colorWithHex(hex: 0x999999).cgColor
        exchangeBtn.layer.cornerRadius = 4
        exchangeBtn.layer.masksToBounds = true
        exchangeBtn.addTarget(self, action: #selector(exchangeAction), for: .touchUpInside)
        self.addSubview(exchangeBtn)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 124*PROSIZE, width: SCREEN_WIDE, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(line)
                
    }
    
    @objc func ethDetailAction(sender:UIButton) {
        self.ethDelegate?.wealthEthAction(opera: 1)
    }
    
    @objc func depositAction(sender:UIButton) {
        self.ethDelegate?.wealthEthAction(opera: 2)
    }
    
    @objc func exchangeAction(sender:UIButton) {
        self.ethDelegate?.wealthEthAction(opera: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
