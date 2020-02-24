//
//  UpdatePayView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class UpdatePayView: UIView {
    
    var payPwdTxtF , againPwdTxtF : UITextField?

    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let promptBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 45*PROSIZE))
        promptBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(promptBarView)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: promptBarView.frame.size.width-40*PROSIZE, height: promptBarView.frame.size.height))
        promptTitleLbl.text = "身份验证成功！"
        promptTitleLbl.textColor = colorWithHex(hex: 0xFF0F59)
        promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        promptBarView.addSubview(promptTitleLbl)
        
        let payTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: promptBarView.frame.size.height + 20*PROSIZE, width: 200*PROSIZE, height: 15*PROSIZE))
        payTitleLbl.text = "新支付密码"
        payTitleLbl.textColor = colorWithHex(hex: 0x333333)
        payTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(payTitleLbl)
        
        payPwdTxtF = UITextField.init(frame: CGRect.init(x: 27*PROSIZE, y: payTitleLbl.frame.origin.y+payTitleLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-54*PROSIZE, height: 33*PROSIZE))
        payPwdTxtF?.textColor = colorWithHex(hex: 0x333333)
        payPwdTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        payPwdTxtF?.isSecureTextEntry = true
        payPwdTxtF?.placeholder = "请输入新支付密码"
        self.addSubview(payPwdTxtF!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: payPwdTxtF!.frame.origin.y+payPwdTxtF!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let againTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: 260*PROSIZE, height: 15*PROSIZE))
        againTitleLbl.text = "确认新支付密码"
        againTitleLbl.textColor = colorWithHex(hex: 0x333333)
        againTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(againTitleLbl)
        
        againPwdTxtF = UITextField.init(frame: CGRect.init(x: 27*PROSIZE, y: againTitleLbl.frame.origin.y+againTitleLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-54*PROSIZE, height: 33*PROSIZE))
        againPwdTxtF?.textColor = colorWithHex(hex: 0x333333)
        againPwdTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        againPwdTxtF?.isSecureTextEntry = true
        againPwdTxtF?.placeholder = "请确认新支付密码"
        self.addSubview(againPwdTxtF!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: againPwdTxtF!.frame.origin.y+againPwdTxtF!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+36*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
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