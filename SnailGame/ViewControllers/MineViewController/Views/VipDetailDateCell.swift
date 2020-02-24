//
//  VipDetailDateCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class VipDetailDateCell: UICollectionViewCell {
    
    var dateLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: self.frame.size.height))
        barView.backgroundColor = colorWithHex(hex: 0xFFDFE9)
        barView.layer.cornerRadius = 10
        barView.layer.masksToBounds = true
        self.addSubview(barView)
        
        dateLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: barView.frame.size.width-40*PROSIZE, height: barView.frame.size.height))
        dateLbl?.textColor = colorWithHex(hex: 0x333333)
        dateLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dateLbl?.numberOfLines = 0
        dateLbl?.textAlignment = NSTextAlignment.center
        barView.addSubview(dateLbl!)
        
    }
    
    func setVipDetailDateCell(infoModel:VipInfoDataModel) {
        let dateStr = String(infoModel.sum_days!)
        let dateAttrStr = NSMutableAttributedString.init(string: "蜗牛VIP已陪伴您 " + dateStr + " 天\n希望您由此而拥有更多数字资产")
        dateAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xFF0F59), range:NSRange.init(location:10, length: dateStr.count))
        dateLbl?.attributedText = dateAttrStr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
