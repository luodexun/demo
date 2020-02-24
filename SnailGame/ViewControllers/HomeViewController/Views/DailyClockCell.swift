//
//  DailyClockCell.swift
//  SnailGame
//
//  Created by Edison on 2019/11/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DailyClockCell: UICollectionViewCell {
    
    var clockImageView , chestIcon : UIImageView?
    
//    var images = [UIImage.init(named: "icon_daily_clock_nol"),UIImage.init(named: "icon_daily_clock_on")]
//
    var clockScale : CGFloat = 1.1

    override init(frame: CGRect) {
        super.init(frame: frame)
        clockImageView = UIImageView.init(frame: CGRect.init(x: 4*PROSIZE, y: 5*PROSIZE, width: 40*PROSIZE, height: 50*PROSIZE))
        clockImageView?.image = UIImage.init(named: "icon_daily_clock_nol")
        self.addSubview(clockImageView!)
        
        chestIcon = UIImageView.init(frame: CGRect.init(x: 9*PROSIZE, y: 15*PROSIZE, width: 30*PROSIZE, height: 30*PROSIZE))
        chestIcon?.image = UIImage.init(named: "icon_daily_clock_chest")
        chestIcon?.isHidden = true
        self.addSubview(chestIcon!)
    }
    
    func setDailyClockCell(dataModel:DailyClockDataModel) {
        if dataModel.status == 1 {
            if clockImageView!.isAnimating {
                clockImageView?.stopAnimating()
            }
            clockImageView?.image = UIImage.init(named: "icon_daily_clock_sel")
            chestIcon?.isHidden = true
        } else {
            if dataModel.type == 1 {
                chestIcon?.isHidden = false
            } else {
                chestIcon?.isHidden = true
            }
            if dataModel.select == 1 {
                clockImageView?.image = UIImage.init(named: "icon_daily_clock_on")
                UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
                    self.clockImageView?.transform = CGAffineTransform.init(scaleX: self.clockScale, y: self.clockScale)
                    if self.clockScale == 1.1 {
                        self.clockScale = 1
                    } else {
                        self.clockScale = 1.1
                    }
                }, completion: nil)
            } else {
                if clockImageView!.isAnimating {
                    clockImageView?.stopAnimating()
                }
                clockImageView?.image = UIImage.init(named: "icon_daily_clock_nol")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
