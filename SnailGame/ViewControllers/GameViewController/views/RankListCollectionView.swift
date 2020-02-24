//
//  RankListCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RankListCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {

    var rankList = NSMutableArray.init()

    var remainTimeStr = ""
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = UIColor.white
    
        self.register(RankListReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "RankListReusableId")
    
        self.register(RankListCell.self, forCellWithReuseIdentifier: "RankListId")

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RankListCell = self.dequeueReusableCell(withReuseIdentifier: "RankListId", for: indexPath) as! RankListCell
        cell.setRankListCell(pageModel: rankList[indexPath.item] as! RankListPageModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionFooter){
            let footView : RankListReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RankListReusableId", for: indexPath) as! RankListReusableView
            if self.tag == 3000 {
                footView.remainTimeLbl?.text = "日榜每日凌晨0点结算（" + remainTimeStr + "）"
            } else if self.tag == 3001 {
                footView.remainTimeLbl?.text = "周榜每周一凌晨0点结算（" + remainTimeStr + "）"
            } else {
                footView.remainTimeLbl?.text = "月榜每月1号凌晨0点结算（" + remainTimeStr + "）"
            }
            reusableview = footView
        }
        return reusableview!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 55*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 51*PROSIZE)
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
}
