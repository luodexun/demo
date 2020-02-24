//
//  RecordDetailView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/10.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RecordDetailView: UIView {
    
    var tradIcon : UIImageView?
    
    var tradNameLbl , tradDwnLbl , walletAddressLbl , createTimeLbl , noteContentLbl , tradIdLbl : UILabel?
    
    var coppyBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tradIcon = UIImageView.init(frame: CGRect.init(x: 157*PROSIZE, y: 38*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        self.addSubview(tradIcon!)
        
        tradNameLbl = UILabel.init(frame: CGRect.init(x: tradIcon!.frame.origin.x + tradIcon!.frame.size.width + 10*PROSIZE, y: 40*PROSIZE, width: 70*PROSIZE, height: 16*PROSIZE))
        tradNameLbl?.textColor = colorWithHex(hex: 0x333333)
        tradNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        self.addSubview(tradNameLbl!)
        
        tradDwnLbl = UILabel.init(frame: CGRect.init(x: 50*PROSIZE, y: tradIcon!.frame.origin.y + tradIcon!.frame.size.height + 19*PROSIZE, width: self.frame.size.width-100*PROSIZE, height: 22*PROSIZE))
        tradDwnLbl?.textColor = colorWithHex(hex: 0x999999)
        tradDwnLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        tradDwnLbl?.textAlignment = .center
        self.addSubview(tradDwnLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: tradDwnLbl!.frame.origin.y + tradDwnLbl!.frame.size.height + 42*PROSIZE, width: self.frame.size.width, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(line)
        
        let coppyTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: line.frame.origin.y + line.frame.size.height + 16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        coppyTitleLbl.textColor = colorWithHex(hex: 0x999999)
        coppyTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        coppyTitleLbl.text = "对方地址（点击复制）"
        self.addSubview(coppyTitleLbl)
        
        walletAddressLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: coppyTitleLbl.frame.origin.y + coppyTitleLbl.frame.size.height + 8*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        walletAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        walletAddressLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(walletAddressLbl!)
        
        coppyBtn = UIButton.init(type: .roundedRect)
        coppyBtn?.frame = CGRect.init(x: 20*PROSIZE, y: coppyTitleLbl.frame.origin.y + coppyTitleLbl.frame.size.height, width: self.frame.size.width-40*PROSIZE, height: 35*PROSIZE)
        self.addSubview(coppyBtn!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: walletAddressLbl!.frame.origin.y + walletAddressLbl!.frame.size.height + 12*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(secLine)
        
        let timeTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: secLine.frame.origin.y + secLine.frame.size.height + 16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        timeTitleLbl.textColor = colorWithHex(hex: 0x999999)
        timeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        timeTitleLbl.text = "时间"
        self.addSubview(timeTitleLbl)
        
        createTimeLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: timeTitleLbl.frame.origin.y + timeTitleLbl.frame.size.height + 8*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        createTimeLbl?.textColor = colorWithHex(hex: 0x333333)
        createTimeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(createTimeLbl!)
        
        let thidLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: createTimeLbl!.frame.origin.y + createTimeLbl!.frame.size.height + 12*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        thidLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(thidLine)
        
        let noteTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: thidLine.frame.origin.y + thidLine.frame.size.height + 16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        noteTitleLbl.textColor = colorWithHex(hex: 0x999999)
        noteTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteTitleLbl.text = "备注"
        self.addSubview(noteTitleLbl)
        
        noteContentLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: noteTitleLbl.frame.origin.y + noteTitleLbl.frame.size.height + 8*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        noteContentLbl?.textColor = colorWithHex(hex: 0x333333)
        noteContentLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(noteContentLbl!)
        
        let forthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: noteContentLbl!.frame.origin.y + noteContentLbl!.frame.size.height + 12*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        forthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(forthLine)
        
        let idTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: forthLine.frame.origin.y + forthLine.frame.size.height + 16*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        idTitleLbl.textColor = colorWithHex(hex: 0x999999)
        idTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        idTitleLbl.text = "交易ID"
        self.addSubview(idTitleLbl)
        
        tradIdLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: idTitleLbl.frame.origin.y + idTitleLbl.frame.size.height + 8*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        tradIdLbl?.textColor = colorWithHex(hex: 0x333333)
        tradIdLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(tradIdLbl!)
        
        let fifthLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: tradIdLbl!.frame.origin.y + tradIdLbl!.frame.size.height + 12*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        fifthLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(fifthLine)
        
        
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
