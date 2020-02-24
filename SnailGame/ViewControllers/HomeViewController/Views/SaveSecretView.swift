//
//  SaveSecretView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SaveSecretView: UIView {
    
    var saveSecretBtn : UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        saveSecretBtn = UIButton.init(type: UIButton.ButtonType.custom)
        saveSecretBtn?.frame = CGRect.init(x: 0, y: 5*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE)
        saveSecretBtn?.setImage(UIImage.init(named: "ic_community_secret_save_nol"), for: UIControl.State.normal)
        self.addSubview(saveSecretBtn!)
        
        let saveTitleLbl = UILabel.init(frame: CGRect.init(x: 35*PROSIZE, y: 5*PROSIZE, width: self.frame.size.width-35*PROSIZE, height: 24*PROSIZE))
        saveTitleLbl.textColor = colorWithHex(hex: 0x999999)
        saveTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(saveTitleLbl)
        let titleAttrStr = NSMutableAttributedString.init(string: "保存助记词到本地")
        titleAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x333333), range:NSRange.init(location:0, length: 8))
        saveTitleLbl.attributedText = titleAttrStr
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
