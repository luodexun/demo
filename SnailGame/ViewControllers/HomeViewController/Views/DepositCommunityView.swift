//
//  DepositCommunityView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositCommunityView: UIView {
    
    var totalDwnLbl : UILabel?
    
    var amountTxtF : UITextField?
    
    var putAllBtn , nextStepBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let titleSize = NSString.calStrSize(textStr: "数量（DWN）", height: 15*PROSIZE, fontSize: 15*PROSIZE)
        let totalTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: 21*PROSIZE, width: titleSize.width, height: 15*PROSIZE))
        totalTitleLbl.textColor = colorWithHex(hex: 0x333333)
        totalTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        totalTitleLbl.text = "数量（DWN）"
        self.addSubview(totalTitleLbl)
        
        totalDwnLbl = UILabel.init(frame: CGRect.init(x: totalTitleLbl.frame.origin.x+totalTitleLbl.frame.size.width, y: 21*PROSIZE, width: 230*PROSIZE, height: 15*PROSIZE))
        totalDwnLbl?.text = "（钱包余额：16.12）"
        totalDwnLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        totalDwnLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(totalDwnLbl!)
      
        amountTxtF = UITextField.init(frame: CGRect.init(x: 20*PROSIZE, y: totalTitleLbl.frame.origin.y+totalTitleLbl.frame.size.height, width: self.frame.size.width-117*PROSIZE, height: 45*PROSIZE))
        amountTxtF?.textColor = colorWithHex(hex: 0x333333)
        amountTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        amountTxtF?.placeholder = "请输入"
        amountTxtF?.keyboardType = UIKeyboardType.decimalPad
        self.addSubview(amountTxtF!)
        
        putAllBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        putAllBtn?.frame = CGRect.init(x: self.frame.size.width-97*PROSIZE, y: totalTitleLbl.frame.origin.y+totalTitleLbl.frame.size.height, width: 77*PROSIZE, height: 45*PROSIZE)
        putAllBtn?.setTitle("全部存入", for: UIControl.State.normal)
        putAllBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        putAllBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(putAllBtn!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: amountTxtF!.frame.origin.y+amountTxtF!.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fstLine)
        
        let noteTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: 200*PROSIZE, height: 15*PROSIZE))
        noteTitleLbl.textColor = colorWithHex(hex: 0x333333)
        noteTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteTitleLbl.text = "备注"
        self.addSubview(noteTitleLbl)
        
        let noteContentLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: noteTitleLbl.frame.origin.y+noteTitleLbl.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE))
        noteContentLbl.textColor = colorWithHex(hex: 0x333333)
        noteContentLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        noteContentLbl.text = "存入到社区"
        self.addSubview(noteContentLbl)
      
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: noteContentLbl.frame.origin.y+noteContentLbl.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        nextStepBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        nextStepBtn?.frame = CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+26*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        nextStepBtn?.setTitle("下一步", for: UIControl.State.normal)
        nextStepBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        nextStepBtn?.isUserInteractionEnabled = false
        nextStepBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nextStepBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        nextStepBtn?.layer.cornerRadius = 5
        nextStepBtn?.layer.masksToBounds = true
        self.addSubview(nextStepBtn!)
        
        let warnIcon = UIImageView.init(frame: CGRect.init(x: 22*PROSIZE, y: nextStepBtn!.frame.size.height+nextStepBtn!.frame.origin.y+15*PROSIZE, width: 23*PROSIZE, height: 23*PROSIZE))
        warnIcon.image = UIImage.init(named: "ic_region_warn")
        self.addSubview(warnIcon)
        
        let warnContentLbl = UILabel.init(frame: CGRect.init(x: 50*PROSIZE, y: nextStepBtn!.frame.size.height+nextStepBtn!.frame.origin.y+15*PROSIZE, width: self.frame.size.width-70*PROSIZE, height: 46*PROSIZE))
        warnContentLbl.textColor = colorWithHex(hex: 0x999999)
        warnContentLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        warnContentLbl.text = "由于链上节点交易确认和可能的网络延时，实际到账需要3-5分钟。"
        warnContentLbl.numberOfLines = 0
        self.addSubview(warnContentLbl)
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
