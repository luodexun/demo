//
//  SavePhotoView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SavePhotoView: UIView {

    var qrImageView : UIImageView?
    
    var addressNameLbl , dwnNumLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        barImageView.image = UIImage.init(named: "ic_tailor_photo_bg")
        self.addSubview(barImageView)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 27*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: self.frame.size.height-52*PROSIZE))
        barView.backgroundColor = UIColor.white
        barView.layer.cornerRadius = 5
        barView.layer.masksToBounds = true
        self.addSubview(barView)
        
        let headBG = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: barView.frame.size.width, height: 77*PROSIZE))
        headBG.image = UIImage.init(named: "ic_tailor_photo_head")
        barView.addSubview(headBG)
        
        let bottomBG = UIImageView.init(frame: CGRect.init(x: 0, y: barView.frame.size.height-142*PROSIZE, width: barView.frame.size.width, height: 142*PROSIZE))
        bottomBG.image = UIImage.init(named: "ic_tailor_photo_bottom")
        barView.addSubview(bottomBG)
        
        let pauseTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 45*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 17*PROSIZE))
        pauseTitleLbl.text = "我的收款码"
        pauseTitleLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        pauseTitleLbl.textColor = colorWithHex(hex: 0x333333)
        pauseTitleLbl.textAlignment = NSTextAlignment.center
        barView.addSubview(pauseTitleLbl)
        
        qrImageView = UIImageView.init(frame: CGRect.init(x: (barView.frame.size.width-180*PROSIZE)/2, y: headBG.frame.size.height+34*PROSIZE, width: 180*PROSIZE, height: 180*PROSIZE))
        barView.addSubview(qrImageView!)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: qrImageView!.frame.origin.y+qrImageView!.frame.size.height+11*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 23*PROSIZE))
        dwnNumLbl?.font = UIFont.systemFont(ofSize: 30*PROSIZE)
        dwnNumLbl?.textColor = colorWithHex(hex: 0x999999)
        dwnNumLbl?.textAlignment = NSTextAlignment.center
        barView.addSubview(dwnNumLbl!)
        
        let addressTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: qrImageView!.frame.origin.y+qrImageView!.frame.size.height+82*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 14*PROSIZE))
        addressTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressTitleLbl.text = "钱包地址"
        addressTitleLbl.textColor = colorWithHex(hex: 0x999999)
        barView.addSubview(addressTitleLbl)
        
        let addressBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: addressTitleLbl.frame.origin.y+addressTitleLbl.frame.size.height+11*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 50*PROSIZE))
        addressBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        barView.addSubview(addressBarView)
        
        addressNameLbl = UILabel.init(frame: CGRect.init(x: 8*PROSIZE, y: 5*PROSIZE, width: addressBarView.frame.size.width-16*PROSIZE, height: 40*PROSIZE))
        addressNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressNameLbl?.textColor = colorWithHex(hex: 0x333333)
        addressNameLbl?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        addressNameLbl?.numberOfLines = 0
        addressBarView.addSubview(addressNameLbl!)
        
        let appNameSize = NSString.calStrSize(textStr: "大蜗牛社区", height: 20*PROSIZE, fontSize: 20*PROSIZE)
        
        let logo = UIImageView.init(frame: CGRect.init(x: (barView.frame.size.width-31*PROSIZE-appNameSize.width)/2, y: barView.frame.size.height-113*PROSIZE, width: 25*PROSIZE, height: 20*PROSIZE))
        logo.image = UIImage.init(named: "ic_tailor_photo_logo")
        barView.addSubview(logo)
        
        let appNameLbl = UILabel.init(frame: CGRect.init(x: (barView.frame.size.width-31*PROSIZE-appNameSize.width)/2 + 31*PROSIZE, y: barView.frame.size.height-113*PROSIZE, width: appNameSize.width, height: 20*PROSIZE))
        appNameLbl.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        appNameLbl.text = "大蜗牛社区"
        appNameLbl.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(appNameLbl)
        
        let appTitleLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: barView.frame.size.height-82*PROSIZE, width:  barView.frame.size.width-20*PROSIZE, height: 14*PROSIZE))
        appTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        appTitleLbl.text = "基于区块链的数字资产社区"
        appTitleLbl.textColor = colorWithHex(hex: 0x333333)
        appTitleLbl.textAlignment = NSTextAlignment.center
        barView.addSubview(appTitleLbl)
        
        let appDescLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: barView.frame.size.height-62*PROSIZE, width:  barView.frame.size.width-20*PROSIZE, height: 12*PROSIZE))
        appDescLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        appDescLbl.text = "安全、平等、价值"
        appDescLbl.textColor = colorWithHex(hex: 0x999999)
        appDescLbl.textAlignment = NSTextAlignment.center
        barView.addSubview(appDescLbl)
        
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
