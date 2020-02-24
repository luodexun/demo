//
//  RankListCell.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RankListCell: UICollectionViewCell {
    
    var rankNumLbl , userNameLbl , rewardNumLbl , integralNumLbl : UILabel?
    
    var userImageVeiw , rewardIcon : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rankNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        rankNumLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        rankNumLbl?.textAlignment = NSTextAlignment.center
        rankNumLbl?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        rankNumLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(rankNumLbl!)
        
        userImageVeiw = UIImageView.init(frame: CGRect.init(x: 50*PROSIZE, y: 15*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        userImageVeiw?.layer.cornerRadius = 10*PROSIZE
        userImageVeiw?.layer.masksToBounds = true
        self.addSubview(userImageVeiw!)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: 74*PROSIZE, y: 15*PROSIZE, width: 120*PROSIZE, height: 20*PROSIZE))
        userNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(userNameLbl!)
        
        rewardNumLbl = UILabel.init(frame: CGRect.init(x: 199*PROSIZE, y: 15*PROSIZE, width: 70*PROSIZE, height: 20*PROSIZE))
        rewardNumLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rewardNumLbl?.textColor = colorWithHex(hex: 0x333333)
        rewardNumLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(rewardNumLbl!)
        
        rewardIcon = UIImageView.init(frame: CGRect.init(x: (rewardNumLbl?.frame.size.width)!+(rewardNumLbl?.frame.origin.x)!, y: 15*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        rewardIcon?.image = UIImage.init(named: "ic_rank_list_candy")
        self.addSubview(rewardIcon!)
        
        integralNumLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-89*PROSIZE, y: 15*PROSIZE, width: 69*PROSIZE, height: 20*PROSIZE))
        integralNumLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        integralNumLbl?.textColor = colorWithHex(hex: 0x333333)
        integralNumLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(integralNumLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 50*PROSIZE, width: SCREEN_WIDE-20*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
    }
    
    func setRankListCell(pageModel:RankListPageModel) {
        if pageModel.ranknum == 1 {
            rankNumLbl?.backgroundColor = colorWithHex(hex: 0xFFEEAC)
        } else if pageModel.ranknum == 2 {
            rankNumLbl?.backgroundColor = colorWithHex(hex: 0xE4E4E4)
        } else if pageModel.ranknum == 3 {
            rankNumLbl?.backgroundColor = colorWithHex(hex: 0xF8E4DE)
        } else {
            rankNumLbl?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        }
        rankNumLbl?.text = String(pageModel.ranknum!)
        userImageVeiw?.dwn_setImageView(urlStr: pageModel.avatar!, imageName: "")
        userNameLbl?.text = pageModel.nickname
        rewardNumLbl?.text = String(pageModel.award!)
        integralNumLbl?.text = String(pageModel.integral!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
