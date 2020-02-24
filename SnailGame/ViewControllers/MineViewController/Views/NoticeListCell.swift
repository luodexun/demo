//
//  NoticeListCell.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class NoticeListCell: UICollectionViewCell {
    
    var titleNameLbl , sendTimeLbl : UILabel?
    
    var budgeView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 11*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 14*PROSIZE))
        titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(titleNameLbl!)
        
        sendTimeLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 33*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 11*PROSIZE))
        sendTimeLbl?.textColor = colorWithHex(hex: 0x999999)
        sendTimeLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(sendTimeLbl!)
        
        budgeView = UIView.init(frame: CGRect.init(x: self.frame.size.width-28*PROSIZE, y: 17*PROSIZE, width: 8*PROSIZE, height: 8*PROSIZE))
        budgeView?.backgroundColor = colorWithHex(hex: 0xFF0000)
        budgeView?.layer.cornerRadius = 4*PROSIZE
        budgeView?.layer.masksToBounds = true
        budgeView?.isHidden = true
        self.addSubview(budgeView!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 54*PROSIZE, width: self.frame.size.width-20*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setNoticeListCell(dataModel:NoticeListModel) {
        titleNameLbl?.text = dataModel.title
        sendTimeLbl?.text = intervalSinceNow(stamp: String(dataModel.create_time!))
        if dataModel.view == 0 {
            budgeView?.isHidden = false
        } else {
            budgeView?.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
