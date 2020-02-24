//
//  CowSayCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CowSayCell: UICollectionViewCell {
    
    var userImageView : UIImageView?
    
    var userNameLbl , sendTimeLbl , sayContentLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        userImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: 40*PROSIZE, height: 40*PROSIZE))
        userImageView?.layer.cornerRadius = 20*PROSIZE
        userImageView?.layer.masksToBounds = true
        self.addSubview(userImageView!)
        
        userNameLbl = UILabel.init(frame: CGRect.init(x: 76*PROSIZE, y: 23*PROSIZE, width: SCREEN_WIDE-96*PROSIZE, height: 16*PROSIZE))
        userNameLbl?.textColor = colorWithHex(hex: 0x333333)
        userNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(userNameLbl!)
        
        sendTimeLbl = UILabel.init(frame: CGRect.init(x: 76*PROSIZE, y: 45*PROSIZE, width: SCREEN_WIDE-96*PROSIZE, height: 12*PROSIZE))
        sendTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        sendTimeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(sendTimeLbl!)
        
        sayContentLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 74*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 38*PROSIZE))
        sayContentLbl?.textColor = colorWithHex(hex: 0x333333)
        sayContentLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        sayContentLbl?.numberOfLines = 0
        self.addSubview(sayContentLbl!)
    }
    
    func setCowSayCell(dataModel:CowSayDataModel) {
        userImageView?.dwn_setImageView(urlStr: dataModel.avatar!, imageName: "")
        userNameLbl?.text = dataModel.nickname!
        sendTimeLbl?.text = intervalSinceNow(stamp: dataModel.create_time!)
        let contentSize = NSString.calStrSize(textStr: dataModel.content! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 15*PROSIZE)
        sayContentLbl?.frame.size.height = contentSize.height
        sayContentLbl?.text = dataModel.content!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
