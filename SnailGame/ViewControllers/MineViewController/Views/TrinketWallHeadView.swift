//
//  TrinketWallHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TrinketWallHeadView: UIView {

    var userImageView : UIImageView?
    
    var userNameLbl , candyNumLbl : UILabel?
    
    var pushInfoBtn : UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xFAF9F7)
        
        userImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 50*PROSIZE, height: 50*PROSIZE))
        userImageView?.layer.cornerRadius = 25*PROSIZE
        userImageView?.layer.masksToBounds = true
        userImageView?.image = UIImage.init(named: "ic_mine_userDefault")
        self.addSubview(userImageView!)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: 80*PROSIZE, y: 20*PROSIZE, width: self.frame.size.width-110*PROSIZE, height: 16*PROSIZE))
        userNameLbl?.text = "柴火鸡"
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        userNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(userNameLbl!)
        
        let candyIcon = UIImageView.init(frame: CGRect.init(x: 80*PROSIZE, y: 40*PROSIZE, width: 16*PROSIZE, height: 16*PROSIZE))
        candyIcon.image = UIImage.init(named: "ic_mine_candy")
        self.addSubview(candyIcon)
        
        candyNumLbl = UILabel.init(frame: CGRect.init(x: 100*PROSIZE, y: 40*PROSIZE, width: self.frame.size.width-130*PROSIZE, height: 16*PROSIZE))
        candyNumLbl?.text = "20"
        candyNumLbl?.textColor = colorWithHex(hex: 0xFF6600)
        candyNumLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(candyNumLbl!)
        
        let nextIcon = UIImageView.init(frame: CGRect.init(x: self.frame.size.width-28*PROSIZE, y: 33*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        nextIcon.image = UIImage.init(named: "ic_mine_next")
        self.addSubview(nextIcon)
        
        pushInfoBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        pushInfoBtn?.frame = self.bounds
        self.addSubview(pushInfoBtn!)
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
