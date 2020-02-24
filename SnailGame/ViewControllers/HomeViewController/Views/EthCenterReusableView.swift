//
//  EthCenterReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class EthCenterReusableView: UICollectionReusableView {
    
    var dateLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        dateLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 16*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 21*PROSIZE))
        dateLbl?.textColor = colorWithHex(hex: 0x333333)
        dateLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(dateLbl!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
