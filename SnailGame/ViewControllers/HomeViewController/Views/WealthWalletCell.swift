//
//  WealthWalletCell.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol WealthWalletDelegate {
    func wealthWalletAction()
}

class WealthWalletCell: UICollectionViewCell {
    
    var dwnNumLbl : UILabel?
    
    var walletDelegate : WealthWalletDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let walletTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 14*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 14*PROSIZE))
        walletTitleLbl.text = "钱包"
        walletTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        walletTitleLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(walletTitleLbl)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 40*PROSIZE, width: SCREEN_WIDE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let icon = UIImageView.init(frame: CGRect.init(x: 18*PROSIZE, y: 62*PROSIZE, width: 32*PROSIZE, height: 32*PROSIZE))
        icon.image = UIImage.init(named: "icon_wealth_wallet")
        self.addSubview(icon)
        
        let dwnTitleLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 62*PROSIZE, width: SCREEN_WIDE-82*PROSIZE, height: 15*PROSIZE))
        dwnTitleLbl.text = "DWN"
        dwnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnTitleLbl.textColor = colorWithHex(hex: 0x666666)
        self.addSubview(dwnTitleLbl)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 64*PROSIZE, y: 82*PROSIZE, width: SCREEN_WIDE-82*PROSIZE, height: 20*PROSIZE))
        dwnNumLbl?.textColor = colorWithHex(hex: 0x333333)
        dwnNumLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        dwnNumLbl?.text = "0.0"
        self.addSubview(dwnNumLbl!)
        
        let walletBtn = UIButton.init(type: .roundedRect)
        walletBtn.frame = CGRect.init(x: 18*PROSIZE, y: 42*PROSIZE, width: SCREEN_WIDE-32*PROSIZE, height: 74*PROSIZE)
        walletBtn.addTarget(self, action: #selector(walletDetailAction), for: .touchUpInside)
        self.addSubview(walletBtn)
    }
    
    @objc func walletDetailAction(sender:UIButton) {
        self.walletDelegate?.wealthWalletAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
