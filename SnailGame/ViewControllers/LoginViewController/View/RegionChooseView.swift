//
//  RegionChooseView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegionChooseView: UIView {

    var regionNameLbl : UILabel?
    
    var chooseRegionBtn ,nextBtn : UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let chooseTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: 20*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 14*PROSIZE))
        chooseTitleLbl.text = "选择国家或地区"
        chooseTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        chooseTitleLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(chooseTitleLbl)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: chooseTitleLbl.frame.origin.y+chooseTitleLbl.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE))
        self.addSubview(barView)
        
        regionNameLbl = UILabel.init(frame: CGRect.init(x: 7*PROSIZE, y: 15*PROSIZE, width: barView.frame.size.width-37*PROSIZE, height: 16*PROSIZE))
        regionNameLbl?.textColor = colorWithHex(hex: 0x333333)
        regionNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        regionNameLbl?.text = "中国大陆"
        barView.addSubview(regionNameLbl!)
        
        let downIcon = UIImageView.init(frame: CGRect.init(x: barView.frame.size.width-25*PROSIZE, y: 18*PROSIZE, width: 15*PROSIZE, height: 10*PROSIZE))
        downIcon.image = UIImage.init(named: "ic_login_down")
        barView.addSubview(downIcon)
        
        chooseRegionBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        chooseRegionBtn?.frame = barView.bounds
        barView.addSubview(chooseRegionBtn!)
        
        let regionLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: barView.frame.origin.y+barView.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        regionLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(regionLine)
        
        
        let warnIcon = UIImageView.init(frame: CGRect.init(x: 22*PROSIZE, y: regionLine.frame.origin.y+regionLine.frame.size.height+28*PROSIZE, width: 23*PROSIZE, height: 23*PROSIZE))
        warnIcon.image = UIImage.init(named: "ic_region_warn")
        self.addSubview(warnIcon)
        
        let warnTitleLbl = UILabel.init(frame: CGRect.init(x: 60*PROSIZE, y: regionLine.frame.origin.y+regionLine.frame.size.height+30*PROSIZE, width: self.frame.size.width-87*PROSIZE, height: 41*PROSIZE))
        warnTitleLbl.text = "请选择您真实的国家或地区，否则后续无法通过实名认证。"
        warnTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        warnTitleLbl.textColor = colorWithHex(hex: 0x999999)
        warnTitleLbl.numberOfLines = 0
        self.addSubview(warnTitleLbl)
        
        
        nextBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        nextBtn?.frame = CGRect.init(x: 20*PROSIZE, y: warnTitleLbl.frame.origin.y+warnTitleLbl.frame.size.height+95*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        nextBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        nextBtn?.setTitle("下一步", for: UIControl.State.normal)
        nextBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        nextBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nextBtn?.layer.cornerRadius = 5
        nextBtn?.layer.masksToBounds = true
        self.addSubview(nextBtn!)
        
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
