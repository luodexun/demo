//
//  WalletDetailHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WalletDetailHeadView: UIView {

    var walletDwnLbl , walletAddressLbl : UILabel?
    
    var coppyBtn , rollOutBtn , rollInBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bg = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 135*PROSIZE))
        bg.image = UIImage.init(named: "ic_wallet_detail_bg")
        self.addSubview(bg)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 46*PROSIZE, y: 45*PROSIZE, width: 200*PROSIZE, height: 15*PROSIZE))
        titleNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl.textColor = UIColor.white
        titleNameLbl.text = "钱包（DWN）"
        self.addSubview(titleNameLbl)
        
        let iconNameLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: titleNameLbl.frame.origin.y+titleNameLbl.frame.size.height+12*PROSIZE, width: 37*PROSIZE, height: 22*PROSIZE))
        iconNameLbl.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        iconNameLbl.textColor = colorWithHex(hex: 0xFF7700)
        iconNameLbl.textAlignment = NSTextAlignment.right
        iconNameLbl.text = "ᗥ"
        self.addSubview(iconNameLbl)
        
        walletDwnLbl = UILabel.init(frame: CGRect.init(x: 77*PROSIZE, y: titleNameLbl.frame.origin.y+titleNameLbl.frame.size.height+12*PROSIZE, width: self.frame.size.width-123*PROSIZE, height: 22*PROSIZE))
        walletDwnLbl?.font = UIFont.systemFont(ofSize: 30*PROSIZE)
        walletDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        self.addSubview(walletDwnLbl!)
        
        walletAddressLbl = UILabel.init(frame: CGRect.init(x: 42*PROSIZE, y: walletDwnLbl!.frame.origin.y+walletDwnLbl!.frame.size.height+32*PROSIZE, width: self.frame.size.width-84*PROSIZE, height: 17*PROSIZE))
        walletAddressLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        walletAddressLbl?.textColor = UIColor.white
        walletAddressLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(walletAddressLbl!)
        
        coppyBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        coppyBtn?.frame = CGRect.init(x: 42*PROSIZE, y: walletDwnLbl!.frame.origin.y+walletDwnLbl!.frame.size.height+30*PROSIZE, width: self.frame.size.width-84*PROSIZE, height: 21*PROSIZE)
        self.addSubview(coppyBtn!)
        
        let rollInView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: bg.frame.origin.y+bg.frame.size.height+20*PROSIZE, width: 160*PROSIZE, height: 45*PROSIZE))
        rollInView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(rollInView)
        
        let rollInImageView = UIImageView.init(frame: CGRect.init(x: 49*PROSIZE, y: 10*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        rollInImageView.image = UIImage.init(named: "ic_wallet_detail_in")
        rollInView.addSubview(rollInImageView)
        
        let inTitleLbl = UILabel.init(frame: CGRect.init(x: 81*PROSIZE, y: 15*PROSIZE, width: 50*PROSIZE, height: 16*PROSIZE))
        inTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        inTitleLbl.textColor = colorWithHex(hex: 0x333333)
        inTitleLbl.text = "收入"
        rollInView.addSubview(inTitleLbl)
        
        rollInBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        rollInBtn?.frame = rollInView.bounds
        rollInView.addSubview(rollInBtn!)
        
        let rollOutView = UIView.init(frame: CGRect.init(x: self.frame.size.width-180*PROSIZE, y: bg.frame.origin.y+bg.frame.size.height+20*PROSIZE, width: 160*PROSIZE, height: 45*PROSIZE))
        rollOutView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(rollOutView)
        
        let rollOutImageView = UIImageView.init(frame: CGRect.init(x: 49*PROSIZE, y: 10*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        rollOutImageView.image = UIImage.init(named: "ic_wallet_detail_out")
        rollOutView.addSubview(rollOutImageView)
        
        let outTitleLbl = UILabel.init(frame: CGRect.init(x: 81*PROSIZE, y: 15*PROSIZE, width: 50*PROSIZE, height: 16*PROSIZE))
        outTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        outTitleLbl.textColor = colorWithHex(hex: 0x333333)
        outTitleLbl.text = "转出"
        rollOutView.addSubview(outTitleLbl)
        
        rollOutBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        rollOutBtn?.frame = rollOutView.bounds
        rollOutView.addSubview(rollOutBtn!)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: rollOutView.frame.origin.y+rollOutView.frame.size.height+20*PROSIZE, width: self.frame.size.width, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(line)
        
        let recordTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: line.frame.origin.y+line.frame.size.height+20*PROSIZE, width: 200*PROSIZE, height: 15*PROSIZE))
        recordTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        recordTitleLbl.textColor = colorWithHex(hex: 0x999999)
        recordTitleLbl.text = "交易记录"
        self.addSubview(recordTitleLbl)
        
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
