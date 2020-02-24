//
//  CommunitySecretView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CommunitySecretView: UIView {
    
    var walletAddressLbl , dwnTitleLbl , dwnNumLbl , noteContentLbl : UILabel?
    
    var paySecretTxtView : SnailTextView?
    
    var saveView : SaveSecretView?
    
    var clearView : ClearSecretView?
    
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
        
        dwnTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        dwnTitleLbl?.text = "数量 / 费用（DWN）"
        dwnTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnTitleLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(dwnTitleLbl!)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: dwnTitleLbl!.frame.origin.y+dwnTitleLbl!.frame.size.height+9*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
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
        noteContentLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteContentLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(noteContentLbl!)
        
        let thidLine = UIView.init(frame: CGRect.init(x: 0, y: noteContentLbl!.frame.origin.y+noteContentLbl!.frame.size.height+12*PROSIZE, width: self.frame.size.width, height: 10*PROSIZE))
        thidLine.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(thidLine)
        
        let payTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: thidLine.frame.origin.y+thidLine.frame.size.height+16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        payTitleLbl.textColor = colorWithHex(hex: 0x999999)
        payTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        payTitleLbl.text = "钱包密钥"
        self.addSubview(payTitleLbl)
        
        paySecretTxtView = SnailTextView.init(placeholder: "请输入钱包密钥", placeholderColor: colorWithHex(hex: 0x999999), frame: CGRect.init(x: 20*PROSIZE, y: payTitleLbl.frame.origin.y+payTitleLbl.frame.size.height+10*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 105*PROSIZE))
        paySecretTxtView?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        paySecretTxtView?.palceholdertextView.textColor = colorWithHex(hex: 0x333333)
        paySecretTxtView?.isShowCountLabel = false
        paySecretTxtView?.palceholdertextView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(paySecretTxtView!)
        
        saveView = SaveSecretView.init(frame: CGRect.init(x: 20*PROSIZE, y: paySecretTxtView!.frame.origin.y+paySecretTxtView!.frame.size.height+15*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 35*PROSIZE))
        saveView?.isHidden = true
        self.addSubview(saveView!)
        
        clearView = ClearSecretView.init(frame: CGRect.init(x: 20*PROSIZE, y: paySecretTxtView!.frame.origin.y+paySecretTxtView!.frame.size.height+15*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 35*PROSIZE))
        //clearView?.isHidden = true
        self.addSubview(clearView!)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: paySecretTxtView!.frame.origin.y+paySecretTxtView!.frame.size.height+69*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
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
