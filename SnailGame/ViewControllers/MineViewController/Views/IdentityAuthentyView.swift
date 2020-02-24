//
//  IdentityAuthentyView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class IdentityAuthentyView: UIView {

    var positiveView , reverseView : UpdatePhotoView?

    var submitBtn , connectBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let promptBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 45*PROSIZE))
        promptBarView.backgroundColor = colorWithHex(hex: 0xFFFCE8)
        self.addSubview(promptBarView)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: promptBarView.frame.size.width-40*PROSIZE, height: promptBarView.frame.size.height))
        promptTitleLbl.text = "请在明亮的环境下拍摄身份证清晰照片。"
        promptTitleLbl.textColor = colorWithHex(hex: 0x333333)
        promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        promptBarView.addSubview(promptTitleLbl)
        
        let updateTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: promptBarView.frame.size.height+21*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        updateTitleLbl.text = "上传身份证照片"
        updateTitleLbl.textColor = colorWithHex(hex: 0x333333)
        updateTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(updateTitleLbl)
        
        positiveView = UpdatePhotoView.init(frame: CGRect.init(x: 20*PROSIZE, y: updateTitleLbl.frame.origin.y+updateTitleLbl.frame.size.height+20*PROSIZE, width: 160*PROSIZE, height: 150*PROSIZE))
        positiveView?.promptImageView?.image = UIImage.init(named: "ic_identity_authenty_positive")
        positiveView?.promptTitleLbl?.text = "正面身份证"
        self.addSubview(positiveView!)
        
        reverseView = UpdatePhotoView.init(frame: CGRect.init(x: self.frame.size.width-180*PROSIZE, y: updateTitleLbl.frame.origin.y+updateTitleLbl.frame.size.height+20*PROSIZE, width: 160*PROSIZE, height: 150*PROSIZE))
        reverseView?.promptImageView?.image = UIImage.init(named: "ic_identity_authenty_reverse")
        reverseView?.promptTitleLbl?.text = "反面身份证"
        self.addSubview(reverseView!)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: positiveView!.frame.origin.y+positiveView!.frame.size.height+26*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.layer.cornerRadius = 5
        submitBtn?.layer.masksToBounds = true
        self.addSubview(submitBtn!)
        
        let connectIcon = UIImageView.init(frame: CGRect.init(x: 22*PROSIZE, y: submitBtn!.frame.origin.y+submitBtn!.frame.size.height+20*PROSIZE, width: 23*PROSIZE, height: 23*PROSIZE))
        connectIcon.image = UIImage.init(named: "ic_region_warn")
        self.addSubview(connectIcon)
    
        let connectTitleLbl = UILabel.init(frame: CGRect.init(x: 56*PROSIZE, y: submitBtn!.frame.origin.y+submitBtn!.frame.size.height+22*PROSIZE, width: self.frame.size.width-80*PROSIZE, height: 18*PROSIZE))
        connectTitleLbl.textColor = colorWithHex(hex: 0x999999)
        connectTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(connectTitleLbl)
        
        let connectAttrStr = NSMutableAttributedString.init(string: "如无法认证成功，请联系客服")
        connectAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x0077FF), range:NSRange.init(location: 9, length: 4))
        connectTitleLbl.attributedText = connectAttrStr
        
        connectBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        connectBtn?.frame = CGRect.init(x: 22*PROSIZE, y: submitBtn!.frame.origin.y+submitBtn!.frame.size.height+20*PROSIZE, width: self.frame.size.width-44*PROSIZE, height: 23*PROSIZE)
        self.addSubview(connectBtn!)
        
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
