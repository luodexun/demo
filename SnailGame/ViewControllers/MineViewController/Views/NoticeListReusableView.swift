//
//  NoticeListReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class NoticeListReusableView: UICollectionReusableView {
    
    var createDateLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let dateBarView = UIView.init(frame: CGRect.init(x: 0, y: 8*PROSIZE, width: self.frame.size.width, height: 38*PROSIZE))
        dateBarView.backgroundColor = UIColor.white
        self.addSubview(dateBarView)
        
        createDateLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: dateBarView.frame.size.width-40*PROSIZE, height: 13*PROSIZE))
        createDateLbl?.textColor = colorWithHex(hex: 0x999999)
        createDateLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        dateBarView.addSubview(createDateLbl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
