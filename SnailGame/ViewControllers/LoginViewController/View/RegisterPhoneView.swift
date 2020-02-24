//
//  RegisterPhoneView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegisterPhoneView: UIView {

    var regionCodeLbl , getCodeLbl : UILabel?
    
    var regionChooseBtn , registerBtn ,checkBtn , agreementBtn : UIButton?
    
    var phoneTxtF , codeTxtF , inviteTxtF : UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let phoneTitleLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 21*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        phoneTitleLbl.text = "手机号码"
        phoneTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        phoneTitleLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(phoneTitleLbl)
        
        regionCodeLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: phoneTitleLbl.frame.origin.y+phoneTitleLbl.frame.size.height+6*PROSIZE, width: 56*PROSIZE, height: 33*PROSIZE))
        regionCodeLbl?.text = "+86"
        regionCodeLbl?.textColor = colorWithHex(hex: 0x333333)
        regionCodeLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(regionCodeLbl!)
        
        let downIcon = UIImageView.init(frame: CGRect.init(x: 81*PROSIZE, y: phoneTitleLbl.frame.origin.y+phoneTitleLbl.frame.size.height+19*PROSIZE, width: 15*PROSIZE, height: 10*PROSIZE))
        downIcon.image = UIImage.init(named: "ic_login_down")
        self.addSubview(downIcon)
        
        regionChooseBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        regionChooseBtn?.frame = CGRect.init(x: 26*PROSIZE, y: phoneTitleLbl.frame.origin.y+phoneTitleLbl.frame.size.height+6*PROSIZE, width: 85*PROSIZE, height: 33*PROSIZE)
        self.addSubview(regionChooseBtn!)
        
        let firstLine = UIView.init(frame: CGRect.init(x: 105*PROSIZE, y: phoneTitleLbl.frame.origin.y+phoneTitleLbl.frame.size.height+8*PROSIZE, width: 1*PROSIZE, height: 33*PROSIZE))
        firstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(firstLine)
        
        phoneTxtF = UITextField.init(frame: CGRect.init(x: 112*PROSIZE, y: phoneTitleLbl.frame.origin.y+phoneTitleLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-139*PROSIZE, height: 33*PROSIZE))
        phoneTxtF?.textColor = colorWithHex(hex: 0x333333)
        phoneTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        phoneTxtF?.placeholder = "请输入手机号码"
        phoneTxtF?.keyboardType = UIKeyboardType.numberPad
        self.addSubview(phoneTxtF!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: phoneTxtF!.frame.origin.y+phoneTxtF!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        let codeLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
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
        
        let thidLine = UIView.init(frame: CGRect.init(x: self.frame.size.width-125*PROSIZE, y: codeLbl.frame.origin.y+codeLbl.frame.size.height+8*PROSIZE, width: 1*PROSIZE, height: 30*PROSIZE))
        thidLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(thidLine)
        
        getCodeLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-122*PROSIZE, y: codeLbl.frame.origin.y+codeLbl.frame.size.height+6*PROSIZE, width: 102*PROSIZE, height: 35*PROSIZE))
        getCodeLbl?.text = "获取验证码"
        getCodeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        getCodeLbl?.textColor = colorWithHex(hex: 0x0077FF)
        getCodeLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(getCodeLbl!)
        
        let forthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: getCodeLbl!.frame.origin.y+getCodeLbl!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        forthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(forthLine)
        
        let inviteLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: forthLine.frame.origin.y+forthLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        inviteLbl.text = "邀请码"
        inviteLbl.textColor = colorWithHex(hex: 0x333333)
        inviteLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(inviteLbl)
        
        inviteTxtF = UITextField.init(frame: CGRect.init(x: 27*PROSIZE, y: inviteLbl.frame.origin.y+inviteLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-54*PROSIZE, height: 33*PROSIZE))
        inviteTxtF?.textColor = colorWithHex(hex: 0x333333)
        inviteTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        inviteTxtF?.placeholder = "推广码让您和推广人均获得奖励"
        self.addSubview(inviteTxtF!)
        
        let fifthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: inviteTxtF!.frame.origin.y+inviteTxtF!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fifthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fifthLine)
        
        registerBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        registerBtn?.frame = CGRect.init(x: 20*PROSIZE, y: fifthLine.frame.origin.y+fifthLine.frame.size.height+30*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        registerBtn?.isUserInteractionEnabled = false
        registerBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        registerBtn?.setTitle("注册", for: UIControl.State.normal)
        registerBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        registerBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registerBtn?.layer.cornerRadius = 5;
        registerBtn?.layer.masksToBounds = true
        self.addSubview(registerBtn!)
        
        checkBtn = UIButton.init(type: UIButton.ButtonType.custom)
        checkBtn?.frame = CGRect.init(x: 20*PROSIZE, y: registerBtn!.frame.origin.y+registerBtn!.frame.size.height+26*PROSIZE, width: 15*PROSIZE, height: 15*PROSIZE)
        checkBtn?.setImage(UIImage.init(named: "ic_register_check_nol"), for: UIControl.State.normal)
        self.addSubview(checkBtn!)
        
        let agreeTitleLbl = UILabel.init(frame: CGRect.init(x: 45*PROSIZE, y: registerBtn!.frame.origin.y+registerBtn!.frame.size.height+26*PROSIZE, width: self.frame.size.width-65*PROSIZE, height: 15*PROSIZE))
        agreeTitleLbl.textColor = colorWithHex(hex: 0x0077FF)
        agreeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(agreeTitleLbl)
        
        let agreeAttrStr = NSMutableAttributedString.init(string: "注册或使用即表示同意《用户注册协议》")
        agreeAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x999999), range:NSRange.init(location:0, length: 10))
        agreeTitleLbl.attributedText = agreeAttrStr
        
        agreementBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        agreementBtn?.frame = CGRect.init(x: 45*PROSIZE, y: registerBtn!.frame.origin.y+registerBtn!.frame.size.height+26*PROSIZE, width: self.frame.size.width-65*PROSIZE, height: 15*PROSIZE)
        self.addSubview(agreementBtn!)
        
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
