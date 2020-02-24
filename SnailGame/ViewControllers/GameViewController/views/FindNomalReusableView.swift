//
//  FindNomalReusableView.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

protocol FindNomalDelegate {
    func FindNomalMoreAction(section:Int)
    func findNomalBannerAction(detailModel:FindListDetailModel)
}

class FindNomalReusableView: UICollectionReusableView , SDCycleScrollViewDelegate {
    
    var titleNameLbl : UILabel?
    
    var bannerScrl : SDCycleScrollView?
    
    var section = 0
    
    var banners : NSArray?
    
    var nomalDelegate : FindNomalDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: 200*PROSIZE, height: 21*PROSIZE))
        titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(titleNameLbl!)
        
        let moreLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-74*PROSIZE, y: 20*PROSIZE, width: 40*PROSIZE, height: 21*PROSIZE))
        moreLbl.textColor = colorWithHex(hex: 0x333333)
        moreLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        moreLbl.text = "更多"
        moreLbl.textAlignment = .right
        self.addSubview(moreLbl)
        
        let nextIcon = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 21*PROSIZE))
        nextIcon.contentMode = .scaleAspectFit
        nextIcon.image = UIImage.init(named: "ic_mine_next")
        self.addSubview(nextIcon)
        
        let moreBtn = UIButton.init(type: .roundedRect)
        moreBtn.frame = CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 41*PROSIZE)
        moreBtn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        self.addSubview(moreBtn)
        
        bannerScrl = SDCycleScrollView.init(frame: CGRect.init(x: 20*PROSIZE, y: 57*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 110*PROSIZE), delegate: self, placeholderImage: UIImage.init(named: "ic_find_long_none"))
        bannerScrl?.backgroundColor = UIColor.white
        bannerScrl?.contentMode = .scaleAspectFill
        bannerScrl?.autoScrollTimeInterval = 3
        bannerScrl?.layer.cornerRadius = 10
        bannerScrl?.layer.masksToBounds = true
        bannerScrl?.currentPageDotColor = colorWithHex(hex: 0x0077FF)
        bannerScrl?.pageDotColor = UIColor.white
        self.addSubview(bannerScrl!)
        
    }
    
    func setFindNomalReusableView(banner:NSArray) {
        banners = banner
        if banner.count != 0 {
            bannerScrl?.isHidden = false
            let images = NSMutableArray.init()
            for (_,item) in banner.enumerated() {
                let detailModel:FindListDetailModel = item as! FindListDetailModel
                images.add(detailModel.cover as Any)
            }
            bannerScrl?.imageURLStringsGroup = images as? [Any]
        } else {
            bannerScrl?.isHidden = true
        }
    }
    
    @objc func moreAction(sender:UIButton) {
        nomalDelegate?.FindNomalMoreAction(section: section)
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let detailModel:FindListDetailModel = banners![index] as! FindListDetailModel
        nomalDelegate?.findNomalBannerAction(detailModel: detailModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
