//
//  PauseSecondView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PauseSecondView: UIView  {
    
    var secretCV : UICollectionView?
    
    var writeBtn , coppyBtn : UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let secrectTitleLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: 21*PROSIZE, width: self.frame.size.width-60*PROSIZE, height: 15*PROSIZE))
        secrectTitleLbl.textColor = colorWithHex(hex: 0x999999)
        secrectTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(secrectTitleLbl)
        
        let secrectAttrStr = NSMutableAttributedString.init(string: "密钥（由12个助记词组成）")
        secrectAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x333333), range:NSRange.init(location:0, length: 2))
        secrectTitleLbl.attributedText = secrectAttrStr
        
        let secretPromptLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: secrectTitleLbl.frame.origin.y+secrectTitleLbl.frame.size.height+10*PROSIZE, width: self.frame.size.width-60*PROSIZE, height: 55*PROSIZE))
        secretPromptLbl.textColor = colorWithHex(hex: 0x333333)
        secretPromptLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        secretPromptLbl.numberOfLines = 0
        self.addSubview(secretPromptLbl)
        let secretPromptStr = NSMutableAttributedString.init(string: "请务必按顺序抄写以下12个助记词，下一步会确 认验证。")
        secretPromptStr.addAttribute(NSAttributedString.Key.font, value:UIFont.boldSystemFont(ofSize: 15*PROSIZE), range:NSRange.init(location: 3, length: 5))
        secretPromptLbl.attributedText = secretPromptStr
        
        let flowLayout = UICollectionViewLeftAlignedLayout.init()
        secretCV = UICollectionView.init(frame: CGRect.init(x: 0, y: secretPromptLbl.frame.origin.y+secretPromptLbl.frame.size.height, width: self.frame.size.width, height: 150*PROSIZE), collectionViewLayout: flowLayout)
        secretCV?.backgroundColor = UIColor.white
        self.addSubview(secretCV!)
        
        writeBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        writeBtn?.frame = CGRect.init(x: 20*PROSIZE, y: self.frame.size.height-145*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        writeBtn?.setTitle("我已经把它抄写下了", for: UIControl.State.normal)
        writeBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        writeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        writeBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        writeBtn?.layer.cornerRadius = 5
        writeBtn?.layer.masksToBounds = true
        self.addSubview(writeBtn!)
        
        let coppyBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: self.frame.size.height-75*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 35*PROSIZE))
        coppyBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        coppyBarView.layer.cornerRadius = 5
        coppyBarView.layer.masksToBounds = true
        self.addSubview(coppyBarView)
        
        let coppyImageView = UIImageView.init(frame: CGRect.init(x: 15*PROSIZE, y: 8*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        coppyImageView.image = UIImage.init(named: "ic_pause_second_copy")
        coppyBarView.addSubview(coppyImageView)
        
        let coppyTitleLbl = UILabel.init(frame: CGRect.init(x: 42*PROSIZE, y: 11*PROSIZE, width: coppyBarView.frame.size.width-42*PROSIZE, height: 15*PROSIZE))
        coppyTitleLbl.textColor = colorWithHex(hex: 0x999999)
        coppyTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        coppyBarView.addSubview(coppyTitleLbl)
        
        let coppyAttrStr = NSMutableAttributedString.init(string: "复制助记词（如复制粘贴，注意安全保管）")
        coppyAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x333333), range:NSRange.init(location:0, length: 5))
        coppyTitleLbl.attributedText = coppyAttrStr
        
        coppyBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        coppyBtn?.frame = coppyBarView.bounds
        coppyBarView.addSubview(coppyBtn!)
        
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
