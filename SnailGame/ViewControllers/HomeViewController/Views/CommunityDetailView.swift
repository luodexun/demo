//
//  CommunityDetailView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CommunityDetailView: UIScrollView {
    
    var currentDwnLbl , releaseDwnLbl : UILabel?
    
    var bannerImageView : UIImageView?
    
    var toCommunityBtn , toWalletBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let wealthBarView = UIView.init(frame: CGRect.init(x: 0, y: 10*PROSIZE, width: self.frame.size.width, height: 150*PROSIZE))
        wealthBarView.backgroundColor = UIColor.white
        self.addSubview(wealthBarView)
        
        let currentTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 18*PROSIZE, width: wealthBarView.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        currentTitleLbl.text = "当前（DWN）"
        currentTitleLbl.textColor = colorWithHex(hex: 0x333333)
        currentTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        wealthBarView.addSubview(currentTitleLbl)
        
        currentDwnLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: currentTitleLbl.frame.origin.y+currentTitleLbl.frame.size.height+9*PROSIZE, width: wealthBarView.frame.size.width-40*PROSIZE, height: 18*PROSIZE))
        currentDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        currentDwnLbl?.text = "0"
        currentDwnLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        wealthBarView.addSubview(currentDwnLbl!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 75*PROSIZE, width: wealthBarView.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        wealthBarView.addSubview(fstLine)
        
        let waitTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+18*PROSIZE, width: wealthBarView.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        waitTitleLbl.text = "待释放（DWN）*"
        waitTitleLbl.textColor = colorWithHex(hex: 0x333333)
        waitTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        wealthBarView.addSubview(waitTitleLbl)
        
        releaseDwnLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: waitTitleLbl.frame.origin.y+waitTitleLbl.frame.size.height+9*PROSIZE, width: wealthBarView.frame.size.width-40*PROSIZE, height: 18*PROSIZE))
        releaseDwnLbl?.textColor = colorWithHex(hex: 0x999999)
        releaseDwnLbl?.text = "0"
        releaseDwnLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        wealthBarView.addSubview(releaseDwnLbl!)
    
        let bannerBarView = UIView.init(frame: CGRect.init(x: 0, y: wealthBarView.frame.origin.y+wealthBarView.frame.size.height+10*PROSIZE, width: self.frame.size.width, height: 210*PROSIZE))
        bannerBarView.backgroundColor = UIColor.white
        self.addSubview(bannerBarView)
        
        bannerImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: bannerBarView.frame.size.width-40*PROSIZE, height: 110*PROSIZE))
        bannerImageView?.layer.cornerRadius = 5
        bannerImageView?.layer.masksToBounds = true
        bannerBarView.addSubview(bannerImageView!)
        
        toCommunityBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        toCommunityBtn?.frame = CGRect.init(x: 20*PROSIZE, y: bannerImageView!.frame.origin.y+bannerImageView!.frame.size.height+15*PROSIZE, width: (bannerBarView.frame.size.width-60*PROSIZE)/2, height: 45*PROSIZE)
        toCommunityBtn?.setTitle("存入社区", for: UIControl.State.normal)
        toCommunityBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        toCommunityBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        toCommunityBtn?.layer.borderWidth = 1
        toCommunityBtn?.layer.borderColor = colorWithHex(hex: 0x0077FF).cgColor
        toCommunityBtn?.layer.cornerRadius = 5
        toCommunityBtn?.layer.masksToBounds = true
        bannerBarView.addSubview(toCommunityBtn!)
        
        toWalletBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        toWalletBtn?.frame = CGRect.init(x: bannerBarView.frame.size.width/2+10*PROSIZE, y: bannerImageView!.frame.origin.y+bannerImageView!.frame.size.height+15*PROSIZE, width: (bannerBarView.frame.size.width-60*PROSIZE)/2, height: 45*PROSIZE)
        toWalletBtn?.setTitle("提到钱包", for: UIControl.State.normal)
        toWalletBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        toWalletBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        toWalletBtn?.layer.borderWidth = 1
        toWalletBtn?.layer.borderColor = colorWithHex(hex: 0x0077FF).cgColor
        toWalletBtn?.layer.cornerRadius = 5
        toWalletBtn?.layer.masksToBounds = true
        bannerBarView.addSubview(toWalletBtn!)
        
        let promptBarView = UIView.init(frame: CGRect.init(x: 0, y: bannerBarView.frame.origin.y+bannerBarView.frame.size.height+10*PROSIZE, width: self.frame.size.width, height: 135*PROSIZE))
        promptBarView.backgroundColor = UIColor.white
        self.addSubview(promptBarView)
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: promptBarView.frame.size.width-40*PROSIZE, height: 115*PROSIZE))
        promptTitleLbl.text = configModel?.release_introduce
        promptTitleLbl.textColor = colorWithHex(hex: 0x333333)
        promptTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        promptTitleLbl.numberOfLines = 0
        promptBarView.addSubview(promptTitleLbl)
        
        
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
