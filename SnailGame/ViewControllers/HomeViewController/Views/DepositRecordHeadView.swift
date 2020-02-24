//
//  DepositRecordHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositRecordHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let earnTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: self.frame.size.height))
        earnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        earnTitleLbl.text = "“提”：从社区账户提出到钱包; \n“存”：从钱包存入到社区账户。"
        earnTitleLbl.textColor = colorWithHex(hex: 0x333333)
        earnTitleLbl.numberOfLines = 0
        self.addSubview(earnTitleLbl)
        
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
