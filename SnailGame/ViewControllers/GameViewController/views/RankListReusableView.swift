//
//  RankListReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RankListReusableView: UICollectionReusableView {
 
    var remainTimeLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let warnImageView = UIImageView.init(frame: CGRect.init(x: 22*PROSIZE, y: 16*PROSIZE, width: 23*PROSIZE, height: 23*PROSIZE))
        warnImageView.image = UIImage.init(named: "ic_region_warn")
        self.addSubview(warnImageView)
        
        remainTimeLbl = UILabel.init(frame: CGRect.init(x: 57*PROSIZE, y: 16*PROSIZE, width: SCREEN_WIDE-77*PROSIZE, height: 23*PROSIZE))
        remainTimeLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        remainTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(remainTimeLbl!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
