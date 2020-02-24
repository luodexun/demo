//
//  MineCandyReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineCandyReusableView: UICollectionReusableView {
    
    var candyNumLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height-100*PROSIZE))
        bg.image = UIImage.init(named: "ic_mine_candy_bg")
        self.addSubview(bg)
        
        candyNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: STABAR_HEIGHT+44+15*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 38*PROSIZE))
        candyNumLbl?.font = UIFont.systemFont(ofSize: 50*PROSIZE)
        candyNumLbl?.textAlignment = NSTextAlignment.center
        candyNumLbl?.textColor = UIColor.white
        candyNumLbl?.text = "0"
        self.addSubview(candyNumLbl!)
        
        let candyTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: candyNumLbl!.frame.size.height+candyNumLbl!.frame.origin.y+17*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 16*PROSIZE))
        candyTitleLbl.text = "DCandy / 糖果"
        candyTitleLbl.textAlignment = NSTextAlignment.center
        candyTitleLbl.textColor = UIColor.white
        candyTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(candyTitleLbl)
        
        let candyNoteLbl = UILabel.init(frame: CGRect.init(x: 0, y: bg.frame.size.height+bg.frame.origin.y, width: self.frame.size.width, height: 100*PROSIZE))
        candyNoteLbl.text = "蜗牛糖果，简称糖果，也可称为Dcandy。\n糖果将来可能直接兑换DWN哦。"
        candyNoteLbl.textAlignment = NSTextAlignment.center
        candyNoteLbl.textColor = colorWithHex(hex: 0x333333)
        candyNoteLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        candyNoteLbl.numberOfLines = 0
        self.addSubview(candyNoteLbl)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
