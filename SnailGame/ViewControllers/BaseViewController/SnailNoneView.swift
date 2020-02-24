//
//  SnailNoneView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SnailNoneView: UIView {
    
    var noneImageView : UIImageView?
    
    var noneTitleLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        noneImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-85*PROSIZE)/2, y: (self.frame.size.height-200*PROSIZE)/2, width: 85*PROSIZE, height: 85*PROSIZE))
        noneImageView?.image = UIImage.init(named: "ic_snail_none")
        self.addSubview(noneImageView!)
        
        noneTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (noneImageView?.frame.origin.y)!+(noneImageView?.frame.size.height)!+10*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 20*PROSIZE))
        noneTitleLbl?.textColor = colorWithHex(hex: 0x999999)
        noneTitleLbl?.text = "还没有任何内容"
        noneTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noneTitleLbl?.textAlignment = .center
        self.addSubview(noneTitleLbl!)
        
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
