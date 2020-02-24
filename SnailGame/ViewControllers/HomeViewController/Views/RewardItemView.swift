//
//  RewardItemView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RewardItemView: UIView {
    
    var titleNameLbl , subtitleNameLbl : UILabel?
    
    var titleImageView : UIImageView?
    
    var itemPushBtn : UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 5*PROSIZE, y: 18*PROSIZE, width: self.frame.size.width-10*PROSIZE, height: 14*PROSIZE))
        titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(titleNameLbl!)
        
        subtitleNameLbl = UILabel.init(frame: CGRect.init(x: 5*PROSIZE, y: 35*PROSIZE, width: self.frame.size.width-10*PROSIZE, height: 12*PROSIZE))
        subtitleNameLbl?.textColor = colorWithHex(hex: 0x999999)
        subtitleNameLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        subtitleNameLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(subtitleNameLbl!)
        
        titleImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 50*PROSIZE, width: self.frame.size.width, height: 50*PROSIZE))
        self.addSubview(titleImageView!)
        
        itemPushBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        itemPushBtn?.frame = self.bounds
        self.addSubview(itemPushBtn!)
        
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
