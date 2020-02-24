//
//  ChangeRecordCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ChangeRecordCell: UICollectionViewCell {
    
    var changeNameLbl , sendTimeLbl , tradDwnLbl : UILabel?
    
    var confirmImageView : UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        changeNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 13*PROSIZE, width: self.frame.size.width-170*PROSIZE, height: 14*PROSIZE))
        changeNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        changeNameLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(changeNameLbl!)
        
        sendTimeLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 33*PROSIZE, width: self.frame.size.width-170*PROSIZE, height: 11*PROSIZE))
        sendTimeLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        sendTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(sendTimeLbl!)
        
        confirmImageView = UIImageView.init(frame: CGRect.init(x: sendTimeLbl!.frame.origin.x+sendTimeLbl!.frame.size.width+8*PROSIZE, y: 32*PROSIZE, width: 52*PROSIZE, height: 12*PROSIZE))
        confirmImageView?.isHidden = true
        confirmImageView?.image = UIImage.init(named: "ic_change_record_confirm")
        self.addSubview(confirmImageView!)
        
        tradDwnLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-150*PROSIZE, y: 17*PROSIZE, width: 130*PROSIZE, height: 20*PROSIZE))
        tradDwnLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        tradDwnLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(tradDwnLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 54*PROSIZE, width: self.frame.size.width-20*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
    }
    
    func setChangeRecordCell(dataModel:CandyRecordDataModel) {
        changeNameLbl?.text = dataModel.cate
        let timeStr = intervalSinceNow(stamp: dataModel.create_time!)
        sendTimeLbl?.text = timeStr
        if dataModel.count! > 0 {
            tradDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        } else {
            tradDwnLbl?.textColor = colorWithHex(hex: 0x333333)
        }
        tradDwnLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: String(dataModel.count!), b: TOKEN_RATIO), decimal: 2)
        
        if dataModel.status == 0 {
            confirmImageView?.isHidden = false
            let timeSize = NSString.calStrSize(textStr: timeStr as NSString, height: 11*PROSIZE, fontSize: 12*PROSIZE)
            sendTimeLbl?.frame.size.width = timeSize.width
            confirmImageView?.frame.origin.x = sendTimeLbl!.frame.origin.x+sendTimeLbl!.frame.size.width+8*PROSIZE
        } else {
            confirmImageView?.isHidden = true
            sendTimeLbl?.frame.size.width = self.frame.size.width-170*PROSIZE
        }
    }
    
    func setCandyRecordCell(dataModel:CandyRecordDataModel) {
        confirmImageView?.isHidden = true
        changeNameLbl?.text = dataModel.cate
        sendTimeLbl?.text = intervalSinceNow(stamp: dataModel.create_time!)
        if dataModel.count! > 0 {
            tradDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        } else {
            tradDwnLbl?.textColor = colorWithHex(hex: 0x333333)
        }
        tradDwnLbl?.text = String(dataModel.count!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
