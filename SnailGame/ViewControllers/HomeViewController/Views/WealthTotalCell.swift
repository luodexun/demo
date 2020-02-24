//
//  WealthTotalCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WealthTotalCell: UICollectionViewCell {
    
    var totalDwnLbl , totalMoneyLbl : UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        bg.image = UIImage.init(named: "ic_wealth_bg")
        self.addSubview(bg)
        
        totalDwnLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 62*PROSIZE+STABAR_HEIGHT, width: 100*PROSIZE, height: 27*PROSIZE))
        totalDwnLbl?.text = "150.3"
        totalDwnLbl?.font = UIFont.systemFont(ofSize: 36*PROSIZE)
        totalDwnLbl?.textColor = UIColor.white
        self.addSubview(totalDwnLbl!)
        
        totalMoneyLbl = UILabel.init(frame: CGRect.init(x: totalDwnLbl!.frame.origin.x+totalDwnLbl!.frame.size.width+10*PROSIZE, y: 76*PROSIZE+STABAR_HEIGHT, width: 160*PROSIZE, height: 14*PROSIZE))
        totalMoneyLbl?.text = "≈ ¥ 15.31"
        totalMoneyLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        totalMoneyLbl?.textColor = UIColor.white
        self.addSubview(totalMoneyLbl!)
        
        let totalTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: totalDwnLbl!.frame.origin.y+totalDwnLbl!.frame.size.height+9*PROSIZE, width: 200*PROSIZE, height: 17*PROSIZE))
        totalTitleLbl.textColor = UIColor.white
        totalTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        totalTitleLbl.text = "总资产（DWN）"
        self.addSubview(totalTitleLbl)
        
    }
    
    func setWealthTotalCell(totalDwn:String,totalRmb:String) {
        let totalSize = NSString.calStrSize(textStr: totalDwn as NSString, height: 27*PROSIZE, fontSize: 36*PROSIZE)
        totalDwnLbl?.frame.size.width = totalSize.width
        totalDwnLbl?.text = totalDwn
        totalMoneyLbl?.frame.origin.x = totalDwnLbl!.frame.origin.x+totalDwnLbl!.frame.size.width+10*PROSIZE
        totalMoneyLbl?.text = "≈ ¥ " + totalRmb
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
