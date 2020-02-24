//
//  ReleaseSayView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ReleaseSayView: UIScrollView {
    
    var sayTextView : SnailTextView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 85*PROSIZE))
        barView.backgroundColor = colorWithHex(hex: 0xFFFCE8)
        self.addSubview(barView)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: barView.frame.size.width-40*PROSIZE, height: 85*PROSIZE))
        promptTitleLbl.numberOfLines = 0
        promptTitleLbl.text = "恭喜您获得牛说内测权限，做牛说的KOL；请发布与游戏、区块链相关内容；每条牛说发布会扣除您的100个糖果；每条牛说都需要审核。"
        promptTitleLbl.textColor = colorWithHex(hex: 0x333333)
        promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        barView.addSubview(promptTitleLbl)
        
        sayTextView = SnailTextView.init(placeholder: "请输入牛说内容", placeholderColor: colorWithHex(hex: 0xcccccc), frame: CGRect.init(x: 0, y: barView.frame.size.height, width: self.frame.size.width, height: 300*PROSIZE))
        sayTextView?.palceholdertextView.textColor = colorWithHex(hex: 0x333333)
        sayTextView?.isShowCountLabel = false
        self.addSubview(sayTextView!)
        
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
