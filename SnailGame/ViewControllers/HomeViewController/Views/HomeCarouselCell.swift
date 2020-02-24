//
//  HomeCarouselCell.swift
//  SnailGame
//
//  Created by Edison on 2020/1/13.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

protocol HomeCarouselDelegate {
    func homeCarouselSelectItemAction(dataModel:BannerDataModel)
}

class HomeCarouselCell: UICollectionViewCell , SNCarouselDelegate , SNCarouselDatasource {
    
    var carousel : SNCarousel?
    
    var bannerList = NSArray.init()
    
    var carouselDelegate : HomeCarouselDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let flowLayout = SNFlowLayout.init()
        flowLayout.itemWidth = 330*PROSIZE
        carousel = SNCarousel.init(frame: CGRect.init(x: 0, y: 12*PROSIZE, width: SCREEN_WIDE, height: 146*PROSIZE), delegate: self, datasource: self, flowLayout: flowLayout)
        carousel?.backgroundColor = UIColor.white
        self.addSubview(carousel!)
        
        carousel?.registerViewClass(viewClass: BannerItemCell.self, identifier: "banner")
        
    }
    
    func setHomeCarouselCell(list:NSArray) {
        if list.count != bannerList.count {
            bannerList = list
            carousel?.freshCarousel()
        }
    }
    
    func SNCarouselDidSelected(carousel: SNCarousel, index: Int) {
        carouselDelegate?.homeCarouselSelectItemAction(dataModel: bannerList[index] as! BannerDataModel)
    }
    
    func numbersForCarousel() -> Int {
        return bannerList.count
    }
    
    func viewForCarousel(carousel: SNCarousel, indexPath: NSIndexPath, index: Int) -> UICollectionViewCell {
        let cell:BannerItemCell = carousel.carouselView?.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath as IndexPath) as! BannerItemCell
        let model:BannerDataModel = bannerList[index] as! BannerDataModel
        cell.bannerImageView?.dwn_setImageView(urlStr: model.cover!, imageName: "")
        let titleAttrStr = NSMutableAttributedString.init(string: model.tag! + "  |  " + model.title!)
        titleAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xff7700), range:NSRange.init(location:0, length: model.tag!.count))
        cell.bannerTitleLbl!.attributedText = titleAttrStr
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
