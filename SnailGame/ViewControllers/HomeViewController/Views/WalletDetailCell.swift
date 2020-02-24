//
//  WalletDetailCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WalletDetailCell: UICollectionViewCell {
    
    var iconImageView , confirmImageView : UIImageView?
    
    var walletAddressLbl , sendTimeLbl , tradDwnLbl : UILabel?

    var walletAddress : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        walletAddress = BusinessEngine.init().getLoginUserModel().wallet_address
        
        iconImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        self.addSubview(iconImageView!)
        
        walletAddressLbl = UILabel.init(frame: CGRect.init(x: 50*PROSIZE, y: 14*PROSIZE, width: self.frame.size.width-200*PROSIZE, height: 14*PROSIZE))
        walletAddressLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        walletAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(walletAddressLbl!)
        
        sendTimeLbl = UILabel.init(frame: CGRect.init(x: 50*PROSIZE, y: 32*PROSIZE, width: 80*PROSIZE, height: 11*PROSIZE))
        sendTimeLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        sendTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(sendTimeLbl!)
        
        confirmImageView = UIImageView.init(frame: CGRect.init(x: sendTimeLbl!.frame.origin.x+sendTimeLbl!.frame.size.width+8*PROSIZE, y: 31*PROSIZE, width: 52*PROSIZE, height: 12*PROSIZE))
        confirmImageView?.image = UIImage.init(named: "ic_change_record_confirm")
        self.addSubview(confirmImageView!)
        
        tradDwnLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-150*PROSIZE, y: 17*PROSIZE, width: 130*PROSIZE, height: 20*PROSIZE))
        tradDwnLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        tradDwnLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(tradDwnLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 50*PROSIZE, y: 54*PROSIZE, width: self.frame.size.width-70*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setWalletDetailCell(dataModel:TradeRecordDataModel) {
        var addressStr = ""
        if dataModel.sender == walletAddress {
            iconImageView?.image = UIImage.init(named: "ic_wallet_detail_out")
            addressStr = dataModel.recipient!
            tradDwnLbl?.text = "-" + KeepSomeDecimal(num: calculateAChuyiB(a: String(dataModel.amount!+dataModel.fee!), b: TOKEN_RATIO), decimal: 2)
            tradDwnLbl?.textColor = colorWithHex(hex: 0x333333)
        } else {
            iconImageView?.image = UIImage.init(named: "ic_wallet_detail_in")
            addressStr = dataModel.sender!
            tradDwnLbl?.text = "+" + KeepSomeDecimal(num: calculateAChuyiB(a: String(dataModel.amount!), b: TOKEN_RATIO), decimal: 2)
            tradDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        }
        let range = Range.init(NSRange.init(location: 5, length: addressStr.count-10), in: addressStr)
        addressStr = addressStr.replacingCharacters(in: range!, with: "...")
        walletAddressLbl?.text = addressStr
        
        let timeStr = changeDateToTime(dateStr: dataModel.timestamp!.human!)
        let timeSize = NSString.calStrSize(textStr: timeStr as NSString, height: 11*PROSIZE, fontSize: 12*PROSIZE)
        sendTimeLbl?.frame.size.width = timeSize.width
        sendTimeLbl?.text = timeStr
        confirmImageView?.frame.origin.x = sendTimeLbl!.frame.origin.x+sendTimeLbl!.frame.size.width+8*PROSIZE
        if dataModel.confirmations! < 6 {
            confirmImageView?.isHidden = false
        } else {
            confirmImageView?.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
