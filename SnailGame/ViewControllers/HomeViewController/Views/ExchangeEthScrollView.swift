//
//  ExchangeEthScrollView.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ExchangeEthScrollView: UIScrollView {
    
    var kindNameLbl , totalNumLbl : UILabel?
    
    var ethNumTxtF , dwnNumTxtF , payTxtF : UITextField?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 10*PROSIZE, width: SCREEN_WIDE, height: 524*PROSIZE))
        barView.backgroundColor = UIColor.white
        self.addSubview(barView)
        
        let kindTitleLbl = UILabel.init(frame: CGRect.init(x: 22*PROSIZE, y: 24*PROSIZE, width: self.frame.size.width-44*PROSIZE, height: 15*PROSIZE))
        kindTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        kindTitleLbl.textColor = colorWithHex(hex: 0x333333)
        kindTitleLbl.text = "提出币种"
        barView.addSubview(kindTitleLbl)
        
        kindNameLbl = UILabel.init(frame: CGRect.init(x: 23*PROSIZE, y: kindTitleLbl.frame.origin.y+kindTitleLbl.frame.size.height+3*PROSIZE, width: self.frame.size.width-46*PROSIZE, height: 37*PROSIZE))
        kindNameLbl?.text = "ETH"
        kindNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        kindNameLbl?.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(kindNameLbl!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: kindNameLbl!.frame.origin.y+kindNameLbl!.frame.size.height+4*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(fstLine)
        
        let ethNumLbl = UILabel.init(frame: CGRect.init(x: 22*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+21*PROSIZE, width: self.frame.size.width-44*PROSIZE, height: 15*PROSIZE))
        ethNumLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        ethNumLbl.textColor = colorWithHex(hex: 0x333333)
        ethNumLbl.text = "兑换数量 (ETH)"
        barView.addSubview(ethNumLbl)
        
        ethNumTxtF = UITextField.init(frame: CGRect.init(x: 23*PROSIZE, y: ethNumLbl.frame.origin.y+ethNumLbl.frame.size.height+3*PROSIZE, width: self.frame.size.width-46*PROSIZE, height: 37*PROSIZE))
        ethNumTxtF?.textColor = colorWithHex(hex: 0x333333)
        ethNumTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        ethNumTxtF?.placeholder = "请输兑换数量"
        ethNumTxtF?.keyboardType = .decimalPad
        barView.addSubview(ethNumTxtF!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: ethNumTxtF!.frame.origin.y+ethNumTxtF!.frame.size.height+4*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(secLine)
        
        totalNumLbl = UILabel.init(frame: CGRect.init(x: 23*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+4*PROSIZE, width: self.frame.size.width-46*PROSIZE, height: 12*PROSIZE))
        totalNumLbl?.font = UIFont.systemFont(ofSize: 11*PROSIZE)
        totalNumLbl?.textColor = colorWithHex(hex: 0x666666)
        barView.addSubview(totalNumLbl!)
        
        let againstTitleLbl = UILabel.init(frame: CGRect.init(x: 22*PROSIZE, y: totalNumLbl!.frame.origin.y+totalNumLbl!.frame.size.height+20*PROSIZE, width: self.frame.size.width-44*PROSIZE, height: 15*PROSIZE))
        againstTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        againstTitleLbl.textColor = colorWithHex(hex: 0x333333)
        againstTitleLbl.text = "兑入币种"
        barView.addSubview(againstTitleLbl)
        
        let againstKindLbl = UILabel.init(frame: CGRect.init(x: 23*PROSIZE, y: againstTitleLbl.frame.origin.y+againstTitleLbl.frame.size.height+3*PROSIZE, width: self.frame.size.width-46*PROSIZE, height: 37*PROSIZE))
        againstKindLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        againstKindLbl.textColor = colorWithHex(hex: 0x333333)
        againstKindLbl.text = "DWN"
        barView.addSubview(againstKindLbl)
        
        let thidLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: againstKindLbl.frame.origin.y+againstKindLbl.frame.size.height+4*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 1*PROSIZE))
        thidLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(thidLine)
        
        let againstNumLbl = UILabel.init(frame: CGRect.init(x: 22*PROSIZE, y: thidLine.frame.origin.y+thidLine.frame.size.height+20*PROSIZE, width: self.frame.size.width-44*PROSIZE, height: 15*PROSIZE))
        againstNumLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        againstNumLbl.textColor = colorWithHex(hex: 0x333333)
        againstNumLbl.text = "兑入数量 (DWN)"
        barView.addSubview(againstNumLbl)
        
        dwnNumTxtF = UITextField.init(frame: CGRect.init(x: 23*PROSIZE, y: againstNumLbl.frame.origin.y+againstNumLbl.frame.size.height+3*PROSIZE, width: self.frame.size.width-46*PROSIZE, height: 37*PROSIZE))
        dwnNumTxtF?.textColor = colorWithHex(hex: 0x333333)
        dwnNumTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        dwnNumTxtF?.placeholder = "请输入兑入数量"
        dwnNumTxtF?.keyboardType = .decimalPad
        barView.addSubview(dwnNumTxtF!)
        
        let forthLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: dwnNumTxtF!.frame.origin.y+dwnNumTxtF!.frame.size.height+4*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 1*PROSIZE))
        forthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(forthLine)
        
        let payTitleLbl = UILabel.init(frame: CGRect.init(x: 22*PROSIZE, y: forthLine.frame.origin.y+forthLine.frame.size.height+20*PROSIZE, width: self.frame.size.width-44*PROSIZE, height: 15*PROSIZE))
        payTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        payTitleLbl.textColor = colorWithHex(hex: 0x333333)
        payTitleLbl.text = "支付密码"
        barView.addSubview(payTitleLbl)
        
        payTxtF = UITextField.init(frame: CGRect.init(x: 23*PROSIZE, y: payTitleLbl.frame.origin.y+payTitleLbl.frame.size.height+3*PROSIZE, width: self.frame.size.width-46*PROSIZE, height: 37*PROSIZE))
        payTxtF?.textColor = colorWithHex(hex: 0x333333)
        payTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        payTxtF?.placeholder = "请输入支付密码"
        payTxtF?.isSecureTextEntry = true
        payTxtF?.keyboardType = .decimalPad
        barView.addSubview(payTxtF!)
        
        let fifthLine = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: payTxtF!.frame.origin.y+payTxtF!.frame.size.height+4*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 1*PROSIZE))
        fifthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView.addSubview(fifthLine)
        
        submitBtn = UIButton.init(type: .roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: fifthLine.frame.origin.y+30*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 45*PROSIZE)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.setTitleColor(UIColor.white, for: .normal)
        submitBtn?.setTitle("提交", for: .normal)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.layer.cornerRadius = 5
        submitBtn?.layer.masksToBounds = true
        barView.addSubview(submitBtn!)
        
        let descLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: barView.frame.origin.y+barView.frame.size.height+10*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 60*PROSIZE))
        descLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        descLbl.textColor = colorWithHex(hex: 0x333333)
        descLbl.text = "兑入DWN数量根据ZG交易所实时价格计算，最终交易按实际价格计算"
        descLbl.numberOfLines = 0
        self.addSubview(descLbl)
        
        self.contentSize = CGSize.init(width: SCREEN_WIDE, height: descLbl.frame.origin.y+descLbl.frame.size.height+10*PROSIZE)
        
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
