//
//  WealthDwnCell.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol WealthDwnDelegate {
    func wealthDwnAction(opera:Int)
}

class WealthDwnCell: UICollectionViewCell {
    
    var dwnNumLbl , monthNumLbl : UILabel?

    var dwnDelegate : WealthDwnDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let icon = UIImageView.init(frame: CGRect.init(x: 18*PROSIZE, y: 19*PROSIZE, width: 32*PROSIZE, height: 32*PROSIZE))
        icon.image = UIImage.init(named: "icon_wealth_dwn")
        self.addSubview(icon)
        
        let dwnTitleLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 19*PROSIZE, width: 150*PROSIZE, height: 15*PROSIZE))
        dwnTitleLbl.text = "DWN"
        dwnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnTitleLbl.textColor = colorWithHex(hex: 0x666666)
        self.addSubview(dwnTitleLbl)
        
        let monthTitleLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-160*PROSIZE, y: 19*PROSIZE, width: 142*PROSIZE, height: 15*PROSIZE))
        monthTitleLbl.text = "本月收益"
        monthTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        monthTitleLbl.textColor = colorWithHex(hex: 0x666666)
        monthTitleLbl.textAlignment = .right
        self.addSubview(monthTitleLbl)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 40*PROSIZE, width: 150*PROSIZE, height: 20*PROSIZE))
        dwnNumLbl?.textColor = colorWithHex(hex: 0x333333)
        dwnNumLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        dwnNumLbl?.text = "0.0"
        self.addSubview(dwnNumLbl!)
        
        monthNumLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-160*PROSIZE, y: 40*PROSIZE, width: 142*PROSIZE, height: 20*PROSIZE))
        monthNumLbl?.textColor = colorWithHex(hex: 0xFF0F59)
        monthNumLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        monthNumLbl?.textAlignment = .right
        monthNumLbl?.text = "+0.0"
        self.addSubview(monthNumLbl!)
        
        let dwnBtn = UIButton.init(type: .roundedRect)
        dwnBtn.frame = CGRect.init(x: 18*PROSIZE, y: 0, width: SCREEN_WIDE-32*PROSIZE, height: 74*PROSIZE)
        dwnBtn.addTarget(self, action: #selector(dwnDetailAction), for: .touchUpInside)
        self.addSubview(dwnBtn)
        
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
        
        let extractBtn = UIButton.init(type: .roundedRect)
        extractBtn.frame = CGRect.init(x: 147*PROSIZE, y: 76*PROSIZE, width: 66*PROSIZE, height: 29*PROSIZE)
        extractBtn.setTitle("提出", for: .normal)
        extractBtn.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        extractBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        extractBtn.layer.borderWidth = 1
        extractBtn.layer.borderColor = colorWithHex(hex: 0x999999).cgColor
        extractBtn.layer.cornerRadius = 4
        extractBtn.layer.masksToBounds = true
        extractBtn.addTarget(self, action: #selector(extractAction), for: .touchUpInside)
        self.addSubview(extractBtn)
        
        let secLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: 125*PROSIZE, width: SCREEN_WIDE-18*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
    }
    
    @objc func dwnDetailAction(sender:UIButton) {
        self.dwnDelegate?.wealthDwnAction(opera: 1)
    }
    
    @objc func depositAction(sender:UIButton) {
        self.dwnDelegate?.wealthDwnAction(opera: 2)
    }
    
    @objc func extractAction(sender:UIButton) {
        self.dwnDelegate?.wealthDwnAction(opera: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
