//
//  MineCandyCell.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineCandyCell: UICollectionViewCell {
    
    var noteImageView : UIImageView?
    
    var candyNumLbl , sentyLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        noteImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 100*PROSIZE))
        self.addSubview(noteImageView!)
    
        candyNumLbl = UILabel.init(frame: CGRect.init(x: 5*PROSIZE, y: 110*PROSIZE, width: self.frame.size.width-10*PROSIZE, height: 12*PROSIZE))
        candyNumLbl?.textColor = colorWithHex(hex: 0x333333)
        candyNumLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        candyNumLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(candyNumLbl!)
    
        sentyLbl = UILabel.init(frame: CGRect.init(x: 5*PROSIZE, y: 132*PROSIZE, width: self.frame.size.width-10*PROSIZE, height: 12*PROSIZE))
        sentyLbl?.textColor = colorWithHex(hex: 0x999999)
        sentyLbl?.numberOfLines = 0
        sentyLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(sentyLbl!)
        
    }
    
    func setMineCandyCell(candyModel:ConfigCandyModel) {
        noteImageView?.dwn_setImageView(urlStr: candyModel.url!, imageName: "")
        let candyStr = candyModel.candy!
        let numAttrStr = NSMutableAttributedString.init(string: candyStr+" 糖果/次")
        numAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xFF0F59), range:NSRange.init(location:0, length: candyStr.count))
        candyNumLbl?.attributedText = numAttrStr
        
        let sentySize = NSString.calStrSize(textStr: candyModel.title! as NSString, width: self.frame.size.width-10*PROSIZE, fontSize: 12*PROSIZE)
        sentyLbl?.frame.size.height = sentySize.height
        sentyLbl?.text = candyModel.title
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
