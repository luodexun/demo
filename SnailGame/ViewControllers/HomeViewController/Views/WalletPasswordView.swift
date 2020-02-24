//
//  WalletPasswordView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WalletPasswordView: UIView {

    var walletAddressLbl , dwnNumLbl , noteContentLbl : UILabel?

    var payTxtF : UITextField?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let addressTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 21*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        addressTitleLbl.textColor = colorWithHex(hex: 0x999999)
        addressTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressTitleLbl.text = "钱包地址"
        self.addSubview(addressTitleLbl)
        
        walletAddressLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: addressTitleLbl.frame.origin.y+addressTitleLbl.frame.size.height+8*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 17*PROSIZE))
        walletAddressLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        walletAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(walletAddressLbl!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: walletAddressLbl!.frame.origin.y+walletAddressLbl!.frame.size.height+11*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let dwnTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        dwnTitleLbl.text = "数量（DWN）"
        dwnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnTitleLbl.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(dwnTitleLbl)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: dwnTitleLbl.frame.origin.y+dwnTitleLbl.frame.size.height+9*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        dwnNumLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnNumLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(dwnNumLbl!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: dwnNumLbl!.frame.origin.y+dwnNumLbl!.frame.size.height+12*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        let noteTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        noteTitleLbl.textColor = colorWithHex(hex: 0x999999)
        noteTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteTitleLbl.text = "备注"
        self.addSubview(noteTitleLbl)
        
        noteContentLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: noteTitleLbl.frame.origin.y+noteTitleLbl.frame.size.height+9*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        noteContentLbl?.text = "提出到钱包"
        noteContentLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteContentLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(noteContentLbl!)
        
        let thidLine = UIView.init(frame: CGRect.init(x: 0, y: noteContentLbl!.frame.origin.y+noteContentLbl!.frame.size.height+21*PROSIZE, width: self.frame.size.width, height: 10*PROSIZE))
        thidLine.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(thidLine)
        
        let payTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: thidLine.frame.origin.y+thidLine.frame.size.height+16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        payTitleLbl.textColor = colorWithHex(hex: 0x999999)
        payTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        payTitleLbl.text = "支付密码"
        self.addSubview(payTitleLbl)
        
        payTxtF = UITextField.init(frame: CGRect.init(x: 25*PROSIZE, y: payTitleLbl.frame.origin.y+payTitleLbl.frame.size.height, width: self.frame.size.width-50*PROSIZE, height: 45*PROSIZE))
        payTxtF?.placeholder = "请输入支付密码"
        payTxtF?.textColor = colorWithHex(hex: 0x333333)
        payTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        payTxtF?.isSecureTextEntry = true
        self.addSubview(payTxtF!)
        
        let forthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: payTxtF!.frame.origin.y+payTxtF!.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        forthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(forthLine)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: forthLine.frame.origin.y+forthLine.frame.size.height+25*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.layer.cornerRadius = 5
        submitBtn?.layer.masksToBounds = true
        self.addSubview(submitBtn!)
        
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
