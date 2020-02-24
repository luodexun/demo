//
//  VipDetailCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias VipDetailRightBlock = (_ detailModel:VipInfoDetailModel) -> Void

typealias VipDetailRightPushBlock = () -> Void

class VipDetailCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource , VipDetailRightDelegate , VipDetailRenewalDelegate  {
    
    var userModel : UserLoginDataModel?
    
    var infoModel : VipInfoDataModel?
    
    var vipDetailRightHandel : VipDetailRightBlock?
    
    var vipRightDetailHandel : VipDetailRightPushBlock?
    
    var vipRightRenewalHandel : VipDetailRightPushBlock?
    
    var vipRightRuleHandel : VipDetailRightPushBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.init(white: 255/255.0, alpha: 0.0)
        
        self.register(VipDetailUserCell.self, forCellWithReuseIdentifier: "VipDetailUserId")
        
        self.register(VipDetailRenewalCell.self, forCellWithReuseIdentifier: "VipDetailRenewalId")
        
        self.register(VipDetailDateCell.self, forCellWithReuseIdentifier: "VipDetailDateId")
        
        self.register(VipDetailRightCell.self, forCellWithReuseIdentifier: "VipDetailRightId")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            
            let cell:VipDetailUserCell = self.dequeueReusableCell(withReuseIdentifier: "VipDetailUserId", for: indexPath) as! VipDetailUserCell
            if userModel != nil {
                cell.userImageView?.dwn_setImageView(urlStr: (userModel?.avatar!)!, imageName: "")
                cell.userNameLbl?.text = userModel?.nickname
            }
            return cell
            
        } else if indexPath.item == 1 {
            
            let cell:VipDetailRenewalCell = self.dequeueReusableCell(withReuseIdentifier: "VipDetailRenewalId", for: indexPath) as! VipDetailRenewalCell
            cell.renewalDelegate = self
            if infoModel != nil {
                cell.setVipDetailRenewalCell(infoModel: infoModel!)
            }
            return cell
            
        } else if indexPath.item == 2 {
            let cell:VipDetailDateCell = self.dequeueReusableCell(withReuseIdentifier: "VipDetailDateId", for: indexPath) as! VipDetailDateCell
            if infoModel != nil {
                cell.setVipDetailDateCell(infoModel: infoModel!)
            }
            return cell
            
        } else {
            
            let cell:VipDetailRightCell = self.dequeueReusableCell(withReuseIdentifier: "VipDetailRightId", for: indexPath) as! VipDetailRightCell
            cell.rightDelegate = self
            if infoModel != nil {
                cell.setPromotionVipRightCell(list:infoModel!.information! as NSArray)
            }
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            
            return CGSize.init(width: SCREEN_WIDE, height: 197*PROSIZE)
            
        } else if indexPath.item == 1 {
            
            return CGSize.init(width: SCREEN_WIDE, height: 175*PROSIZE)
            
        } else if indexPath.item == 2 {
            
            return CGSize.init(width: SCREEN_WIDE, height: 55*PROSIZE)
            
        } else {
            
            return CGSize.init(width: SCREEN_WIDE, height: 587*PROSIZE)
            
        }
    }
    
    func vipDetailRenewalAction() {
        vipRightRenewalHandel!()
    }
    
    func vipRightRuleAction() {
        vipRightDetailHandel!()
    }
    
    func vipDetailRightAction(detailModel:VipInfoDetailModel) {
        vipDetailRightHandel!(detailModel)
    }
    
    func vipRightDetailAction() {
        vipRightRuleHandel!()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 15*PROSIZE, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15*PROSIZE
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
