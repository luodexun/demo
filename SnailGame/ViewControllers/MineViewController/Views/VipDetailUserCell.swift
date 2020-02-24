//
//  VipDetailUserCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class VipDetailUserCell: UICollectionViewCell {
    
    var userImageView : UIImageView?
    
    var userNameLbl , vipNameLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: 185*PROSIZE))
        self.addSubview(barView)
        
        let bg = UIImageView.init(frame: barView.bounds)
        bg.image = UIImage.init(named: "ic_vip_detail_bg")
        barView.addSubview(bg)
        
        userImageView = UIImageView.init(frame: CGRect.init(x: 30*PROSIZE, y: 26*PROSIZE, width: 50*PROSIZE, height: 50*PROSIZE))
        userImageView?.layer.cornerRadius = 25*PROSIZE
        userImageView?.layer.masksToBounds = true
        barView.addSubview(userImageView!)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: userImageView!.frame.origin.x+userImageView!.frame.size.width+15*PROSIZE, y: 37*PROSIZE, width: barView.frame.size.width-115*PROSIZE, height: 17*PROSIZE))
        userNameLbl?.textColor = UIColor.white
        userNameLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        barView.addSubview(userNameLbl!)
        
        vipNameLbl = UILabel.init(frame: CGRect.init(x: userImageView!.frame.origin.x+userImageView!.frame.size.width+15*PROSIZE, y: 57*PROSIZE, width: 48*PROSIZE, height: 18*PROSIZE))
        vipNameLbl?.text = "VIP"
        vipNameLbl?.textColor = colorWithHex(hex: 0x333333)
        vipNameLbl?.backgroundColor = colorWithHex(hex: 0xE8CF73)
        vipNameLbl?.layer.cornerRadius = 2
        vipNameLbl?.layer.masksToBounds = true
        vipNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        vipNameLbl?.textAlignment = NSTextAlignment.center
        barView.addSubview(vipNameLbl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
