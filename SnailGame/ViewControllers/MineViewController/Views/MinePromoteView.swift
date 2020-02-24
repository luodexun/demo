//
//  MinePromoteView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MinePromoteView: UIView {

    var promoteCodeLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = true
        
        promoteCodeLbl = UILabel.init(frame: CGRect.init(x: 0, y: 6*PROSIZE, width: 77*PROSIZE, height: 25*PROSIZE))
        promoteCodeLbl?.textAlignment = NSTextAlignment.right
        promoteCodeLbl?.textColor = colorWithHex(hex: 0x333333);
        promoteCodeLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(promoteCodeLbl!)
        
        let codeImageView = UIImageView.init(frame: CGRect.init(x: 86*PROSIZE, y: 6*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        codeImageView.image = UIImage.init(named: "ic_mine_code")
        self.addSubview(codeImageView)
        
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
