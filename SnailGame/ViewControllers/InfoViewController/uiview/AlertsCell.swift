//
//  AlertsCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AlertsCell: UICollectionViewCell {
    
    var timeLbl , dateLbl , titleLbl , contentLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        timeLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 18*PROSIZE))
        timeLbl?.textColor = colorWithHex(hex: 0x0077FF)
        timeLbl?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        self.addSubview(timeLbl!)
        
        dateLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (timeLbl?.frame.origin.y)!+(timeLbl?.frame.size.height)!+6*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 12*PROSIZE))
        dateLbl?.textColor = colorWithHex(hex: 0x999999)
        dateLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(dateLbl!)
        
        titleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (dateLbl?.frame.origin.y)!+(dateLbl?.frame.size.height)!+19*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 40*PROSIZE))
        titleLbl?.textColor = colorWithHex(hex: 0x333333)
        titleLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        titleLbl?.numberOfLines = 0
        self.addSubview(titleLbl!)
        
        contentLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (titleLbl?.frame.origin.y)!+(titleLbl?.frame.size.height)!+10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 40*PROSIZE))
        contentLbl?.textColor = colorWithHex(hex: 0x999999)
        contentLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        contentLbl?.numberOfLines = 0
        self.addSubview(contentLbl!)
        
    }
    
    func setAlertsCell(dataModel:AlertsDataModel) {
        
        timeLbl?.text = getTimeFromStamp(stamp: dataModel.create_time!)
        dateLbl?.text = dataModel.timeline
        let titleSize = NSString.calStrSize(textStr: dataModel.title! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 18*PROSIZE)
        titleLbl?.frame.size.height = titleSize.height
        titleLbl?.text = dataModel.title
        let contentSize = NSString.calStrSize(textStr: dataModel.details! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 14*PROSIZE)
        contentLbl?.frame.origin.y = titleLbl!.frame.origin.y+titleLbl!.frame.size.height+10*PROSIZE
        contentLbl?.frame.size.height = contentSize.height
        contentLbl?.text = dataModel.details
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
