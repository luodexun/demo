//
//  CowSayHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CowSayHeadView: UIView {
    
    var sayBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 21*PROSIZE, width: SCREEN_WIDE-150*PROSIZE, height: 18*PROSIZE))
        titleNameLbl.text = "游戏人生，吹牛的牛逼的说";
        titleNameLbl.textColor = colorWithHex(hex: 0x0077FF)
        titleNameLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        self.addSubview(titleNameLbl)
        
        let noteContentLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 45*PROSIZE, width: SCREEN_WIDE-150*PROSIZE, height: 12*PROSIZE))
        noteContentLbl.text = "文明的说，请遵守相关法律法规";
        noteContentLbl.textColor = colorWithHex(hex: 0x999999)
        noteContentLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(noteContentLbl)
        
        sayBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        sayBtn?.frame = CGRect.init(x: SCREEN_WIDE-120*PROSIZE, y: 18*PROSIZE, width: 100*PROSIZE, height: 40*PROSIZE)
        sayBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        sayBtn?.setTitle("+ 我要说", for: UIControl.State.normal)
        sayBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sayBtn?.layer.cornerRadius = 5
        sayBtn?.layer.masksToBounds = true
        self.addSubview(sayBtn!)
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
