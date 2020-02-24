//
//  WealthBannerCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

//import ASHorizontalScrollView

class WealthBannerCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let noteLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 14*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 40*PROSIZE))
        noteLbl.text = "*总资产以当前各币实时价格转化计得，有一定误差；其不含糖果价值。"
        noteLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noteLbl.textColor = colorWithHex(hex: 0x333333)
        noteLbl.numberOfLines = 0
        self.addSubview(noteLbl)
            
//       bannerScrlView = ASHorizontalScrollView.init(frame: CGRect.init(x: 0, y: 20*PROSIZE, width: self.frame.size.width, height: 110*PROSIZE))
//        let setting = MarginSettings.init(leftMargin: 20*PROSIZE, miniMarginBetweenItems: 10*PROSIZE, miniAppearWidthOfLastItem: 10*PROSIZE)
//        bannerScrlView?.defaultMarginSettings = setting
//        bannerScrlView?.uniformItemSize = CGSize.init(width: self.frame.size.width-40*PROSIZE, height: 110*PROSIZE)
//        bannerScrlView?.setItemsMarginOnce()
//        self.addSubview(bannerScrlView!)
    }
    
//    let images = NSMutableArray.init()
//
//    func setWealthBannerCell(list:NSArray) {
//        if bannerList.count != list.count {
//            bannerScrlView?.removeAllItems()
//            for (_,item) in list.enumerated() {
//                let dataModel:BannerDataModel = item as! BannerDataModel
//                let imageV = UIImageView.init(frame: CGRect.zero)
//                imageV.layer.cornerRadius = 10
//                imageV.layer.masksToBounds = true
//                imageV.dwn_setImageView(urlStr: dataModel.cover!, imageName: "")
//                images.add(imageV)
//            }
//            bannerScrlView?.addItems(images as! [UIView])
//            bannerList = list
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
