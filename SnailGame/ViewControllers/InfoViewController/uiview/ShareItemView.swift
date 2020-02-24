//
//  ShareItemView.swift
//  SnailGame
//
//  Created by Edison on 2020/1/8.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class ShareItemView: UIView {
    
    var iconView : UIImageView?
    var itemTitleLbl : UILabel?
    var itemBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 50*PROSIZE))
        self.addSubview(iconView!)
        
        itemTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 54*PROSIZE, width: self.frame.size.width, height: 12*PROSIZE))
        itemTitleLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        itemTitleLbl?.textAlignment = .center
        itemTitleLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(itemTitleLbl!)
        
        itemBtn = UIButton.init(type: .roundedRect)
        itemBtn?.frame = self.bounds
        self.addSubview(itemBtn!)
    }
    
    required init?(coder: NSCoder) {
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
