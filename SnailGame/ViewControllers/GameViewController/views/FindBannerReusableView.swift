//
//  FindBannerReusableView.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

protocol FindBannerDelegate {
    func findBannerAction(bannerModel:FindListBannerModel)
}

class FindBannerReusableView: UICollectionReusableView , SDCycleScrollViewDelegate {
    
    var bannerScrl : SDCycleScrollView?
    
    var bannerDelegate : FindBannerDelegate?
    
    var banners : NSArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bannerScrl = SDCycleScrollView.init(frame: CGRect.init(x: 20*PROSIZE, y: 30*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 110*PROSIZE), delegate: self, placeholderImage: UIImage.init(named: "ic_find_long_none"))
        bannerScrl?.backgroundColor = UIColor.white
        bannerScrl?.contentMode = .scaleAspectFill
        bannerScrl?.autoScrollTimeInterval = 3
        bannerScrl?.layer.cornerRadius = 10
        bannerScrl?.layer.masksToBounds = true
        bannerScrl?.currentPageDotColor = colorWithHex(hex: 0x0077FF)
        bannerScrl?.pageDotColor = UIColor.white
        self.addSubview(bannerScrl!)
        
    }
    
    func setFindBannerReusableView(banner:NSArray) {
        
        banners = banner
        
        let images = NSMutableArray.init()
        
        for (_,item) in banner.enumerated() {
            let bannerModel:FindListBannerModel = item as! FindListBannerModel
            images.add(bannerModel.cover as Any)
        }
        bannerScrl?.imageURLStringsGroup = images as? [Any]
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let bannerModel:FindListBannerModel = banners![index] as! FindListBannerModel
        bannerDelegate?.findBannerAction(bannerModel: bannerModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
