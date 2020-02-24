//
//  SetView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SetView: UIView {
    
    var clearBtn , aboutBtn , updateBtn , logoutBtn : UIButton?
    
    var versionNoteLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let clearBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 54*PROSIZE))
        clearBarView.backgroundColor = UIColor.white
        self.addSubview(clearBarView)
        
        let clearTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        clearTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        clearTitleLbl.text = "清理缓存"
        clearTitleLbl.textColor = colorWithHex(hex: 0x333333)
        clearBarView.addSubview(clearTitleLbl)
        
        let clearNext = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        clearNext.image = UIImage.init(named: "ic_mine_next")
        clearBarView.addSubview(clearNext)
        
        clearBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        clearBtn?.frame = clearBarView.bounds
        clearBarView.addSubview(clearBtn!)
        
        let updateBarView = UIView.init(frame: CGRect.init(x: 0, y: clearBarView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE, height: 54*PROSIZE))
        updateBarView.backgroundColor = UIColor.white
        self.addSubview(updateBarView)
        
        let updateTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        updateTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        updateTitleLbl.text = "版本更新"
        updateTitleLbl.textColor = colorWithHex(hex: 0x333333)
        updateBarView.addSubview(updateTitleLbl)
        
        versionNoteLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-148*PROSIZE, y: 17*PROSIZE, width: 100*PROSIZE, height: 20*PROSIZE))
        versionNoteLbl?.text = "有新版本"
        versionNoteLbl?.isHidden = true
        versionNoteLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        versionNoteLbl?.textColor = colorWithHex(hex: 0xFE3232)
        versionNoteLbl?.textAlignment = NSTextAlignment.right
        updateBarView.addSubview(versionNoteLbl!)
        
        let updateNext = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        updateNext.image = UIImage.init(named: "ic_mine_next")
        updateBarView.addSubview(updateNext)
        
        updateBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        updateBtn?.frame = updateBarView.bounds
        updateBarView.addSubview(updateBtn!)
        
        let aboutBarView = UIView.init(frame: CGRect.init(x: 0, y: updateBarView.frame.origin.y+updateBarView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE, height: 54*PROSIZE))
        aboutBarView.backgroundColor = UIColor.white
        self.addSubview(aboutBarView)
        
        let aboutTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        aboutTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        aboutTitleLbl.text = "关于"
        aboutTitleLbl.textColor = colorWithHex(hex: 0x333333)
        aboutBarView.addSubview(aboutTitleLbl)
        
        let aboutNext = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        aboutNext.image = UIImage.init(named: "ic_mine_next")
        aboutBarView.addSubview(aboutNext)
        
        aboutBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        aboutBtn?.frame = aboutBarView.bounds
        aboutBarView.addSubview(aboutBtn!)
        
        logoutBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        logoutBtn?.frame = CGRect.init(x: 0, y: aboutBarView.frame.origin.y+aboutBarView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE, height: 54*PROSIZE)
        logoutBtn?.backgroundColor = UIColor.white
        logoutBtn?.setTitle("退出登录", for: UIControl.State.normal)
        logoutBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        logoutBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        self.addSubview(logoutBtn!)
        
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
