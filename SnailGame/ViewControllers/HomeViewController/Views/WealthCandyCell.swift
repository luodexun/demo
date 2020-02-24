//
//  WealthCandyCell.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol WealthCandyDelegate {
    func wealthCandyAction(opera:Int)
}

class WealthCandyCell: UICollectionViewCell {
    
    var candyNumLbl : UILabel?
    
    var candyDelegate : WealthCandyDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let communityTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 14*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 14*PROSIZE))
        communityTitleLbl.text = "社区"
        communityTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        communityTitleLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(communityTitleLbl)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 40*PROSIZE, width: SCREEN_WIDE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let icon = UIImageView.init(frame: CGRect.init(x: 18*PROSIZE, y: 62*PROSIZE, width: 32*PROSIZE, height: 32*PROSIZE))
        icon.image = UIImage.init(named: "icon_wealth_candy")
        self.addSubview(icon)
        
        let candyTitleLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 63*PROSIZE, width: SCREEN_WIDE-82*PROSIZE, height: 15*PROSIZE))
        candyTitleLbl.text = "糖果"
        candyTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        candyTitleLbl.textColor = colorWithHex(hex: 0x666666)
        self.addSubview(candyTitleLbl)
        
        candyNumLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 84*PROSIZE, width: SCREEN_WIDE-82*PROSIZE, height: 20*PROSIZE))
        candyNumLbl?.textColor = colorWithHex(hex: 0x333333)
        candyNumLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        candyNumLbl?.text = "0.0"
        self.addSubview(candyNumLbl!)
        
        let candyBtn = UIButton.init(type: .roundedRect)
        candyBtn.frame = CGRect.init(x: 18*PROSIZE, y: 42*PROSIZE, width: SCREEN_WIDE-32*PROSIZE, height: 74*PROSIZE)
        candyBtn.addTarget(self, action: #selector(candyDetailAction), for: .touchUpInside)
        self.addSubview(candyBtn)
        
        let exchangeBtn = UIButton.init(type: .roundedRect)
        exchangeBtn.frame = CGRect.init(x: 65*PROSIZE, y: 120*PROSIZE, width: 66*PROSIZE, height: 29*PROSIZE)
        exchangeBtn.setTitle("兑换", for: .normal)
        exchangeBtn.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        exchangeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        exchangeBtn.layer.borderWidth = 1
        exchangeBtn.layer.borderColor = colorWithHex(hex: 0x999999).cgColor
        exchangeBtn.layer.cornerRadius = 4
        exchangeBtn.layer.masksToBounds = true
        exchangeBtn.addTarget(self, action: #selector(candyExchangeAction), for: .touchUpInside)
        self.addSubview(exchangeBtn)
        
        let secLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: 168*PROSIZE, width: SCREEN_WIDE-18*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
    }
    
    @objc func candyDetailAction(sender:UIButton) {
        self.candyDelegate?.wealthCandyAction(opera: 1)
    }
    
    @objc func candyExchangeAction(sender:UIButton) {
        self.candyDelegate?.wealthCandyAction(opera: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
