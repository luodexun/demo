//
//  PromotionVipUserCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionVipUserCell: UICollectionViewCell {
    
    var userImageView : UIImageView?
    
    var userNameLbl , isOpenLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: 185*PROSIZE))
        self.addSubview(barView)
        
        let bg = UIImageView.init(frame: barView.bounds)
        bg.image = UIImage.init(named: "ic_promotion_vip_bg")
        barView.addSubview(bg)
        
        userImageView = UIImageView.init(frame: CGRect.init(x: 30*PROSIZE, y: 26*PROSIZE, width: 50*PROSIZE, height: 50*PROSIZE))
        userImageView?.image = UIImage.init(named: "ic_mine_userDefault")
        userImageView?.layer.cornerRadius = 25*PROSIZE
        userImageView?.layer.masksToBounds = true
        barView.addSubview(userImageView!)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: userImageView!.frame.origin.x+userImageView!.frame.size.width+15*PROSIZE, y: 33*PROSIZE, width: barView.frame.size.width-115*PROSIZE, height: 17*PROSIZE))
        userNameLbl?.text = "蒂娜"
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        userNameLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        barView.addSubview(userNameLbl!)
        
        isOpenLbl = UILabel.init(frame: CGRect.init(x: userImageView!.frame.origin.x+userImageView!.frame.size.width+15*PROSIZE, y: 55*PROSIZE, width: 52*PROSIZE, height: 20*PROSIZE))
        isOpenLbl?.text = "未开通"
        isOpenLbl?.textColor = UIColor.white
        isOpenLbl?.backgroundColor = colorWithHex(hex: 0xcccccc)
        isOpenLbl?.layer.cornerRadius = 2
        isOpenLbl?.layer.masksToBounds = true
        isOpenLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        isOpenLbl?.textAlignment = NSTextAlignment.center
        barView.addSubview(isOpenLbl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
