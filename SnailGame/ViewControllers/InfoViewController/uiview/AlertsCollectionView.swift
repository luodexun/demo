//
//  AlertsCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AlertsCollectionView: BaseCollectionView ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var alertList = NSMutableArray.init()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        setRefreshEnable()
        
        self.register(AlertsCell.self, forCellWithReuseIdentifier: "AlertsCellId")
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alertList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AlertsCell = self.dequeueReusableCell(withReuseIdentifier: "AlertsCellId", for: indexPath) as! AlertsCell
        cell.setAlertsCell(dataModel: alertList[indexPath.item] as! AlertsDataModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dataModel:AlertsDataModel = alertList[indexPath.item] as! AlertsDataModel
        
        let titleSize = NSString.calStrSize(textStr: dataModel.title! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 18*PROSIZE)
        
        let contentSize = NSString.calStrSize(textStr: dataModel.details! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 14*PROSIZE)
        
        return CGSize.init(width: SCREEN_WIDE, height: 100*PROSIZE+titleSize.height+contentSize.height)
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
