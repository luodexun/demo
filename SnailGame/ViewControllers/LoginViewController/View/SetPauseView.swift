//
//  SetPauseView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SetPauseView: UIView {

    var createBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let pauseIcon = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-213*PROSIZE)/2, y: 77*PROSIZE, width: 213*PROSIZE, height: 47*PROSIZE))
        pauseIcon.image = UIImage.init(named: "ic_set_puase_bg")
        self.addSubview(pauseIcon)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: pauseIcon.frame.size.height+pauseIcon.frame.origin.y+81*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 17*PROSIZE))
        titleNameLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        titleNameLbl.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl.textAlignment = NSTextAlignment.center
        titleNameLbl.text = "创建新钱包"
        self.addSubview(titleNameLbl)
        
        let descNameLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: titleNameLbl.frame.size.height+titleNameLbl.frame.origin.y+4*PROSIZE, width: self.frame.size.width-60*PROSIZE, height: 102*PROSIZE))
        descNameLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        descNameLbl.textColor = colorWithHex(hex: 0x333333)
        descNameLbl.numberOfLines = 0
        descNameLbl.text = "使用大蜗牛社区，需创建DWN钱包。\nDWN钱包，是基于DWN的使用与管理，去中心化的区块链数字钱包。"
        self.addSubview(descNameLbl)
        
        createBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        createBtn?.frame = CGRect.init(x: 20*PROSIZE, y: descNameLbl.frame.origin.y+descNameLbl.frame.size.height+39*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        createBtn?.setTitle("创建钱包", for: UIControl.State.normal)
        createBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        createBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        createBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        createBtn?.layer.cornerRadius = 5
        createBtn?.layer.masksToBounds = true
        self.addSubview(createBtn!)
        
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
