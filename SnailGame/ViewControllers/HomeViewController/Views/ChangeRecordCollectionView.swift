//
//  ChangeRecordCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ChangeRecordCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
    var recordList = NSMutableArray.init()
    
    var recordType = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.white
        
        self.delegate = self
        self.dataSource = self
        
        self.register(ChangeRecordReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ChangeRecordReusableId")
        
        self.register(ChangeRecordCell.self, forCellWithReuseIdentifier: "ChangeRecordId")
        
        setRefreshEnable()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recordList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let timeModel = recordList[section] as! CandyRecordTimeModel
        return timeModel.arrList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ChangeRecordCell = self.dequeueReusableCell(withReuseIdentifier: "ChangeRecordId", for: indexPath) as! ChangeRecordCell
        let timeModel = recordList[indexPath.section] as! CandyRecordTimeModel
        if recordType == 1 {
            cell.setChangeRecordCell(dataModel: timeModel.arrList![indexPath.row])
        } else {
            cell.setCandyRecordCell(dataModel: timeModel.arrList![indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader){
            let headView : ChangeRecordReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ChangeRecordReusableId", for: indexPath) as! ChangeRecordReusableView
            let timeModel = recordList[indexPath.section] as! CandyRecordTimeModel
            headView.createDateLbl?.text = timeModel.datetime
            reusableview = headView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 48*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 55*PROSIZE)
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
