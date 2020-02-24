//
//  EthCenterCell.swift
//  SnailGame
//
//  Created by Edison on 2019/11/21.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class EthCenterCell: UICollectionViewCell {
    
    var depositImageView : UIImageView?
    
    var walletAddressLbl , ethNumLbl , dateTimeLbl , stateNameLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        depositImageView = UIImageView.init(frame: CGRect.init(x: 22*PROSIZE, y: 17*PROSIZE, width: 32*PROSIZE, height: 32*PROSIZE))
        self.addSubview(depositImageView!)
        
        walletAddressLbl = UILabel.init(frame: CGRect.init(x: 68*PROSIZE, y: 14*PROSIZE, width: SCREEN_WIDE-226*PROSIZE, height: 15*PROSIZE))
        walletAddressLbl?.textColor = colorWithHex(hex: 0x333333)
        walletAddressLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        self.addSubview(walletAddressLbl!)
        
        ethNumLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-158*PROSIZE, y: 14*PROSIZE, width: 140*PROSIZE, height: 15*PROSIZE))
        ethNumLbl?.textAlignment = .right
        ethNumLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(ethNumLbl!)
        
        dateTimeLbl = UILabel.init(frame: CGRect.init(x: 68*PROSIZE, y: 39*PROSIZE, width: SCREEN_WIDE-226*PROSIZE, height: 12*PROSIZE))
        dateTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        dateTimeLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(dateTimeLbl!)
        
        stateNameLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-60*PROSIZE, y: 33*PROSIZE, width: 42*PROSIZE, height: 20*PROSIZE))
        stateNameLbl?.textAlignment = .center
        stateNameLbl?.font = UIFont.systemFont(ofSize: 11*PROSIZE)
        stateNameLbl?.layer.cornerRadius = 2
        stateNameLbl?.layer.masksToBounds = true
        self.addSubview(stateNameLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: 67*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setEthCenterCell(dataModel:EthRecordDataModel) {
        let eth = KeepSomeDecimal(num: calculateAChuyiB(a: dataModel.num!, b: ETH_RATIO), decimal: 8)
        if dataModel.type == 1 {
            depositImageView?.image = UIImage.init(named: "ic_eth_record_deposit")
            walletAddressLbl?.text = dataModel.wallet_from
            ethNumLbl?.textColor = colorWithHex(hex: 0xFF6600)
            ethNumLbl?.text = "+"+eth
        } else {
            depositImageView?.image = UIImage.init(named: "ic_eth_record_extract")
            walletAddressLbl?.text = dataModel.wallet_to
            ethNumLbl?.textColor = colorWithHex(hex: 0x333333)
            ethNumLbl?.text = eth
        }
        dateTimeLbl?.text = intervalSinceNow(stamp: dataModel.start_time!)
        
        var stateSize = CGSize.zero
        if dataModel.status == 1 {
            stateSize = NSString.calStrSize(textStr: "处理中", height: 20*PROSIZE, fontSize: 11*PROSIZE)
            stateNameLbl?.frame.origin.x = SCREEN_WIDE-26*PROSIZE-stateSize.width
            stateNameLbl?.frame.size.width = stateSize.width + 8*PROSIZE
            stateNameLbl?.text = "处理中"
            stateNameLbl?.textColor = colorWithHex(hex: 0xFF6600)
            stateNameLbl?.backgroundColor = colorWithHex(hex: 0xFCEFE6)
        } else if dataModel.status == 2 {
            stateNameLbl?.text = ""
            stateNameLbl?.textColor = UIColor.white
            stateNameLbl?.backgroundColor = UIColor.white
        } else {
            stateSize = NSString.calStrSize(textStr: "失败", height: 20*PROSIZE, fontSize: 11*PROSIZE)
            stateNameLbl?.frame.origin.x = SCREEN_WIDE-26*PROSIZE-stateSize.width
            stateNameLbl?.frame.size.width = stateSize.width + 8*PROSIZE
            stateNameLbl?.text = "失败"
            stateNameLbl?.textColor = colorWithHex(hex: 0xFF0F59)
            stateNameLbl?.backgroundColor = colorWithHex(hex: 0xFF0F59)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
