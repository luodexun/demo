//
//  PromotionVipCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias PromotionVipPushBlock = (_ opera: Int) -> Void

typealias PromotionVipRightBlock = (_ detailModel: VipInfoDetailModel) -> Void

class PromotionVipCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource , PromotionVipPriceDelegate , PromotionVipRightDelegate {
    
    var promotionVipPushHandel : PromotionVipPushBlock?
    
    var userModel : UserLoginDataModel?
    
    var infoModel : VipInfoDataModel?
    
    var promotionRightDetailHandel : PromotionVipPushBlock?
    
    var promotionVipRightHandel : PromotionVipRightBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.init(white: 255/255.0, alpha: 0.0)
        
        self.register(PromotionVipUserCell.self, forCellWithReuseIdentifier: "PromotionVipUserId")
        
        self.register(PromotionVipPriceCell.self, forCellWithReuseIdentifier: "PromotionVipPriceId")
        
        self.register(PromotionVipRightCell.self, forCellWithReuseIdentifier: "PromotionVipRightId")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell:PromotionVipUserCell = self.dequeueReusableCell(withReuseIdentifier: "PromotionVipUserId", for: indexPath) as! PromotionVipUserCell
            cell.userImageView?.dwn_setImageView(urlStr: userModel!.avatar!, imageName: "")
            cell.userNameLbl?.text = userModel?.nickname
            return cell
        } else if indexPath.item == 1 {
            let cell:PromotionVipPriceCell = self.dequeueReusableCell(withReuseIdentifier: "PromotionVipPriceId", for: indexPath) as! PromotionVipPriceCell
            cell.priceDelegate = self
            if infoModel != nil {
                cell.setPromotionVipPriceCell(infoModel: infoModel!)
            }
            return cell
        } else {
            let cell:PromotionVipRightCell = self.dequeueReusableCell(withReuseIdentifier: "PromotionVipRightId", for: indexPath) as! PromotionVipRightCell
            cell.rightDelegate = self
            if infoModel != nil {
                cell.setPromotionVipRightCell(list:infoModel!.information! as NSArray)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: SCREEN_WIDE, height: 192*PROSIZE)
        } else if indexPath.item == 1 {
            return CGSize.init(width: SCREEN_WIDE, height: 280*PROSIZE)
        } else {
            return CGSize.init(width: SCREEN_WIDE, height: 587*PROSIZE)
        }
    }
    
    func promotionVipPriceAction(opera:Int) {
        promotionVipPushHandel!(opera)
    }
    
    func promotionVipRightAction(detailModel: VipInfoDetailModel) {
        promotionVipRightHandel!(detailModel)
    }
    
    func promotionVipRightDetailAction() {
        promotionRightDetailHandel!(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 20*PROSIZE, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
