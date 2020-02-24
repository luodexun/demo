//
//  NoticeListCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias NoticeListBlock = (_ noticeId:Int) -> Void

class NoticeListCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource  {
    
    var noticeList = NSMutableArray.init()
    
    var noticeListHandel : NoticeListBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.register(NoticeListReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NoticeListReusableId")
        
        self.register(NoticeListCell.self, forCellWithReuseIdentifier: "NoticeListId")
        
        setRefreshEnable()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return noticeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let timeModel:NoticeTimeModel = noticeList[section] as! NoticeTimeModel
        return timeModel.list!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NoticeListCell = self.dequeueReusableCell(withReuseIdentifier: "NoticeListId", for: indexPath) as! NoticeListCell
        let timeModel:NoticeTimeModel = noticeList[indexPath.section] as! NoticeTimeModel
        cell.setNoticeListCell(dataModel:timeModel.list![indexPath.item] as! NoticeListModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 55*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader){
            let headView : NoticeListReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoticeListReusableId", for: indexPath) as! NoticeListReusableView
            let timeModel:NoticeTimeModel = noticeList[indexPath.section] as! NoticeTimeModel
            headView.createDateLbl?.text = timeModel.push_time
            reusableview = headView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let timeModel:NoticeTimeModel = noticeList[indexPath.section] as! NoticeTimeModel
        let listModel:NoticeListModel = timeModel.list![indexPath.item] as! NoticeListModel
        noticeListHandel!(listModel.id!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 48*PROSIZE)
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
