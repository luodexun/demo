//
//  RollInView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RollInView: UIScrollView {

    var qrCodeImageView : UIImageView?
    
    var dwnNumLbl , walletAddressLbl : UILabel?
    
    var barView : UIView?
    
    var setNumBtn , savePhotoBtn , coppyBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let warnBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 45*PROSIZE))
        warnBarView.backgroundColor = colorWithHex(hex: 0xF4F4F4)
        self.addSubview(warnBarView)
        
        let warnTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: warnBarView.frame.size.height))
        warnTitleLbl.textColor = colorWithHex(hex: 0x333333)
        warnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        warnTitleLbl.text = "发送给对方“钱包地址”或“二维码”"
        warnBarView.addSubview(warnTitleLbl)
        
        qrCodeImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-180*PROSIZE)/2, y: warnBarView.frame.size.height+50*PROSIZE, width: 180*PROSIZE, height: 180*PROSIZE))
        self.addSubview(qrCodeImageView!)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: qrCodeImageView!.frame.origin.y+qrCodeImageView!.frame.size.height+11*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 23*PROSIZE))
        dwnNumLbl?.isHidden = true
        dwnNumLbl?.font = UIFont.systemFont(ofSize: 30*PROSIZE)
        dwnNumLbl?.textColor = colorWithHex(hex: 0x999999)
        dwnNumLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(dwnNumLbl!)
        
        barView = UIView.init(frame: CGRect.init(x: 0, y: 289*PROSIZE, width: self.frame.size.width, height: 217*PROSIZE))
        self.addSubview(barView!)
     
        setNumBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        setNumBtn?.frame = CGRect.init(x: 77*PROSIZE, y: 0, width: 100*PROSIZE, height: 38*PROSIZE)
        setNumBtn?.setTitle("设置数量", for: UIControl.State.normal)
        setNumBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        setNumBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        barView?.addSubview(setNumBtn!)
        
        savePhotoBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        savePhotoBtn?.frame = CGRect.init(x: self.frame.size.width-177*PROSIZE, y: 0, width: 100*PROSIZE, height: 38*PROSIZE)
        savePhotoBtn?.setTitle("保存图片", for: UIControl.State.normal)
        savePhotoBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        savePhotoBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        barView?.addSubview(savePhotoBtn!)
        
        let centerLine = UIView.init(frame: CGRect.init(x: (self.frame.size.width-1*PROSIZE)/2, y: 10*PROSIZE, width: 1*PROSIZE, height: 18*PROSIZE))
        centerLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView?.addSubview(centerLine)
        
        let leftLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 77*PROSIZE, width: 150*PROSIZE, height: 1*PROSIZE))
        leftLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView?.addSubview(leftLine)
        
        let rightLine = UIView.init(frame: CGRect.init(x: self.frame.size.width-170*PROSIZE, y: 77*PROSIZE, width: 150*PROSIZE, height: 1*PROSIZE))
        rightLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView?.addSubview(rightLine)
        
        let orTitleLbl = UILabel.init(frame: CGRect.init(x: (self.frame.size.width-35*PROSIZE)/2, y: 67*PROSIZE, width: 35*PROSIZE, height: 22*PROSIZE))
        orTitleLbl.textColor = colorWithHex(hex: 0x333333)
        orTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        orTitleLbl.text = "或"
        orTitleLbl.textAlignment = NSTextAlignment.center
        barView?.addSubview(orTitleLbl)
        
        let addressBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: orTitleLbl.frame.origin.y+orTitleLbl.frame.size.height+40*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 75*PROSIZE))
        addressBarView.backgroundColor = colorWithHex(hex: 0xF4F4F4)
        barView?.addSubview(addressBarView)
        
        let coppyTitleLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: 21*PROSIZE, width: addressBarView.frame.size.width-20*PROSIZE, height: 15*PROSIZE))
        coppyTitleLbl.textColor = colorWithHex(hex: 0x999999)
        coppyTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        coppyTitleLbl.text = "钱包地址（可点击复制）"
        coppyTitleLbl.textAlignment = NSTextAlignment.center
        addressBarView.addSubview(coppyTitleLbl)
        
        walletAddressLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: 44*PROSIZE, width: addressBarView.frame.size.width-20*PROSIZE, height: 15*PROSIZE))
        walletAddressLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        walletAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        walletAddressLbl?.textAlignment = NSTextAlignment.center
        addressBarView.addSubview(walletAddressLbl!)
        
        coppyBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        coppyBtn?.frame = addressBarView.bounds
        addressBarView.addSubview(coppyBtn!)
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
