//
//  MineHeadReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol MineHeadPushDelegate {
    func MineHeadPushAction(opera:Int)
}

class MineHeadReusableView: UICollectionReusableView {
    
    var userImageView : UIImageView?
    
    var userInfoView : MineUserInfoView?
    
    var loginTitleLbl : UILabel?
    
    var vipView : UIView?
    
    var mineDelegate : MineHeadPushDelegate?

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let bg = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-210*PROSIZE, y: 0, width: 210*PROSIZE, height: 140*PROSIZE+STABAR_HEIGHT))
        bg.image = UIImage.init(named: "ic_mine_bg")
        self.addSubview(bg)
        
        userImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 60*PROSIZE+STABAR_HEIGHT, width: 50*PROSIZE, height: 50*PROSIZE))
        userImageView?.layer.cornerRadius = 25*PROSIZE
        userImageView?.layer.masksToBounds = true
        self.addSubview(userImageView!)
        
        userInfoView = MineUserInfoView.init(frame: CGRect.init(x: 80*PROSIZE, y: 60*PROSIZE+STABAR_HEIGHT, width: SCREEN_WIDE-110*PROSIZE, height: 50*PROSIZE))
        self.addSubview(userInfoView!)
        
        loginTitleLbl = UILabel.init(frame: CGRect.init(x: 80*PROSIZE, y: 75*PROSIZE+STABAR_HEIGHT, width: SCREEN_WIDE-110*PROSIZE, height: 20*PROSIZE))
        loginTitleLbl?.textColor = colorWithHex(hex: 0x333333)
        loginTitleLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        loginTitleLbl?.isHidden = true
        loginTitleLbl?.text = "登录 / 注册";
        self.addSubview(loginTitleLbl!)
        
        let nextIcon = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 78*PROSIZE+STABAR_HEIGHT, width: 8*PROSIZE, height: 14*PROSIZE))
        nextIcon.image = UIImage.init(named: "ic_mine_next")
        self.addSubview(nextIcon)
        
        let pushLoginBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        pushLoginBtn.frame = CGRect.init(x: 20*PROSIZE, y: 60*PROSIZE+STABAR_HEIGHT, width: SCREEN_WIDE-40*PROSIZE, height: 50*PROSIZE)
        pushLoginBtn.addTarget(self, action: #selector(pushLoginAction), for: UIControl.Event.touchUpInside)
        pushLoginBtn.tag = 800;
        self.addSubview(pushLoginBtn)
        
        vipView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: (userImageView?.frame.origin.y)!+(userImageView?.frame.size.height)!+24*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 65*PROSIZE))
        self.addSubview(vipView!)
        
        let vipImageView = UIImageView.init(frame: vipView!.bounds)
        vipImageView.image = UIImage.init(named: "ic_mine_vip_bg")
        vipView!.addSubview(vipImageView)
        
        let vipTitleLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 16*PROSIZE, width: vipView!.frame.size.width-50*PROSIZE, height: 18*PROSIZE))
        vipTitleLbl.text = "蜗牛VIP，创造新世界";
        vipTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        vipTitleLbl.textColor = colorWithHex(hex: 0xFFE38E)
        vipView!.addSubview(vipTitleLbl)
        
        let vipDescLbl = UILabel.init(frame: CGRect.init(x: 25*PROSIZE, y: 38*PROSIZE, width: vipView!.frame.size.width-50*PROSIZE, height: 12*PROSIZE))
        vipDescLbl.textColor = UIColor.white
        vipDescLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        vipDescLbl.text = "特权持续增加中…";
        vipView!.addSubview(vipDescLbl)

        let vipBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        vipBtn.frame = vipView!.bounds
        vipBtn.addTarget(self, action: #selector(pushVipAction), for: UIControl.Event.touchUpInside)
        vipView!.addSubview(vipBtn)
    
    }
    
    func setMineHeadReusableView (userModel:UserLoginDataModel,isService:Int) {
        
        if isService == 1 {
            vipView?.isHidden = false
        } else {
            vipView?.isHidden = true
        }
        
        if userModel.mobile != nil {
            userInfoView?.isHidden = false
            loginTitleLbl?.isHidden = true
            userImageView?.dwn_setImageView(urlStr: userModel.avatar!, imageName: "ic_mine_portrait_default")
            userInfoView?.setMineUserInfoView(userModel: userModel,isService: isService)
        } else {
            userInfoView?.isHidden = true
            loginTitleLbl?.isHidden = false
            userImageView?.image = UIImage.init(named: "ic_mine_portrait_default")
        }
    }
    
    @objc func pushLoginAction(sender:UIButton) {
        mineDelegate!.MineHeadPushAction(opera: 1)
    }
    
    @objc func pushVipAction(tap:UIGestureRecognizer) {
        mineDelegate!.MineHeadPushAction(opera: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
