//
//  RegisterDataView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegisterDataView: UIView {
    
    var portraitbarView : UIView?
    
    var portraitImageView : UIImageView?
    
    var addPortaritBtn , nextStepBtn , waitSubmitBtn : UIButton?
    
    var nickNameTxtF : UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        portraitbarView = UIView.init(frame: CGRect.init(x: self.frame.size.width/2-55*PROSIZE, y: 35*PROSIZE, width: 110*PROSIZE, height: 110*PROSIZE))
        portraitbarView?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        portraitbarView?.layer.cornerRadius = 55*PROSIZE
        portraitbarView?.layer.masksToBounds = true
        self.addSubview(portraitbarView!)
        
        let addLbl = UILabel.init(frame: CGRect.init(x: (portraitbarView!.frame.size.width-35*PROSIZE)/2, y: 30*PROSIZE, width: 35*PROSIZE, height: 35*PROSIZE))
        addLbl.text = "+"
        addLbl.textAlignment = NSTextAlignment.center
        addLbl.textColor = colorWithHex(hex: 0x999999)
        addLbl.font = UIFont.systemFont(ofSize: 54*PROSIZE)
        portraitbarView?.addSubview(addLbl)
        
        let addTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: portraitbarView!.frame.size.height-30*PROSIZE, width: portraitbarView!.frame.size.width, height: 30*PROSIZE))
        addTitleLbl.textColor = UIColor.white
        addTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        addTitleLbl.textAlignment = NSTextAlignment.center
        addTitleLbl.text = "添加头像"
        addTitleLbl.backgroundColor = colorWithHex(hex: 0x999999)
        portraitbarView?.addSubview(addTitleLbl)
        
        portraitImageView = UIImageView.init(frame: CGRect.init(x: self.frame.size.width/2-55*PROSIZE, y: 35*PROSIZE, width: 110*PROSIZE, height: 110*PROSIZE))
        portraitImageView?.isHidden = true
        portraitImageView?.layer.cornerRadius = 55*PROSIZE
        portraitImageView?.layer.masksToBounds = true
        self.addSubview(portraitImageView!)
        
        addPortaritBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        addPortaritBtn?.frame = CGRect.init(x: self.frame.size.width/2-55*PROSIZE, y: 35*PROSIZE, width: 110*PROSIZE, height: 110*PROSIZE)
        self.addSubview(addPortaritBtn!)
        
        let nickNameLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 165*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        nickNameLbl.textColor = colorWithHex(hex: 0x333333)
        nickNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        nickNameLbl.text = "昵称"
        self.addSubview(nickNameLbl)
        
        nickNameTxtF = UITextField.init(frame: CGRect.init(x: 27*PROSIZE, y: nickNameLbl.frame.origin.y+nickNameLbl.frame.size.height+6*PROSIZE, width: self.frame.size.width-54*PROSIZE, height: 33*PROSIZE))
        nickNameTxtF?.textColor = colorWithHex(hex: 0x333333)
        nickNameTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nickNameTxtF?.placeholder = "请输入姓名或昵称"
        self.addSubview(nickNameTxtF!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: nickNameTxtF!.frame.origin.y + nickNameTxtF!.frame.size.height+6*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        nextStepBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        nextStepBtn?.frame = CGRect.init(x: 20*PROSIZE, y: line.frame.origin.y+line.frame.size.height+21*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        nextStepBtn?.isUserInteractionEnabled = false
        nextStepBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        nextStepBtn?.setTitle("下一步", for: UIControl.State.normal)
        nextStepBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        nextStepBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nextStepBtn?.layer.cornerRadius = 5;
        nextStepBtn?.layer.masksToBounds = true
        self.addSubview(nextStepBtn!)
        
        waitSubmitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        waitSubmitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: nextStepBtn!.frame.origin.y+nextStepBtn!.frame.size.height+30*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 30*PROSIZE)
        waitSubmitBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        waitSubmitBtn?.setTitle("稍后提交", for: UIControl.State.normal)
        waitSubmitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(waitSubmitBtn!)
        
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
