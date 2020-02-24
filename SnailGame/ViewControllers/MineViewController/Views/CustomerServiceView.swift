//
//  CustomerServiceView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CustomerServiceView: UIScrollView {
    
    var noteTxtView : SnailTextView?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let noteBarView = UIView.init(frame: CGRect.init(x: 0, y: 10*PROSIZE, width: self.frame.size.width, height: 266*PROSIZE))
        noteBarView.backgroundColor = UIColor.white
        self.addSubview(noteBarView)
        
        let noteTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: 20*PROSIZE, width: 300*PROSIZE, height: 14*PROSIZE))
        noteTitleLbl.text = "请您留言，我们会第一时间给您回复。"
        noteTitleLbl.textColor = colorWithHex(hex: 0x999999)
        noteTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteBarView.addSubview(noteTitleLbl)
        
        noteTxtView = SnailTextView.init(placeholder: "请输入留言", placeholderColor: colorWithHex(hex: 0xcccccc), frame: CGRect.init(x: 20*PROSIZE, y: 55*PROSIZE, width: noteBarView.frame.size.width-40*PROSIZE, height: 120*PROSIZE))
        noteTxtView?.palceholdertextView.textColor = colorWithHex(hex: 0x333333)
        noteTxtView?.isShowCountLabel = false
        noteBarView.addSubview(noteTxtView!)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: noteTxtView!.frame.origin.y+noteTxtView!.frame.size.height+26*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.layer.cornerRadius = 5
        submitBtn?.layer.masksToBounds = true
        noteBarView.addSubview(submitBtn!)
        
        let codeBarView = UIView.init(frame: CGRect.init(x: 0, y: noteBarView.frame.origin.y+noteBarView.frame.size.height+10*PROSIZE, width: self.frame.size.width, height: 317*PROSIZE))
        codeBarView.backgroundColor = UIColor.white
        self.addSubview(codeBarView)
        
        let codeTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: 20*PROSIZE, width: 300*PROSIZE, height: 14*PROSIZE))
        codeTitleLbl.text = "添加客服微信 / 关注公众号"
        codeTitleLbl.textColor = colorWithHex(hex: 0x999999)
        codeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        codeBarView.addSubview(codeTitleLbl)
        
        let wechatIcon = UIImageView.init(frame: CGRect.init(x: 30*PROSIZE, y: codeTitleLbl.frame.origin.y+codeTitleLbl.frame.size.height+10*PROSIZE, width: 140*PROSIZE, height: 140*PROSIZE))
        wechatIcon.image = UIImage.init(named: "ic_customer_service_wechat")
        codeBarView.addSubview(wechatIcon)
        
        let wechatTitleLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: wechatIcon.frame.origin.y+wechatIcon.frame.size.height+5*PROSIZE, width: 140*PROSIZE, height: 13*PROSIZE))
        wechatTitleLbl.text = "客服微信号"
        wechatTitleLbl.textColor = colorWithHex(hex: 0x999999)
        wechatTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        wechatTitleLbl.textAlignment = NSTextAlignment.center
        codeBarView.addSubview(wechatTitleLbl)
        
        let wechatAccountLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: wechatTitleLbl.frame.origin.y+wechatTitleLbl.frame.size.height+7*PROSIZE, width: 140*PROSIZE, height: 15*PROSIZE))
        wechatAccountLbl.text = "digi-snail2"
        wechatAccountLbl.textColor = colorWithHex(hex: 0x0077FF)
        wechatAccountLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        wechatAccountLbl.textAlignment = NSTextAlignment.center
        codeBarView.addSubview(wechatAccountLbl)
        
        let publicIcon = UIImageView.init(frame: CGRect.init(x: codeBarView.frame.size.width-170*PROSIZE, y: codeTitleLbl.frame.origin.y+codeTitleLbl.frame.size.height+10*PROSIZE, width: 140*PROSIZE, height: 140*PROSIZE))
        publicIcon.image = UIImage.init(named: "ic_customer_service_public")
        codeBarView.addSubview(publicIcon)
        
        let publicTitleLbl = UILabel.init(frame: CGRect.init(x: codeBarView.frame.size.width-170*PROSIZE, y: publicIcon.frame.origin.y+publicIcon.frame.size.height+5*PROSIZE, width: 140*PROSIZE, height: 13*PROSIZE))
        publicTitleLbl.text = "关注公众号"
        publicTitleLbl.textColor = colorWithHex(hex: 0x999999)
        publicTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        publicTitleLbl.textAlignment = NSTextAlignment.center
        codeBarView.addSubview(publicTitleLbl)
        
        let publicAccountLbl = UILabel.init(frame: CGRect.init(x: codeBarView.frame.size.width-170*PROSIZE, y: publicTitleLbl.frame.origin.y+publicTitleLbl.frame.size.height+7*PROSIZE, width: 140*PROSIZE, height: 15*PROSIZE))
        publicAccountLbl.text = "大蜗牛区块链"
        publicAccountLbl.textColor = colorWithHex(hex: 0x0077FF)
        publicAccountLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        publicAccountLbl.textAlignment = NSTextAlignment.center
        codeBarView.addSubview(publicAccountLbl)
        
        let promptBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: wechatAccountLbl.frame.origin.y+wechatAccountLbl.frame.size.height+15*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 50*PROSIZE))
        promptBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        codeBarView.addSubview(promptBarView)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: promptBarView.frame.size.width-40*PROSIZE, height: promptBarView.frame.size.height))
        promptTitleLbl.text = "添加客服微信、关注公众号，保持联系。"
        promptTitleLbl.textColor = colorWithHex(hex: 0xFF0048)
        promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        promptBarView.addSubview(promptTitleLbl)
        
        self.contentSize = CGSize.init(width: self.frame.size.width, height: 630*PROSIZE)
        
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
