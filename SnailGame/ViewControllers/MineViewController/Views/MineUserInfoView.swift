//
//  MineUserInfoView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineUserInfoView: UIView {

    var userNameLbl,candyNumLbl : UILabel?
    
    var candyIcon , vipIcon , richIcon , cowIcon : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: 0, y: 5*PROSIZE, width: 50*PROSIZE, height: 16*PROSIZE))
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        userNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(userNameLbl!)
        
        candyIcon = UIImageView.init(frame: CGRect.init(x: (userNameLbl?.frame.origin.x)!+(userNameLbl?.frame.size.width)!+11*PROSIZE, y: 5*PROSIZE, width: 16*PROSIZE, height: 16*PROSIZE))
        candyIcon?.image = UIImage.init(named: "ic_mine_candy")
        self.addSubview(candyIcon!)
        
        candyNumLbl = UILabel.init(frame: CGRect.init(x: (candyIcon?.frame.origin.x)!+(candyIcon?.frame.size.width)!+4*PROSIZE, y: 5*PROSIZE, width: 80*PROSIZE, height: 16*PROSIZE))
        candyNumLbl?.textColor = colorWithHex(hex: 0xff6600)
        candyNumLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(candyNumLbl!)
        
        vipIcon = UIImageView.init(frame: CGRect.init(x: 0, y: 28*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        self.addSubview(vipIcon!)
        
        richIcon = UIImageView.init(frame: CGRect.init(x: (vipIcon?.frame.origin.x)!+(vipIcon?.frame.size.width)!+10*PROSIZE, y: 28*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        self.addSubview(richIcon!)
        
        cowIcon = UIImageView.init(frame: CGRect.init(x: (richIcon?.frame.origin.x)!+(richIcon?.frame.size.width)!+10*PROSIZE, y: 28*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        self.addSubview(cowIcon!)
        
    }
    
    func setMineUserInfoView(userModel:UserLoginDataModel,isService:Int) {
        let nameSize : CGSize = NSString.calStrSize(textStr: userModel.nickname! as NSString, height: 16*PROSIZE, fontSize: 17*PROSIZE)
        userNameLbl?.frame.size.width = nameSize.width
        candyIcon?.frame.origin.x = (userNameLbl?.frame.origin.x)!+(userNameLbl?.frame.size.width)!+11*PROSIZE
        userNameLbl?.text = userModel.nickname
        candyNumLbl?.frame.origin.x = (candyIcon?.frame.origin.x)!+(candyIcon?.frame.size.width)!+4*PROSIZE
        candyNumLbl?.text = String(userModel.candy!);
        
        if userModel.badge?.count == 0 || isService == 0 {
            userNameLbl?.frame.origin.y = 17*PROSIZE
            candyIcon?.frame.origin.y = 17*PROSIZE
            candyNumLbl?.frame.origin.y = 17*PROSIZE
        } else {
            userNameLbl?.frame.origin.y = 5*PROSIZE
            candyIcon?.frame.origin.y = 5*PROSIZE
            candyNumLbl?.frame.origin.y = 5*PROSIZE
        }
        
        if isService == 0 {
            vipIcon?.isHidden = true
            richIcon?.isHidden = true
            cowIcon?.isHidden = true
        } else {
            if userModel.badge!.count > 2 {
                
                vipIcon?.isHidden = false
                richIcon?.isHidden = false
                cowIcon?.isHidden = false
                
                let badgeModel1 : UserLoginBadgeModel = userModel.badge![0]
                vipIcon?.dwn_setImageView(urlStr: badgeModel1.icon! , imageName: "")
                
                let badgeModel2 : UserLoginBadgeModel = userModel.badge![1]
                richIcon?.dwn_setImageView(urlStr: badgeModel2.icon! , imageName: "")
                
                let badgeModel3 : UserLoginBadgeModel = userModel.badge![2]
                cowIcon?.dwn_setImageView(urlStr: badgeModel3.icon! , imageName: "")
                
            } else if userModel.badge!.count > 1 {
                
                vipIcon?.isHidden = false
                richIcon?.isHidden = false
                cowIcon?.isHidden = true
                
                let badgeModel1 : UserLoginBadgeModel = userModel.badge![0]
                vipIcon?.dwn_setImageView(urlStr: badgeModel1.icon! , imageName: "")
                
                let badgeModel2 : UserLoginBadgeModel = userModel.badge![1]
                richIcon?.dwn_setImageView(urlStr: badgeModel2.icon! , imageName: "")
                
            }  else if userModel.badge!.count > 0 {
                vipIcon?.isHidden = false
                richIcon?.isHidden = true
                cowIcon?.isHidden = true
                let badgeModel1 : UserLoginBadgeModel = userModel.badge![0]
                vipIcon?.dwn_setImageView(urlStr: badgeModel1.icon! , imageName: "")
                
            } else {
                vipIcon?.isHidden = true
                richIcon?.isHidden = true
                cowIcon?.isHidden = true
            }
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
