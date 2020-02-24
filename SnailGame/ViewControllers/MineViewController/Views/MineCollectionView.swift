//
//  MineCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias MinePushBlock = (_ showModel:MineShowModel) -> Void

typealias MineHeadPushBlock = (_ opera:Int) -> Void

class MineCollectionView: UICollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource , MineHeadPushDelegate {
    
    var userModel : UserLoginDataModel?

    var mineList = NSMutableArray.init()
    
    var isService = 0
    
    var minePushHandel : MinePushBlock?
    
    var mineHeadPushHandel : MineHeadPushBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *){
           self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        
        self.register(MineHeadReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MineHeadReusableId")
        
        self.register(MineNomalCell.self, forCellWithReuseIdentifier: "MineNomalId")
        
        self.register(MineLineCell.self, forCellWithReuseIdentifier: "MineLineId")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mineList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let showModel:MineShowModel = mineList[indexPath.item] as! MineShowModel
        
        if showModel.cellType == 2
        {
            let cell:MineNomalCell = self.dequeueReusableCell(withReuseIdentifier: "MineNomalId", for: indexPath) as! MineNomalCell
            cell.setMineNomalCell(showModel: showModel)
            return cell
        }
        else
        {
            let cell:MineLineCell = self.dequeueReusableCell(withReuseIdentifier: "MineLineId", for: indexPath) as! MineLineCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader){
            let headView : MineHeadReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MineHeadReusableId", for: indexPath) as! MineHeadReusableView
            headView.mineDelegate = self
            headView.setMineHeadReusableView(userModel: userModel!,isService: isService)
            reusableview = headView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if isService == 1 {
            return CGSize.init(width: SCREEN_WIDE, height: 220*PROSIZE+STABAR_HEIGHT)
        }
        return CGSize.init(width: SCREEN_WIDE, height: 140*PROSIZE+STABAR_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showModel:MineShowModel = mineList[indexPath.item] as! MineShowModel
        if showModel.cellType == 2 {
            return CGSize.init(width: SCREEN_WIDE, height: 55*PROSIZE)
        }
        return CGSize.init(width: SCREEN_WIDE, height: 10*PROSIZE)
    }
    
    func MineHeadPushAction(opera:Int) {
        mineHeadPushHandel!(opera)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let showModel:MineShowModel = mineList[indexPath.item] as! MineShowModel
        minePushHandel!(showModel)
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
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
