//
//  RollOutView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RollOutView: UIView {

    var addressTxtView : SnailTextView?
    
    var scanPushBtn , nextStepBtn : UIButton?
    
    var totalDwnLbl : UILabel?
    
    var amountTxtF : UITextField?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 45*PROSIZE))
        barView.backgroundColor = colorWithHex(hex: 0xF4F4F4)
        self.addSubview(barView)
    
        let warnTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: barView.frame.size.height))
        warnTitleLbl.textColor = colorWithHex(hex: 0x333333)
        warnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        warnTitleLbl.text = "输入对方“钱包地址”或扫描“二维码”"
        barView.addSubview(warnTitleLbl)
        
        let addressTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: barView.frame.size.height+20*PROSIZE, width: self.frame.size.width-52*PROSIZE, height: 14*PROSIZE))
        addressTitleLbl.textColor = colorWithHex(hex: 0x333333)
        addressTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressTitleLbl.text = "转入钱包地址"
        self.addSubview(addressTitleLbl)
        
        addressTxtView = SnailTextView.init(placeholder: "请输入对方钱包地址", placeholderColor: colorWithHex(hex: 0x999999), frame: CGRect.init(x: 18*PROSIZE, y: addressTitleLbl.frame.origin.y+addressTitleLbl.frame.size.height, width: self.frame.size.width-120*PROSIZE, height: 85*PROSIZE))
        addressTxtView?.palceholdertextView.textColor = colorWithHex(hex: 0x333333)
        addressTxtView?.isShowCountLabel = false
        self.addSubview(addressTxtView!)
        
        let scanBarView = UIView.init(frame: CGRect.init(x: self.frame.size.width-85*PROSIZE, y: addressTitleLbl.frame.origin.y+addressTitleLbl.frame.size.height, width: 65*PROSIZE, height: 65*PROSIZE))
        scanBarView.backgroundColor = colorWithHex(hex: 0xF4F4F4)
        scanBarView.layer.cornerRadius = 5
        scanBarView.layer.masksToBounds = true
        self.addSubview(scanBarView)
        
        let scanImageView = UIImageView.init(frame: CGRect.init(x: (scanBarView.frame.size.width-30*PROSIZE)/2, y: 10*PROSIZE, width: 30*PROSIZE, height: 30*PROSIZE))
        scanImageView.image = UIImage.init(named: "ic_roll_out_scan")
        scanBarView.addSubview(scanImageView)
        
        let scanTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 45*PROSIZE, width: scanBarView.frame.size.width, height: 12*PROSIZE))
        scanTitleLbl.textColor = colorWithHex(hex: 0x333333)
        scanTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        scanTitleLbl.text = "扫一扫"
        scanTitleLbl.textAlignment = NSTextAlignment.center
        scanBarView.addSubview(scanTitleLbl)
        
        scanPushBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        scanPushBtn?.frame = scanBarView.bounds
        scanBarView.addSubview(scanPushBtn!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: scanBarView.frame.origin.y+scanBarView.frame.size.height, width: self.frame.size.width-120*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let titleSize = NSString.calStrSize(textStr: "转出数量（DWN）", height: 15*PROSIZE, fontSize: 15*PROSIZE)
        let totalTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: titleSize.width, height: 15*PROSIZE))
        totalTitleLbl.textColor = colorWithHex(hex: 0x333333)
        totalTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        totalTitleLbl.text = "转出数量（DWN）"
        self.addSubview(totalTitleLbl)
        
        totalDwnLbl = UILabel.init(frame: CGRect.init(x: totalTitleLbl.frame.origin.x+totalTitleLbl.frame.size.width, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: 230*PROSIZE, height: 15*PROSIZE))
        totalDwnLbl?.text = "（最多可转：0.00）"
        totalDwnLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        totalDwnLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(totalDwnLbl!)
        
        amountTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: totalTitleLbl.frame.origin.y+totalTitleLbl.frame.size.height, width: self.frame.size.width-52*PROSIZE, height: 45*PROSIZE))
        amountTxtF?.textColor = colorWithHex(hex: 0x333333)
        amountTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        amountTxtF?.placeholder = "请输入转出数量"
        amountTxtF?.keyboardType = UIKeyboardType.decimalPad
        self.addSubview(amountTxtF!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: amountTxtF!.frame.origin.y+amountTxtF!.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        nextStepBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        nextStepBtn?.frame = CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+26*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        nextStepBtn?.setTitle("下一步", for: UIControl.State.normal)
        nextStepBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        nextStepBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nextStepBtn?.backgroundColor = colorWithHex(hex: 0x333333)
        nextStepBtn?.layer.cornerRadius = 5
        nextStepBtn?.layer.masksToBounds = true
        self.addSubview(nextStepBtn!)
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
