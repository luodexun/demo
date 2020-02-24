//
//  EthRecordDetailView.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class EthRecordDetailView: UIView {
    
    var stateNameLbl , kindNameLbl , dwnAddressTitleLbl , dwnAddressLbl , addressTitleLbl , otherAddressLbl , ethNumLbl , createTimeLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let stateTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: 27*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        stateTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        stateTitleLbl.textColor = colorWithHex(hex: 0x999999)
        stateTitleLbl.text = "状态"
        self.addSubview(stateTitleLbl)
        
        stateNameLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: stateTitleLbl.frame.origin.y+stateTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 17*PROSIZE))
        stateNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        stateNameLbl?.textColor = colorWithHex(hex: 0xFF0F59)
        self.addSubview(stateNameLbl!)
        
        let typeTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: (stateNameLbl?.frame.origin.y)!+(stateNameLbl?.frame.size.height)!+20*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        typeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        typeTitleLbl.textColor = colorWithHex(hex: 0x999999)
        typeTitleLbl.text = "类型"
        self.addSubview(typeTitleLbl)
        
        kindNameLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: typeTitleLbl.frame.origin.y+typeTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 17*PROSIZE))
        kindNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        kindNameLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(kindNameLbl!)
        
        dwnAddressTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: (kindNameLbl?.frame.origin.y)!+(kindNameLbl?.frame.size.height)!+20*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        dwnAddressTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        dwnAddressTitleLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(dwnAddressTitleLbl!)
        
        dwnAddressLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: (dwnAddressTitleLbl?.frame.origin.y)!+(dwnAddressTitleLbl?.frame.size.height)!+5*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 17*PROSIZE))
        dwnAddressLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        dwnAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(dwnAddressLbl!)
        
        addressTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: (dwnAddressLbl?.frame.origin.y)!+(dwnAddressLbl?.frame.size.height)!+20*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        addressTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        addressTitleLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(addressTitleLbl!)
        
        otherAddressLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: (addressTitleLbl?.frame.origin.y)!+(addressTitleLbl?.frame.size.height)!+5*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 17*PROSIZE))
        otherAddressLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        otherAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(otherAddressLbl!)
        
        let numTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: (otherAddressLbl?.frame.origin.y)!+(otherAddressLbl?.frame.size.height)!+20*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        numTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        numTitleLbl.textColor = colorWithHex(hex: 0x999999)
        numTitleLbl.text = "数量/费用"
        self.addSubview(numTitleLbl)
        
        ethNumLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: numTitleLbl.frame.origin.y+numTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 17*PROSIZE))
        ethNumLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        ethNumLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(ethNumLbl!)
        
        let timeTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: (ethNumLbl?.frame.origin.y)!+(ethNumLbl?.frame.size.height)!+20*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        timeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        timeTitleLbl.textColor = colorWithHex(hex: 0x999999)
        timeTitleLbl.text = "时间"
        self.addSubview(timeTitleLbl)
        
        createTimeLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: timeTitleLbl.frame.origin.y+timeTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-36*PROSIZE, height: 17*PROSIZE))
        createTimeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        createTimeLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(createTimeLbl!)
        
        let noteTitleLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: (createTimeLbl?.frame.origin.y)!+(createTimeLbl?.frame.size.height)!+20*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        noteTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteTitleLbl.textColor = colorWithHex(hex: 0x999999)
        noteTitleLbl.text = "备注"
        self.addSubview(noteTitleLbl)
        
        let noteNameLbl = UILabel.init(frame: CGRect.init(x: 19*PROSIZE, y: noteTitleLbl.frame.origin.y+noteTitleLbl.frame.size.height+5*PROSIZE, width: self.frame.size.width-38*PROSIZE, height: 15*PROSIZE))
        noteNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteNameLbl.textColor = colorWithHex(hex: 0x333333)
        noteNameLbl.text = "--"
        self.addSubview(noteNameLbl)
        
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
