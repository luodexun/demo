//
//  HomeBannerCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol HomeBannerItemDelegate {
    func homeBannerItemAction(index:Int)
}

class HomeBannerCell: UICollectionViewCell , SDCycleScrollViewDelegate {
    
    var infoHeadScrl : SDCycleScrollView?
    
    var bannerDelegate : HomeBannerItemDelegate?
    
    var arrData = NSArray.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let headIcon = UIImageView.init(frame: CGRect.init(x: 18*PROSIZE, y: line.frame.size.height+16*PROSIZE, width: 35*PROSIZE, height: 35*PROSIZE))
        headIcon.image = UIImage.init(named: "ic_home_Info")
        self.addSubview(headIcon)
        
        infoHeadScrl = SDCycleScrollView.init(frame: CGRect.init(x: 71*PROSIZE, y: line.frame.size.height, width: SCREEN_WIDE-91*PROSIZE, height: 65*PROSIZE), delegate: self, placeholderImage: UIImage.init())
        infoHeadScrl?.backgroundColor = UIColor.white
        infoHeadScrl?.autoScrollTimeInterval = 4
        infoHeadScrl?.onlyDisplayText = true
        infoHeadScrl?.scrollDirection = .vertical
        infoHeadScrl?.titleLabelBackgroundColor = UIColor.white
        infoHeadScrl?.titleLabelTextFont = UIFont.systemFont(ofSize: 15*PROSIZE)
        infoHeadScrl?.titleLabelHeight = 65*PROSIZE
        infoHeadScrl?.disableScrollGesture()
        infoHeadScrl?.titleLabelTextColor = colorWithHex(hex: 0x333333)
        self.addSubview(infoHeadScrl!)
    }
    
    func setHomeBannerCell(list:NSArray) {
        if arrData.count != list.count {
            arrData = list
            infoHeadScrl?.titlesGroup = (list as! [Any])
        }
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        bannerDelegate?.homeBannerItemAction(index: index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
