//
//  RightItemCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RightItemCell: UICollectionViewCell {
    
    var rightImageView : UIImageView?
    
    var rightNameLbl , rightDescLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rightImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-77*PROSIZE)/2, y: 0, width: 77*PROSIZE, height: 77*PROSIZE))
        rightImageView?.layer.cornerRadius = 77*PROSIZE/2
        rightImageView?.layer.masksToBounds = true
        rightImageView?.backgroundColor = colorWithHex(hex: 0xEAE0C0)
        self.addSubview(rightImageView!)
        
        rightNameLbl = UILabel.init(frame: CGRect.init(x: 0, y: rightImageView!.frame.origin.y+rightImageView!.frame.size.height+13*PROSIZE, width: self.frame.size.width, height: 14*PROSIZE))
        rightNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rightNameLbl?.textColor = colorWithHex(hex: 0x333333)
        rightNameLbl?.textAlignment = NSTextAlignment.center
        rightNameLbl?.text = "签到"
        self.addSubview(rightNameLbl!)
        
        rightDescLbl = UILabel.init(frame: CGRect.init(x: 0, y: rightNameLbl!.frame.origin.y+rightNameLbl!.frame.size.height+4*PROSIZE, width: self.frame.size.width, height: 12*PROSIZE))
        rightDescLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        rightDescLbl?.textColor = colorWithHex(hex: 0x999999)
        rightDescLbl?.textAlignment = NSTextAlignment.center
        rightDescLbl?.text = "双倍签到奖励"
        self.addSubview(rightDescLbl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
