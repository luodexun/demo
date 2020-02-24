//
//  ReplacePurseView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ReplacePurseView: UIView {

    var codeTxtF , payPwdTxtF : UITextField?
    
    var getCodeLbl : UILabel?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let codeLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 32*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        codeLbl.text = "验证码"
        codeLbl.textColor = colorWithHex(hex: 0x333333)
        codeLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(codeLbl)
        
        codeTxtF = UITextField.init(frame: CGRect.init(x: 27*PROSIZE, y: codeLbl.frame.origin.y+codeLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-157*PROSIZE, height: 33*PROSIZE))
        codeTxtF?.textColor = colorWithHex(hex: 0x333333)
        codeTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        codeTxtF?.placeholder = "请输入验证码"
        codeTxtF?.keyboardType = UIKeyboardType.numberPad
        self.addSubview(codeTxtF!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: self.frame.size.width-125*PROSIZE, y: codeLbl.frame.origin.y+codeLbl.frame.size.height+8*PROSIZE, width: 1*PROSIZE, height: 30*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        getCodeLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-122*PROSIZE, y: codeLbl.frame.origin.y+codeLbl.frame.size.height+6*PROSIZE, width: 102*PROSIZE, height: 35*PROSIZE))
        getCodeLbl?.text = "获取验证码"
        getCodeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        getCodeLbl?.textColor = colorWithHex(hex: 0x0077FF)
        getCodeLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(getCodeLbl!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: getCodeLbl!.frame.origin.y+getCodeLbl!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        let nowTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        nowTitleLbl.text = "支付密码"
        nowTitleLbl.textColor = colorWithHex(hex: 0x333333)
        nowTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(nowTitleLbl)
        
        payPwdTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: nowTitleLbl.frame.origin.y+nowTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 36*PROSIZE))
        payPwdTxtF?.textColor = colorWithHex(hex: 0x333333)
        payPwdTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        payPwdTxtF?.isSecureTextEntry = true
        payPwdTxtF?.placeholder = "请输入您的支付密码"
        self.addSubview(payPwdTxtF!)
        
        let thidLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: payPwdTxtF!.frame.origin.y+payPwdTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        thidLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(thidLine)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: thidLine.frame.origin.y+44*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 46*PROSIZE)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.layer.cornerRadius = 5
        submitBtn?.layer.masksToBounds = true
        self.addSubview(submitBtn!)
        
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
