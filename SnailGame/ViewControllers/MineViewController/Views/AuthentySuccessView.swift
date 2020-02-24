//
//  AuthentySuccessView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AuthentySuccessView: UIView {

    var userImageView , authenImageView : UIImageView?
    
    var userNameLbl , realNameLbl , idNumberLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: self.frame.size.height-250*PROSIZE, width: self.frame.size.width, height: 250*PROSIZE))
        bg.image = UIImage.init(named: "ic_authenty_bg_snial")
        self.addSubview(bg)
        
        userImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-80*PROSIZE)/2, y: 36*PROSIZE, width: 80*PROSIZE, height: 80*PROSIZE))
        userImageView?.image = UIImage.init(named: "ic_mine_portrait_default")
        userImageView?.layer.cornerRadius = 40*PROSIZE
        userImageView?.layer.masksToBounds = true
        self.addSubview(userImageView!)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: userImageView!.frame.origin.y+userImageView!.frame.size.height+9*PROSIZE, width: self.frame.size.width-60*PROSIZE, height: 24*PROSIZE))
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        userNameLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        userNameLbl?.text = ""
        userNameLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(userNameLbl!)
        
        authenImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-90*PROSIZE)/2, y: userNameLbl!.frame.origin.y+userNameLbl!.frame.size.height+7*PROSIZE, width: 90*PROSIZE, height: 30*PROSIZE))
        authenImageView?.image = UIImage.init(named: "ic_authenty_complate")
        self.addSubview(authenImageView!)
        
        let idBarView = UIView.init(frame: CGRect.init(x: 25*PROSIZE, y: authenImageView!.frame.origin.y+authenImageView!.frame.size.height+40*PROSIZE, width: self.frame.size.width-50*PROSIZE, height: 190*PROSIZE))
        self.addSubview(idBarView)
        
        let cardBG = UIImageView.init(frame: idBarView.bounds)
        cardBG.image = UIImage.init(named: "ic_authenty_bg")
        idBarView.addSubview(cardBG)
        
        let nameTitleLbl = UILabel.init(frame: CGRect.init(x: 48*PROSIZE, y: 44*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        nameTitleLbl.text = "姓名"
        nameTitleLbl.textColor = colorWithHex(hex: 0x999999)
        nameTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        idBarView.addSubview(nameTitleLbl)
        
        realNameLbl = UILabel.init(frame: CGRect.init(x: 48*PROSIZE, y: nameTitleLbl.frame.origin.y+nameTitleLbl.frame.size.height+4*PROSIZE, width: idBarView.frame.size.width-96*PROSIZE, height: 23*PROSIZE))
        realNameLbl?.textColor = colorWithHex(hex: 0x333333)
        realNameLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        realNameLbl?.text = "***"
        idBarView.addSubview(realNameLbl!)
        
        let cardTitleLbl = UILabel.init(frame: CGRect.init(x: 48*PROSIZE, y: realNameLbl!.frame.origin.y+realNameLbl!.frame.size.height+20*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        cardTitleLbl.text = "身份证号"
        cardTitleLbl.textColor = colorWithHex(hex: 0x999999)
        cardTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        idBarView.addSubview(cardTitleLbl)
        
        idNumberLbl = UILabel.init(frame: CGRect.init(x: 48*PROSIZE, y: cardTitleLbl.frame.origin.y+cardTitleLbl.frame.size.height+7*PROSIZE, width: idBarView.frame.size.width-96*PROSIZE, height: 23*PROSIZE))
        idNumberLbl?.textColor = colorWithHex(hex: 0x333333)
        idNumberLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        idNumberLbl?.text = "**********"
        idBarView.addSubview(idNumberLbl!)
        
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
