//
//  ClearSecretView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ClearSecretView: UIView {
    
    var useSecretBtn , clearSecretBtn : UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let useBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 175*PROSIZE, height: self.frame.size.height))
        useBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        useBarView.layer.cornerRadius = 5
        useBarView.layer.masksToBounds = true
        self.addSubview(useBarView)
        
        let useImageView = UIImageView.init(frame: CGRect.init(x: 15*PROSIZE, y: 8*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        useImageView.image = UIImage.init(named: "ic_community_secret_use")
        useBarView.addSubview(useImageView)
        
        let useTitleLbl = UILabel.init(frame: CGRect.init(x: 42*PROSIZE, y: 5*PROSIZE, width: self.frame.size.width-42*PROSIZE, height: 24*PROSIZE))
        useTitleLbl.textColor = colorWithHex(hex: 0x333333)
        useTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        useTitleLbl.text = "用已存在本地密钥"
        useBarView.addSubview(useTitleLbl)
        
        useSecretBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        useSecretBtn?.frame = useBarView.bounds
        useBarView.addSubview(useSecretBtn!)
        
        let clearBarView = UIView.init(frame: CGRect.init(x: useBarView.frame.origin.x+useBarView.frame.size.width+10*PROSIZE, y: 0, width: 130*PROSIZE, height: self.frame.size.height))
        clearBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        clearBarView.layer.cornerRadius = 5
        clearBarView.layer.masksToBounds = true
        self.addSubview(clearBarView)
        
        let clearImageView = UIImageView.init(frame: CGRect.init(x: 15*PROSIZE, y: 8*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        clearImageView.image = UIImage.init(named: "ic_community_secret_clear")
        clearBarView.addSubview(clearImageView)
        
        let clearTitleLbl = UILabel.init(frame: CGRect.init(x: 42*PROSIZE, y: 5*PROSIZE, width: self.frame.size.width-42*PROSIZE, height: 24*PROSIZE))
        clearTitleLbl.textColor = colorWithHex(hex: 0x333333)
        clearTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        clearTitleLbl.text = "从本地删除"
        clearBarView.addSubview(clearTitleLbl)
        
        clearSecretBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        clearSecretBtn?.frame = clearBarView.bounds
        clearBarView.addSubview(clearSecretBtn!)
        
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
