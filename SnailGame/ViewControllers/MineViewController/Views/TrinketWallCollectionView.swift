//
//  TrinketWallCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias TrinketWallBlock = (_ dataModel:TrinketWallDataModel) -> Void

class TrinketWallCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
    var wallList : NSMutableArray?
    
    var trinketWallHandel : TrinketWallBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = colorWithHex(hex: 0xE5E2D8)
        
        self.register(TrinketWallReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TrinketWallReusableId")
        
        self.register(TrinketWallCell.self, forCellWithReuseIdentifier: "TrinketWallId")
        
        wallList = NSMutableArray.init()
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TrinketWallCell = self.dequeueReusableCell(withReuseIdentifier: "TrinketWallId", for: indexPath) as! TrinketWallCell
        cell.setTrinketWallCell(wallModel:wallList![indexPath.item] as! TrinketWallDataModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader){
            let headView : TrinketWallReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrinketWallReusableId", for: indexPath) as! TrinketWallReusableView
            reusableview = headView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 67*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE/3, height: 169*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        trinketWallHandel!(wallList![indexPath.item] as! TrinketWallDataModel)
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
