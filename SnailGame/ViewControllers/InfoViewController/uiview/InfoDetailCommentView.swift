//
//  InfoDetailCommentView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class InfoDetailCommentView: UIScrollView {

    var commentTextF : UITextField?
    
    var sendBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        commentTextF = UITextField.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-100*PROSIZE, height: self.frame.size.height))
        commentTextF?.placeholder = "请输入评论内容"
        commentTextF?.textColor = colorWithHex(hex: 0x333333)
        commentTextF?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(commentTextF!)
        
        sendBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        sendBtn?.frame = CGRect.init(x: self.frame.size.width-70*PROSIZE, y: 10*PROSIZE, width: 50*PROSIZE, height: 30*PROSIZE)
        sendBtn?.backgroundColor = colorWithHex(hex: 0x0077ff)
        sendBtn?.setTitle("发送", for: UIControl.State.normal)
        sendBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sendBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        sendBtn?.layer.cornerRadius = 5
        sendBtn?.layer.masksToBounds = true
        self.addSubview(sendBtn!)
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
