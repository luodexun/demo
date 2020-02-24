//
//  PauseSuccessView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PauseSuccessView: UIView {

    var qrImageView : UIImageView?
    
    var addressNameLbl : UILabel?
    
    var addressCopyBtn , savePhotoBtn , complateBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let promptBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 100*PROSIZE))
        promptBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(promptBarView)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 29*PROSIZE, width: promptBarView.frame.size.width-40*PROSIZE, height: 16*PROSIZE))
        promptTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        promptTitleLbl.text = "恭喜您注册成功"
        promptTitleLbl.textColor = colorWithHex(hex: 0xFF0F59)
        promptTitleLbl.textAlignment = NSTextAlignment.center
        promptBarView.addSubview(promptTitleLbl)
        
        let promptDescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 56*PROSIZE, width: promptBarView.frame.size.width-40*PROSIZE, height: 13*PROSIZE))
        promptDescLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        promptDescLbl.text = "可以通过您的钱包地址收款了"
        promptDescLbl.textColor = colorWithHex(hex: 0x999999)
        promptDescLbl.textAlignment = NSTextAlignment.center
        promptBarView.addSubview(promptDescLbl)
        
        qrImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-180*PROSIZE)/2, y: promptBarView.frame.size.height+51*PROSIZE, width: 180*PROSIZE, height: 180*PROSIZE))
        self.addSubview(qrImageView!)
        
        
        let addressBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: qrImageView!.frame.origin.y+qrImageView!.frame.size.height+51*PROSIZE
            , width: self.frame.size.width-40*PROSIZE, height: 75*PROSIZE))
        addressBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(addressBarView)
        
        
        let addressTitleLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: 19*PROSIZE, width: addressBarView.frame.size.width-20*PROSIZE, height: 15*PROSIZE))
        addressTitleLbl.textColor = colorWithHex(hex: 0x0077FF)
        addressTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressTitleLbl.textAlignment = NSTextAlignment.center
        addressBarView.addSubview(addressTitleLbl)
        
        let addressAttrStr = NSMutableAttributedString.init(string: "钱包地址（可点击复制）")
        addressAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x999999), range:NSRange.init(location:0, length: 4))
        addressTitleLbl.attributedText = addressAttrStr
        
        addressNameLbl = UILabel.init(frame: CGRect.init(x: 5*PROSIZE, y: 44*PROSIZE, width: addressBarView.frame.size.width-10*PROSIZE, height: 15*PROSIZE))
        addressNameLbl?.textColor = colorWithHex(hex: 0x333333)
        addressNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressNameLbl?.textAlignment = NSTextAlignment.center
        addressBarView.addSubview(addressNameLbl!)
        
        addressCopyBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        addressCopyBtn?.frame = addressBarView.bounds
        addressBarView.addSubview(addressCopyBtn!)
        
        savePhotoBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        savePhotoBtn?.frame = CGRect.init(x: 20*PROSIZE, y: addressBarView.frame.origin.y+addressBarView.frame.size.height+21*PROSIZE, width: 155*PROSIZE, height: 35*PROSIZE)
        savePhotoBtn?.setTitle("保存为图片", for: UIControl.State.normal)
        savePhotoBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        savePhotoBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        savePhotoBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        savePhotoBtn?.layer.cornerRadius = 5
        savePhotoBtn?.layer.masksToBounds = true
        self.addSubview(savePhotoBtn!)
        
        complateBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        complateBtn?.frame = CGRect.init(x: self.frame.size.width-175*PROSIZE, y: addressBarView.frame.origin.y+addressBarView.frame.size.height+21*PROSIZE, width: 155*PROSIZE, height: 35*PROSIZE)
        complateBtn?.setTitle("完成", for: UIControl.State.normal)
        complateBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        complateBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(complateBtn!)
        
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
