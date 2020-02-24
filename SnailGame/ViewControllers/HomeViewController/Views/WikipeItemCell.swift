//
//  WikipeItemCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WikipeItemCell: UICollectionViewCell {
    
    var titleNameLbl , subTitleLbl : UILabel?
    
    var bgImageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImageView = UIImageView.init(frame: self.bounds)
        bgImageView?.layer.cornerRadius = 5
        bgImageView?.layer.masksToBounds = true
        self.addSubview(bgImageView!)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 16*PROSIZE, y: 15*PROSIZE, width: self.frame.size.width-32*PROSIZE, height: 15*PROSIZE))
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl?.textColor = colorWithHex(hex: 0xffffff)
        self.addSubview(titleNameLbl!)
        
        subTitleLbl = UILabel.init(frame: CGRect.init(x: 16*PROSIZE, y: 35*PROSIZE, width: self.frame.size.width-32*PROSIZE, height: 35*PROSIZE))
        subTitleLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        subTitleLbl?.textColor = colorWithHex(hex: 0xffffff)
        subTitleLbl?.numberOfLines = 0
        self.addSubview(subTitleLbl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
