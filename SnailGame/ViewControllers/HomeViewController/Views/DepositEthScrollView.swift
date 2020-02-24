//
//  DepositEthScrollView.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositEthScrollView: UIScrollView {
    
    var barView : UIView?
    
    var qrCodeImageView : UIImageView?
    
    var savePhotoBtn , coppyAddressBtn : UIButton?
    
    var addressNameLbl : UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        barView = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: 18*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 404*PROSIZE))
        barView?.backgroundColor = UIColor.white
        barView?.layer.cornerRadius = 4;
        barView?.layer.masksToBounds = true
        self.addSubview(barView!)
        
        let ethTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 28*PROSIZE, width: barView!.frame.size.width-40*PROSIZE, height: 24*PROSIZE))
        ethTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        ethTitleLbl.textColor = colorWithHex(hex: 0x333333)
        ethTitleLbl.textAlignment = .center
        ethTitleLbl.text = "ETH（以太币）"
        barView?.addSubview(ethTitleLbl)
        
        qrCodeImageView = UIImageView.init(frame: CGRect.init(x: (barView!.frame.size.width-152*PROSIZE)/2, y: ethTitleLbl.frame.origin.y+ethTitleLbl.frame.size.height+16*PROSIZE, width: 152*PROSIZE, height: 152*PROSIZE))
        barView?.addSubview(qrCodeImageView!)
        
        savePhotoBtn = UIButton.init(type: .roundedRect)
        savePhotoBtn?.frame = CGRect.init(x: 30*PROSIZE, y: qrCodeImageView!.frame.origin.y+qrCodeImageView!.frame.size.height+10*PROSIZE, width: barView!.frame.size.width-60*PROSIZE, height: 44*PROSIZE)
        savePhotoBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: .normal)
        savePhotoBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        savePhotoBtn?.setTitle("保存二维码", for: .normal)
        barView?.addSubview(savePhotoBtn!)
        
        let addressTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: savePhotoBtn!.frame.origin.y+savePhotoBtn!.frame.size.height+14*PROSIZE, width: barView!.frame.size.width-40*PROSIZE, height: 14*PROSIZE))
        addressTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        addressTitleLbl.textColor = colorWithHex(hex: 0x999999)
        addressTitleLbl.textAlignment = .center
        addressTitleLbl.text = "存入地址"
        barView?.addSubview(addressTitleLbl)
    
        addressNameLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: addressTitleLbl.frame.origin.y+addressTitleLbl.frame.size.height+14*PROSIZE, width: barView!.frame.size.width-20*PROSIZE, height: 22*PROSIZE))
        addressNameLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        addressNameLbl?.textColor = colorWithHex(hex: 0x333333)
        addressNameLbl?.textAlignment = .center
        barView?.addSubview(addressNameLbl!)
        
        coppyAddressBtn = UIButton.init(type: .roundedRect)
        coppyAddressBtn?.frame = CGRect.init(x: 30*PROSIZE, y: addressNameLbl!.frame.origin.y+addressNameLbl!.frame.size.height+4*PROSIZE, width: barView!.frame.size.width-60*PROSIZE, height: 44*PROSIZE)
        coppyAddressBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: .normal)
        coppyAddressBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        coppyAddressBtn?.setTitle("复制地址", for: .normal)
        barView?.addSubview(coppyAddressBtn!)
        
        let promptStr = "请勿向上述地址充值任何非ETH资产，否则资产将不可找回。\n\n您充值至上述地址后,需要整个网络节点的确认，12次网络确认后到账，12次网络确认后可提币。\n\n最小充值金额：0.01 ETH，小于最小金额的充值将不会上账且无法退回。\n\n目前不支持区块奖励(Coinbase)的转账充值，区块奖励的转账将不会上账,请您谅解。\n\n您的充值地址不会经常改变，可以重复充值；如有更改，我们会尽量通过网站公告或邮件通知您。\n\n请务必确认电脑、手机及浏览器安全，防止信息被篡改或泄露。"
        
        
        let promptSize = NSString.calStrSize(textStr: promptStr as NSString, width: self.frame.size.width-36*PROSIZE, fontSize: 14*PROSIZE)
        
        let promptLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: barView!.frame.origin.y+barView!.frame.size.height+20*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: promptSize.height))
        promptLbl.text = promptStr
        promptLbl.numberOfLines = 0
        promptLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        promptLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(promptLbl)
       
        self.contentSize = CGSize.init(width: SCREEN_WIDE, height: promptLbl.frame.origin.y+promptLbl.frame.size.height+20*PROSIZE)
        
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
