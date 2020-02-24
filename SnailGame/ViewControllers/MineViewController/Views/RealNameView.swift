//
//  RealNameView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RealNameView: UIView {
    
    var userNameTxtF , userNumTxtF : UITextField?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let nameTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: 26*PROSIZE, width: 200*PROSIZE, height: 15*PROSIZE))
        nameTitleLbl.text = "姓名"
        nameTitleLbl.textColor = colorWithHex(hex: 0x333333)
        nameTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(nameTitleLbl)
        
        userNameTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: nameTitleLbl.frame.origin.y+nameTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 36*PROSIZE))
        userNameTxtF?.textColor = colorWithHex(hex: 0x333333)
        userNameTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        userNameTxtF?.placeholder = "请输入真实姓名"
        self.addSubview(userNameTxtF!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: userNameTxtF!.frame.origin.y+userNameTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let numTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+20*PROSIZE, width: 200*PROSIZE, height: 15*PROSIZE))
        numTitleLbl.text = "证件号码"
        numTitleLbl.textColor = colorWithHex(hex: 0x333333)
        numTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(numTitleLbl)
        
        userNumTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: numTitleLbl.frame.origin.y+numTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 36*PROSIZE))
        userNumTxtF?.textColor = colorWithHex(hex: 0x333333)
        userNumTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        userNumTxtF?.placeholder = "请输入证件号码"
        self.addSubview(userNumTxtF!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: userNumTxtF!.frame.origin.y+userNumTxtF!.frame.size.height+5*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+31*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.isUserInteractionEnabled = false
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
