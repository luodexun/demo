//
//  FindCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

typealias FindMoreBlock = (_ section:Int) -> Void

typealias FindBannerBlock = (_ bannerModel:FindListBannerModel) -> Void

typealias FindGameBlock = (_ detailModel:FindListDetailModel) -> Void

class FindCollectionView: BaseCollectionView ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource , FindNomalDelegate , FindBannerDelegate , FindGameDelegate {
    
    var findMoreHandel : FindMoreBlock?
    
    var findBannerHandel : FindBannerBlock?
    
    var findGameHandel : FindGameBlock?
    
    var banners = NSArray.init()
    
    var records = NSArray.init()
    
    var sections = NSArray.init()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = UIColor.white
        
        setRefreshEnable()
        
        self.register(FindBannerReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FindBannerReusableId")
        
        self.register(FindNomalReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FindNomalReusableId")
        
        self.register(FindBannerCell.self, forCellWithReuseIdentifier: "FindBannerId")
        
        self.register(FindNomalCell.self, forCellWithReuseIdentifier: "FindNomalId")
        
        self.register(FindFootReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FindFootReusableId")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1+sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        let sectionModel:FindListSectionModel = sections[section-1] as! FindListSectionModel
        return sectionModel.app_list!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:FindBannerCell = self.dequeueReusableCell(withReuseIdentifier: "FindBannerId", for: indexPath) as! FindBannerCell
            cell.gameDelegate = self
            cell.setFindBannerCell(list:records)
            return cell
        } else {
            let cell:FindNomalCell = self.dequeueReusableCell(withReuseIdentifier: "FindNomalId", for: indexPath) as! FindNomalCell
            let sectionModel:FindListSectionModel = sections[indexPath.section-1] as! FindListSectionModel
            cell.setFindNomalCell(detailModel:sectionModel.app_list![indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize.init(width: SCREEN_WIDE, height: 129*PROSIZE)
        }
        return CGSize.init(width: (SCREEN_WIDE-82*PROSIZE)/4, height: (SCREEN_WIDE-82*PROSIZE)/4 + 26*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader && indexPath.section == 0) {
            let headView : FindBannerReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FindBannerReusableId", for: indexPath) as! FindBannerReusableView
            headView.bannerDelegate = self
            headView.setFindBannerReusableView(banner:banners)
            reusableview = headView
        } else if (kind == UICollectionView.elementKindSectionFooter) {
            let footView : FindFootReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FindFootReusableId", for: indexPath) as! FindFootReusableView
            reusableview = footView
        } else if(kind == UICollectionView.elementKindSectionHeader) {
            let headView : FindNomalReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FindNomalReusableId", for: indexPath) as! FindNomalReusableView
            let sectionModel:FindListSectionModel = sections[indexPath.section-1] as! FindListSectionModel
            headView.section = indexPath.section-1
            headView.titleNameLbl?.text = sectionModel.name
            headView.setFindNomalReusableView(banner:sectionModel.banner! as NSArray)
            headView.nomalDelegate = self
            reusableview = headView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: SCREEN_WIDE, height: 150*PROSIZE)
        }
        let sectionModel:FindListSectionModel = sections[section-1] as! FindListSectionModel
        var bannerH:CGFloat = -16*PROSIZE
        if sectionModel.banner?.count != 0 {
            bannerH = 110*PROSIZE
        }
        return CGSize.init(width: SCREEN_WIDE, height:  57*PROSIZE+bannerH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 17*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionModel:FindListSectionModel = sections[indexPath.section-1] as! FindListSectionModel
        let detailModel:FindListDetailModel = sectionModel.app_list![indexPath.item]
        findGameHandel!(detailModel)
    }
    
    func findBannerAction(bannerModel: FindListBannerModel) {
        findBannerHandel!(bannerModel)
    }
    
    func FindNomalMoreAction(section:Int) {
        findMoreHandel!(section)
    }
    
    func findNomalBannerAction(detailModel:FindListDetailModel) {
        findGameHandel!(detailModel)
    }
    
    func findGameAction(detailModel: FindListDetailModel) {
        findGameHandel!(detailModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets.init(top: 16*PROSIZE, left: 20*PROSIZE, bottom: 0, right: 20*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14*PROSIZE
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
