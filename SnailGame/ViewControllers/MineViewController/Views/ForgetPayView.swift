//
//  ForgetPayView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ForgetPayView: UIView {
    
    var codeTxtF : UITextField?
    
    var getCodeLbl : UILabel?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let codeLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 26*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
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
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+22*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
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
