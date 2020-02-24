//
//  ModifyPayView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ModifyPayView: UIView {

    var originalPwdTxtF , codeTxtF , nowPwdTxtF , confirmPwdTxtF : UITextField?
    
    var getCodeLbl : UILabel?
    
    var submitBtn , forgetBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let originalTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: 20*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        originalTitleLbl.text = "原支付密码"
        originalTitleLbl.textColor = colorWithHex(hex: 0x333333)
        originalTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(originalTitleLbl)
        
        originalPwdTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: originalTitleLbl.frame.origin.y+originalTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 36*PROSIZE))
        originalPwdTxtF?.textColor = colorWithHex(hex: 0x333333)
        originalPwdTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        originalPwdTxtF?.isSecureTextEntry = true
        originalPwdTxtF?.placeholder = "请输入原支付密码"
        self.addSubview(originalPwdTxtF!)
 
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: originalPwdTxtF!.frame.origin.y+originalPwdTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let codeTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        codeTitleLbl.text = "验证码"
        codeTitleLbl.textColor = colorWithHex(hex: 0x333333)
        codeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(codeTitleLbl)
        
        codeTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: codeTitleLbl.frame.origin.y+codeTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-150*PROSIZE, height: 36*PROSIZE))
        codeTxtF?.textColor = colorWithHex(hex: 0x333333)
        codeTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        codeTxtF?.keyboardType = UIKeyboardType.numberPad
        codeTxtF?.placeholder = "请输入验证码"
        self.addSubview(codeTxtF!)
        
        let secLine = UIView.init(frame: CGRect.init(x: self.frame.size.width-125*PROSIZE, y: codeTitleLbl.frame.origin.y+codeTitleLbl.frame.size.height+8*PROSIZE, width: 1*PROSIZE, height: 30*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        getCodeLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-122*PROSIZE, y: codeTitleLbl.frame.origin.y+codeTitleLbl.frame.size.height+5*PROSIZE, width: 102*PROSIZE, height: 36*PROSIZE))
        getCodeLbl?.isUserInteractionEnabled = true
        getCodeLbl?.text = "获取验证码"
        getCodeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        getCodeLbl?.textColor = colorWithHex(hex: 0x0077FF)
        getCodeLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(getCodeLbl!)
        
        let thirdLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: codeTxtF!.frame.origin.y+codeTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        thirdLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(thirdLine)
        
        let nowTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: thirdLine.frame.origin.y+thirdLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        nowTitleLbl.text = "新支付密码"
        nowTitleLbl.textColor = colorWithHex(hex: 0x333333)
        nowTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(nowTitleLbl)
        
        nowPwdTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: nowTitleLbl.frame.origin.y+nowTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 36*PROSIZE))
        nowPwdTxtF?.textColor = colorWithHex(hex: 0x333333)
        nowPwdTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nowPwdTxtF?.isSecureTextEntry = true
        nowPwdTxtF?.placeholder = "请输入新支付密码"
        self.addSubview(nowPwdTxtF!)
        
        let forthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: nowPwdTxtF!.frame.origin.y+nowPwdTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        forthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(forthLine)
        
        let confirmTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: forthLine.frame.origin.y+forthLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        confirmTitleLbl.text = "确认新支付密码"
        confirmTitleLbl.textColor = colorWithHex(hex: 0x333333)
        confirmTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(confirmTitleLbl)
        
        confirmPwdTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: confirmTitleLbl.frame.origin.y+confirmTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 36*PROSIZE))
        confirmPwdTxtF?.textColor = colorWithHex(hex: 0x333333)
        confirmPwdTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        confirmPwdTxtF?.isSecureTextEntry = true
        confirmPwdTxtF?.placeholder = "请确认新支付密码"
        self.addSubview(confirmPwdTxtF!)
        
        let fifthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: confirmPwdTxtF!.frame.origin.y+confirmPwdTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fifthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fifthLine)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: fifthLine.frame.origin.y+fifthLine.frame.size.height+31*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.layer.cornerRadius = 5
        submitBtn?.layer.masksToBounds = true
        self.addSubview(submitBtn!)
        
        forgetBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        forgetBtn?.frame = CGRect.init(x: 20*PROSIZE, y: submitBtn!.frame.origin.y+submitBtn!.frame.size.height+30*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 36*PROSIZE)
        forgetBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        forgetBtn?.setTitle("忘记原支付密码？", for: UIControl.State.normal)
        forgetBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(forgetBtn!)
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
