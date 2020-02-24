//
//  PauseKeyCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PauseKeyCell: UICollectionViewCell {
    
    var itemNameLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = true
        
        itemNameLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: 0, width: 30*PROSIZE, height: 25*PROSIZE))
        itemNameLbl?.text = "trial"
        itemNameLbl?.textColor = colorWithHex(hex: 0xFF0F59)
        itemNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(itemNameLbl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPauseKeyCell(itemStr:String) {
        let itemSize = NSString.calStrSize(textStr: itemStr as NSString, height: 25*PROSIZE, fontSize: 15*PROSIZE)
        itemNameLbl?.frame = CGRect.init(x: 10*PROSIZE, y: 0, width: itemSize.width, height: 25*PROSIZE)
        itemNameLbl?.text = itemStr
    }
    
}
