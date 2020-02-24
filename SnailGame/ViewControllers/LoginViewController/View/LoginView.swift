//
//  LoginView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class LoginView: UIView {

    var regionCodeLbl : UILabel?
    
    var regionChooseBtn , loginBtn , registerBtn : UIButton?
    
    var phoneTxtF , codeTxtF : UITextField?
    
    var getCodeLbl : UILabel?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let phoneLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 21*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        phoneLbl.text = "手机号码"
        phoneLbl.textColor = colorWithHex(hex: 0x333333)
        phoneLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(phoneLbl)
        
        regionCodeLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: phoneLbl.frame.origin.y+phoneLbl.frame.size.height+6*PROSIZE, width: 56*PROSIZE, height: 33*PROSIZE))
        regionCodeLbl?.text = "+86"
        regionCodeLbl?.textColor = colorWithHex(hex: 0x333333)
        regionCodeLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(regionCodeLbl!)
        
        let downIcon = UIImageView.init(frame: CGRect.init(x: 81*PROSIZE, y: phoneLbl.frame.origin.y+phoneLbl.frame.size.height+19*PROSIZE, width: 15*PROSIZE, height: 10*PROSIZE))
        downIcon.image = UIImage.init(named: "ic_login_down")
        self.addSubview(downIcon)
        
        regionChooseBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        regionChooseBtn?.frame = CGRect.init(x: 26*PROSIZE, y: phoneLbl.frame.origin.y+phoneLbl.frame.size.height+6*PROSIZE, width: 85*PROSIZE, height: 33*PROSIZE)
        self.addSubview(regionChooseBtn!)
        
        let firstLine = UIView.init(frame: CGRect.init(x: 105*PROSIZE, y: phoneLbl.frame.origin.y+phoneLbl.frame.size.height+8*PROSIZE, width: 1*PROSIZE, height: 33*PROSIZE))
        firstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(firstLine)
        
        phoneTxtF = UITextField.init(frame: CGRect.init(x: 112*PROSIZE, y: phoneLbl.frame.origin.y+phoneLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-139*PROSIZE, height: 33*PROSIZE))
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
        
        loginBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        loginBtn?.frame = CGRect.init(x: 20*PROSIZE, y: forthLine.frame.origin.y+22*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        loginBtn?.isUserInteractionEnabled = false
        loginBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        loginBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginBtn?.setTitle("登录", for: UIControl.State.normal)
        loginBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        loginBtn?.layer.cornerRadius = 5
        loginBtn?.layer.masksToBounds = true
        self.addSubview(loginBtn!)
        
        registerBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        registerBtn?.frame = CGRect.init(x: 20*PROSIZE, y: (loginBtn?.frame.origin.y)!+(loginBtn?.frame.size.height)!+40*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 17*PROSIZE)
        registerBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        registerBtn?.setTitle("还没有账户，注册", for: UIControl.State.normal)
        registerBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(registerBtn!)
        
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
