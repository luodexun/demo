//
//  MineDataView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineDataView: UIView {

    var portraitImageView : UIImageView?

    var nickNameLbl : UILabel?
    
    var portraitBtn , nickBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let portraitBarView = UIView.init(frame: CGRect.init(x: 0, y: 10*PROSIZE, width: self.frame.size.width, height: 54*PROSIZE))
        portraitBarView.backgroundColor = UIColor.white
        self.addSubview(portraitBarView)
        
        let portraitTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        portraitTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        portraitTitleLbl.text = "头像"
        portraitTitleLbl.textColor = colorWithHex(hex: 0x333333)
        portraitBarView.addSubview(portraitTitleLbl)
        
        let portraitNext = UIImageView.init(frame: CGRect.init(x: portraitBarView.frame.size.width-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        portraitNext.image = UIImage.init(named: "ic_mine_next")
        portraitBarView.addSubview(portraitNext)
        
        portraitImageView = UIImageView.init(frame: CGRect.init(x: portraitBarView.frame.size.width-78*PROSIZE, y: 12, width: 30*PROSIZE, height: 30*PROSIZE))
        portraitImageView?.image = UIImage.init(named: "ic_mine_userDefault")
        portraitBarView.addSubview(portraitImageView!)
        
        portraitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        portraitBtn?.frame = portraitBarView.bounds
        portraitBarView.addSubview(portraitBtn!)
        
        let nickBarView = UIView.init(frame: CGRect.init(x: 0, y: portraitBarView.frame.origin.y+portraitBarView.frame.size.height+10*PROSIZE, width: self.frame.size.width, height: 54*PROSIZE))
        nickBarView.backgroundColor = UIColor.white
        self.addSubview(nickBarView)
        
        let nickTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        nickTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nickTitleLbl.text = "昵称"
        nickTitleLbl.textColor = colorWithHex(hex: 0x333333)
        nickBarView.addSubview(nickTitleLbl)
        
        nickNameLbl = UILabel.init(frame: CGRect.init(x: 130*PROSIZE, y: 17*PROSIZE, width: nickBarView.frame.size.width-178*PROSIZE, height: 20*PROSIZE))
        nickNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nickNameLbl?.textColor = colorWithHex(hex: 0x333333)
        nickNameLbl?.textAlignment = NSTextAlignment.right
        nickBarView.addSubview(nickNameLbl!)
        
        let nickNext = UIImageView.init(frame: CGRect.init(x: nickBarView.frame.size.width-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        nickNext.image = UIImage.init(named: "ic_mine_next")
        nickBarView.addSubview(nickNext)
        
        nickBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        nickBtn?.frame = nickBarView.bounds
        nickBarView.addSubview(nickBtn!)
        
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
