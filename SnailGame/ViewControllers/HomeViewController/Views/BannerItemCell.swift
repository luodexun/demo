//
//  BannerItemCell.swift
//  SnailGame
//
//  Created by Edison on 2019/12/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class BannerItemCell: UICollectionViewCell {
    
    var bannerImageView : UIImageView?
    
    var bannerTitleLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        bannerImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 110*PROSIZE))
        bannerImageView?.layer.cornerRadius = 10
        bannerImageView?.layer.masksToBounds = true
        self.addSubview(bannerImageView!)
        
        bannerTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 120*PROSIZE, width: self.frame.size.width, height: 16*PROSIZE))
        bannerTitleLbl?.textColor = colorWithHex(hex: 0x333333)
        bannerTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(bannerTitleLbl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
