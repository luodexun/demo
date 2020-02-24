//
//  TrinketWallReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TrinketWallReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 29*PROSIZE, width: self.frame.size.width, height: 23*PROSIZE))
        titleLbl.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        titleLbl.textAlignment = NSTextAlignment.center
        titleLbl.textColor = colorWithHex(hex: 0xC8C3B4)
        titleLbl.text = "因为骄傲，所以快乐"
        self.addSubview(titleLbl)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
