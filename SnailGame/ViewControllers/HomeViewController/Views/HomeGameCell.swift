//
//  HomeGameCell.swift
//  SnailGame
//
//  Created by Edison on 2020/1/13.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

protocol HomeGameDelegate {
    func homeGamePushAction(detailModel:FindListDetailModel)
    func homeGameMoreAction()
}

class HomeGameCell: UICollectionViewCell , SDCycleScrollViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var titleNameLbl : UILabel?
    
    var bannerScrl : SDCycleScrollView?
    
    var itemCV : UICollectionView?
    
    var gameList , bannerList : NSArray?
    
    var gameDelegate : HomeGameDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 30*PROSIZE, width: 200*PROSIZE, height: 21*PROSIZE))
        titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(titleNameLbl!)
        
        let moreLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-74*PROSIZE, y: 30*PROSIZE, width: 40*PROSIZE, height: 21*PROSIZE))
        moreLbl.textColor = colorWithHex(hex: 0x333333)
        moreLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        moreLbl.text = "更多"
        moreLbl.textAlignment = .right
        self.addSubview(moreLbl)
        
        let nextIcon = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 30*PROSIZE, width: 8*PROSIZE, height: 21*PROSIZE))
        nextIcon.contentMode = .scaleAspectFit
        nextIcon.image = UIImage.init(named: "ic_mine_next")
        self.addSubview(nextIcon)
        
        let moreBtn = UIButton.init(type: .roundedRect)
        moreBtn.frame = CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 41*PROSIZE)
        moreBtn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        self.addSubview(moreBtn)
        
        bannerScrl = SDCycleScrollView.init(frame: CGRect.init(x: 20*PROSIZE, y: 67*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 110*PROSIZE), delegate: self, placeholderImage: UIImage.init(named: "ic_find_long_none"))
        bannerScrl?.backgroundColor = UIColor.white
        bannerScrl?.contentMode = .scaleAspectFill
        bannerScrl?.autoScrollTimeInterval = 3
        bannerScrl?.layer.cornerRadius = 10
        bannerScrl?.layer.masksToBounds = true
        bannerScrl?.currentPageDotColor = colorWithHex(hex: 0x0077FF)
        bannerScrl?.pageDotColor = UIColor.white
        self.addSubview(bannerScrl!)
        
        let layout = UICollectionViewFlowLayout.init()
        itemCV = UICollectionView.init(frame: CGRect.init(x: 0, y: 177*PROSIZE, width: SCREEN_WIDE, height: 0.0), collectionViewLayout: layout)
        itemCV?.isScrollEnabled = false
        itemCV?.delegate = self
        itemCV?.dataSource = self
        itemCV?.backgroundColor = UIColor.white
        self.addSubview(itemCV!)
        
        itemCV?.register(FindNomalCell.self, forCellWithReuseIdentifier: "FindNomalId")
    }
    
    func setHomeGameCell(banners:NSArray,appList:NSArray) {
        
        itemCV?.reloadData()
        if banners.count != 0 {
            bannerScrl?.isHidden = false
            itemCV?.frame.origin.y = 177*PROSIZE
            itemCV?.frame.size.height = self.frame.size.height-193*PROSIZE
            let images = NSMutableArray.init()
            for (_,item) in banners.enumerated() {
                let detailModel:FindListDetailModel = item as! FindListDetailModel
                images.add(detailModel.cover as Any)
            }
            bannerScrl?.imageURLStringsGroup = images as? [Any]
        } else {
            bannerScrl?.isHidden = true
            itemCV?.frame.origin.y = 51*PROSIZE
            itemCV?.frame.size.height = self.frame.size.height-67*PROSIZE
        }
        
        bannerList = banners
        gameList = appList
    }
    
    @objc func moreAction(sender:UIButton) {
        gameDelegate?.homeGameMoreAction()
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let detailModel:FindListDetailModel = bannerList![index] as! FindListDetailModel
        gameDelegate?.homeGamePushAction(detailModel: detailModel)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FindNomalCell = itemCV?.dequeueReusableCell(withReuseIdentifier: "FindNomalId", for: indexPath) as! FindNomalCell
        cell.setFindNomalCell(detailModel:gameList![indexPath.item] as! FindListDetailModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (SCREEN_WIDE-82*PROSIZE)/4, height: (SCREEN_WIDE-82*PROSIZE)/4 + 26*PROSIZE)
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameDelegate?.homeGamePushAction(detailModel: gameList![indexPath.item] as! FindListDetailModel)
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 16*PROSIZE, left: 20*PROSIZE, bottom: 0, right: 20*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
