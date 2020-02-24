//
//  CandyExchangeView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/4.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CandyExchangeView: UIScrollView {
    
    var remainNumLbl , totalNumLbl , amountNumLbl , dwnNumLbl : UILabel?
    
    var totalBarView : UIView?
    
    var exchangeNumTxtF : UITextField?

    var numSlider : UISlider?
    
    var submitBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 582*PROSIZE))
        barView.backgroundColor = UIColor.white
        self.addSubview(barView)
        
        let bg = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 158*PROSIZE))
        bg.image = UIImage.init(named: "ic_candy_exchange_bg")
        barView.addSubview(bg)
        
        let remainTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 38*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 14*PROSIZE))
        remainTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        remainTitleLbl.text = "糖果剩余可兑"
        remainTitleLbl.textColor = UIColor.white
        remainTitleLbl.textAlignment = .center
        barView.addSubview(remainTitleLbl)
        
        remainNumLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: 62*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 35*PROSIZE))
        remainNumLbl?.textColor = UIColor.white
        remainNumLbl?.font = UIFont.systemFont(ofSize: 35*PROSIZE)
        remainNumLbl?.textAlignment = .center
        barView.addSubview(remainNumLbl!)
        
        totalBarView = UIView.init(frame: CGRect.init(x: (SCREEN_WIDE-170*PROSIZE)/2, y: 110*PROSIZE, width: 170*PROSIZE, height: 33*PROSIZE))
        totalBarView?.backgroundColor = UIColor.white
        totalBarView?.alpha = 0.3
        totalBarView?.layer.cornerRadius = 33*PROSIZE/2
        totalBarView?.layer.masksToBounds = true
        barView.addSubview(totalBarView!)
        
        totalNumLbl = UILabel.init(frame: CGRect.init(x: (SCREEN_WIDE-170*PROSIZE)/2, y: 110*PROSIZE, width: 170*PROSIZE, height: 33*PROSIZE))
        totalNumLbl?.textColor = UIColor.white
        totalNumLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        totalNumLbl?.textAlignment = .center
        barView.addSubview(totalNumLbl!)
        
        let amountTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: bg.frame.origin.y+bg.frame.size.height+32*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 14*PROSIZE))
        amountTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        amountTitleLbl.text = "我的糖果总数"
        amountTitleLbl.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(amountTitleLbl)
        
        amountNumLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: amountTitleLbl.frame.origin.y+amountTitleLbl.frame.size.height+10*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 35*PROSIZE))
        amountNumLbl?.textColor = colorWithHex(hex: 0x333333)
        amountNumLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        barView.addSubview(amountNumLbl!)
        
        let numTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: amountNumLbl!.frame.origin.y+amountNumLbl!.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 15*PROSIZE))
        numTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        numTitleLbl.text = "兑换糖果数量"
        numTitleLbl.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(numTitleLbl)
        
        let numBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: numTitleLbl.frame.origin.y+numTitleLbl.frame.size.height+12*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 46*PROSIZE))
        numBarView.layer.borderWidth = 1
        numBarView.layer.borderColor = colorWithHex(hex: 0xCCCCCC).cgColor
        numBarView.layer.cornerRadius = 6
        numBarView.layer.masksToBounds = true
        barView.addSubview(numBarView)
        
        exchangeNumTxtF = UITextField.init(frame: CGRect.init(x: 8*PROSIZE, y: 0, width: numBarView.frame.size.width-16*PROSIZE, height: numBarView.frame.size.height))
        exchangeNumTxtF?.textColor = colorWithHex(hex: 0x333333)
        exchangeNumTxtF?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        exchangeNumTxtF?.placeholder = "请输入兑换数量"
        exchangeNumTxtF?.keyboardType = .decimalPad
        numBarView.addSubview(exchangeNumTxtF!)
        
        numSlider = UISlider.init(frame: CGRect.init(x: 20*PROSIZE, y: numBarView.frame.origin.y+numBarView.frame.size.height+14*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 32*PROSIZE))
        numSlider?.maximumTrackTintColor = colorWithHex(hex: 0xf4f4f4)
        numSlider?.minimumTrackTintColor = colorWithHex(hex: 0xFF6000)
        barView.addSubview(numSlider!)
        
        let dwnTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: numSlider!.frame.origin.y+numSlider!.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 15*PROSIZE))
        dwnTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnTitleLbl.text = "兑入DWN"
        dwnTitleLbl.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(dwnTitleLbl)
        
        dwnNumLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: dwnTitleLbl.frame.origin.y+dwnTitleLbl.frame.size.height+10*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 24*PROSIZE))
        dwnNumLbl?.textColor = colorWithHex(hex: 0x333333)
        dwnNumLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        barView.addSubview(dwnNumLbl!)
        
        submitBtn = UIButton.init(type: .roundedRect)
        submitBtn?.frame = CGRect.init(x: 20*PROSIZE, y: dwnNumLbl!.frame.origin.y+dwnNumLbl!.frame.size.height+40*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 46*PROSIZE)
        submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        submitBtn?.isUserInteractionEnabled = false
        submitBtn?.setTitle("提交", for: .normal)
        submitBtn?.setTitleColor(UIColor.white, for: .normal)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.layer.cornerRadius = 4
        submitBtn?.layer.masksToBounds = true
        barView.addSubview(submitBtn!)
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        let ruleSize = NSString.calStrSize(textStr: configModel!.candy_exchange_rule! as NSString, width: SCREEN_WIDE-36*PROSIZE, fontSize: 14*PROSIZE)
        let ruleTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: barView.frame.origin.y+barView.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: ruleSize.height))
        ruleTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        ruleTitleLbl.text = configModel!.candy_exchange_rule!
        ruleTitleLbl.textColor = colorWithHex(hex: 0x333333)
        ruleTitleLbl.numberOfLines = 0
        self.addSubview(ruleTitleLbl)
        
        self.contentSize = CGSize.init(width: SCREEN_WIDE, height: ruleTitleLbl.frame.origin.y+ruleTitleLbl.frame.size.height+26*PROSIZE)
        
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
