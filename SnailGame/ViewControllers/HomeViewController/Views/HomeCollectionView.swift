//
//  HomeCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias HomeTaskPushBlock = (_ opera:Int) -> Void

typealias HomeBannerSelectBlock = (_ dataModel:BannerDataModel) -> Void

typealias HomeWikipeBlock = (_ dataModel:InfoDataModel) -> Void

typealias HomeGameBlock = (_ dataModel:FindListDetailModel) -> Void

protocol HomeScrollDelegate {
    func homeScrollDidScrl(scrol_y:CGFloat)
}

class HomeCollectionView: BaseCollectionView ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource , UIScrollViewDelegate , HomeTaskPushDelegate , HomeWealthPushDelegate , HomeBannerItemDelegate , HomeWikipeDelegate , HomeGameDelegate , HomeCarouselDelegate {
    
    var bannerList = NSMutableArray.init()

    var hotNews = NSArray.init()
    
    var wikipeList = NSArray.init()
    
    var gameBanners = NSArray.init()
    
    var gameList = NSArray.init()
    
    var totalRmb , totalDwn , gameTitle : String?
    
    var isShow = false
    
    var isService = 0
    
    var homeTaskPushHandel : HomeTaskPushBlock?
    
    var homeWealthPushHandel : HomeTaskPushBlock?
    
    var homeBannerHandel : HomeTaskPushBlock?
    
    var homeBannerSelectHandel : HomeBannerSelectBlock?
    
    var homeWikipeHandel : HomeWikipeBlock?
    
    var homeGameMoreHandel : HomeTaskPushBlock?
    
    var homeGameHandel : HomeGameBlock?
    
    var scrollDelegate : HomeScrollDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.register(HomeWealthCell.self, forCellWithReuseIdentifier: "HomeWealthId")
        
        self.register(HomeCarouselCell.self, forCellWithReuseIdentifier: "HomeCarouselId")
        
        self.register(HomeGameCell.self, forCellWithReuseIdentifier: "HomeGameId")
        
        self.register(HomeBannerCell.self, forCellWithReuseIdentifier: "HomeBannerId")
        
        self.register(HomeTaskCell.self, forCellWithReuseIdentifier: "HomeTaskId")
        
        self.register(HomeWikipeCell.self, forCellWithReuseIdentifier: "HomeWikipeId")
        
        totalRmb = ""
        totalDwn = "-"
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell:HomeWealthCell = self.dequeueReusableCell(withReuseIdentifier: "HomeWealthId", for: indexPath) as! HomeWealthCell
            cell.wealthDelegate = self
            cell.setHomeWealthCell(totalRmb: totalRmb!, totalDwn: totalDwn!,isShow: self.isShow)
            return cell
        }else if indexPath.item == 1 {
            let cell:HomeCarouselCell = self.dequeueReusableCell(withReuseIdentifier: "HomeCarouselId", for: indexPath) as! HomeCarouselCell
            cell.carouselDelegate = self
            cell.setHomeCarouselCell(list: bannerList)
            return cell
        }else if indexPath.item == 2 {
            let cell:HomeGameCell = self.dequeueReusableCell(withReuseIdentifier: "HomeGameId", for: indexPath) as! HomeGameCell
            if isService == 1 {
                cell.isHidden = false
                cell.titleNameLbl?.text = gameTitle
                cell.gameDelegate = self
            } else {
                cell.isHidden = true
            }
            cell.setHomeGameCell(banners: gameBanners, appList: gameList)
            return cell
        }else if indexPath.item == 3 {
            let cell:HomeBannerCell = self.dequeueReusableCell(withReuseIdentifier: "HomeBannerId", for: indexPath) as! HomeBannerCell
            cell.setHomeBannerCell(list: hotNews)
            cell.bannerDelegate = self
            return cell
        } else if indexPath.item == 4 {
            let cell:HomeTaskCell = self.dequeueReusableCell(withReuseIdentifier: "HomeTaskId", for: indexPath) as! HomeTaskCell
            cell.taskDelegate = self
            cell.setHomeTaskCell(isService: isService)
            return cell
        } else {
            let cell:HomeWikipeCell = self.dequeueReusableCell(withReuseIdentifier: "HomeWikipeId", for: indexPath) as! HomeWikipeCell
            cell.setHomeWikipeCell(list: wikipeList)
            cell.wikipeDelegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: SCREEN_WIDE, height: 204*PROSIZE+STABAR_HEIGHT)
        } else if indexPath.item == 1 {
            return CGSize.init(width: SCREEN_WIDE, height: 162*PROSIZE)
        } else if indexPath.item == 2 {
            if isService == 1 {
                let count = gameList.count / 4
                let less = (gameList.count % 4 == 0) ? 0 : 1
                var bannerH:CGFloat = 0.0
                if gameBanners.count != 0 {
                    bannerH = 126*PROSIZE
                }
                return CGSize.init(width: SCREEN_WIDE, height: 67*PROSIZE + bannerH + ((SCREEN_WIDE-82*PROSIZE)/4 + 42*PROSIZE)*CGFloat(count) + ((SCREEN_WIDE-82*PROSIZE)/4 + 42*PROSIZE)*CGFloat(less) )
            }
            return CGSize.init(width: SCREEN_WIDE, height: 0.0 )
        } else if indexPath.item == 3 {
            return CGSize.init(width: SCREEN_WIDE, height: 75*PROSIZE)
        } else if indexPath.item == 4 {
            if isService != 0 {
                return CGSize.init(width: SCREEN_WIDE, height: 265*PROSIZE)
            }
            return CGSize.init(width: SCREEN_WIDE, height: 196*PROSIZE)
        } else {
            return CGSize.init(width: SCREEN_WIDE, height: 259*PROSIZE)
        }
    }
    
    func homeWealthPushAction(opera: Int) {
        homeWealthPushHandel!(opera)
    }
    
    func homeBannerItemAction(index: Int) {
        homeBannerHandel!(index)
    }
    
    func homeCarouselSelectItemAction(dataModel: BannerDataModel) {
        homeBannerSelectHandel!(dataModel)
    }
    
    func homeGamePushAction(detailModel: FindListDetailModel) {
        homeGameHandel!(detailModel)
    }
    
    func homeGameMoreAction() {
        homeGameMoreHandel!(1)
    }
    
    func homeWealthUpdateShowAction(isShow: Bool) {
        self.isShow = isShow
        self.reloadData()
    }
    
    func homeTaskPushAction(opera: Int) {
        homeTaskPushHandel!(opera)
    }
    
    func homeWikipeAction(dataModel: InfoDataModel) {
        homeWikipeHandel!(dataModel)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.homeScrollDidScrl(scrol_y: scrollView.contentOffset.y)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
