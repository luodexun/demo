//
//  TaskRewardCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias TaskRewardBlock = (_ listModel:QuestRewardsListModel) -> Void

class TaskRewardCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource , TaskRewardDelegate {

    var singleList = NSArray.init()
    
    var dateList = NSArray.init()
    
    var taskRewardHandel : TaskRewardBlock?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clear

        self.register(TaskRewardItemCell.self, forCellWithReuseIdentifier: "TaskRewardItemId")
        
        self.register(TaskRewardFootReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TaskRewardFootReusableId")

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TaskRewardItemCell = self.dequeueReusableCell(withReuseIdentifier: "TaskRewardItemId", for: indexPath) as! TaskRewardItemCell
        cell.rewardDelegate = self
        if indexPath.item == 0 {
            cell.setTaskRewardDailyCell(list: dateList)
        } else {
            cell.setTaskRewardSingleCell(list: singleList)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionFooter){
            let footView : TaskRewardFootReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TaskRewardFootReusableId", for: indexPath) as! TaskRewardFootReusableView
            reusableview = footView
        }
        return reusableview!
    }
    
    func taskRewardAction(listModel: QuestRewardsListModel) {
        taskRewardHandel!(listModel)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 30*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: SCREEN_WIDE, height: 70*PROSIZE+CGFloat(dateList.count)*55*PROSIZE)
        }
        return CGSize.init(width: SCREEN_WIDE, height: 70*PROSIZE+CGFloat(singleList.count)*55*PROSIZE)
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
