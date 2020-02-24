//
//  TaskRewardItemCell.swift
//  SnailGame
//
//  Created by Edison on 2020/1/7.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

protocol TaskRewardDelegate {
    func taskRewardAction(listModel:QuestRewardsListModel)
}

class TaskRewardItemCell: UICollectionViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var barView : UIView?
    
    var titleNameLbl , dwnTitleLbl : UILabel?
    
    var taskCV : UICollectionView?
    
    var arrData : NSArray?
    
    var rewardDelegate : TaskRewardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        barView = UIView.init(frame: CGRect.init(x: 10*PROSIZE, y: 10*PROSIZE, width: SCREEN_WIDE-20*PROSIZE, height: 60*PROSIZE))
        barView?.backgroundColor = UIColor.white
        barView?.layer.cornerRadius = 10*PROSIZE
        barView?.layer.masksToBounds = true
        self.addSubview(barView!)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: 200*PROSIZE, height: 30*PROSIZE))
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl?.textColor = colorWithHex(hex: 0xFF4342)
        barView!.addSubview(titleNameLbl!)
        
        let taskBarView = UIView.init(frame: CGRect.init(x: 0, y: 30*PROSIZE, width: barView!.frame.size.width, height: 25*PROSIZE))
        taskBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        barView!.addSubview(taskBarView)
        
        let taskTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: 40*PROSIZE, height: taskBarView.frame.size.height))
        taskTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        taskTitleLbl.textColor = colorWithHex(hex: 0x999999)
        taskTitleLbl.text = "任务"
        taskBarView.addSubview(taskTitleLbl)
        
        dwnTitleLbl = UILabel.init(frame: CGRect.init(x: taskBarView.frame.size.width - 186*PROSIZE, y: 0, width: 100*PROSIZE, height: taskBarView.frame.size.height))
        dwnTitleLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        dwnTitleLbl?.textColor = colorWithHex(hex: 0x999999)
        dwnTitleLbl?.textAlignment = NSTextAlignment.right
        taskBarView.addSubview(dwnTitleLbl!)
        
        let stateTitleLbl = UILabel.init(frame: CGRect.init(x: taskBarView.frame.size.width - 75*PROSIZE, y: 0, width: 55*PROSIZE, height: taskBarView.frame.size.height))
        stateTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        stateTitleLbl.textColor = colorWithHex(hex: 0x999999)
        stateTitleLbl.text = "状态"
        stateTitleLbl.textAlignment = NSTextAlignment.center
        taskBarView.addSubview(stateTitleLbl)
        
        let layout = UICollectionViewFlowLayout.init()
        taskCV = UICollectionView.init(frame: CGRect.init(x: 0, y: 55*PROSIZE, width: barView!.frame.size.width, height: 0), collectionViewLayout: layout)
        taskCV?.delegate = self
        taskCV?.dataSource = self
        taskCV?.backgroundColor = UIColor.white
        barView!.addSubview(taskCV!)
        
        taskCV?.register(TaskRewardCell.self, forCellWithReuseIdentifier: "TaskRewardId")
    }
    
    func setTaskRewardDailyCell(list:NSArray) {
        titleNameLbl?.text = "每日任务"
        dwnTitleLbl?.text = "奖励糖果"
        barView?.frame.size.height = 55*PROSIZE*CGFloat(list.count) + 60*PROSIZE
        taskCV?.frame.size.height = 55*PROSIZE*CGFloat(list.count)
        taskCV?.reloadData()
        arrData = list
        
    }
    
    func setTaskRewardSingleCell(list:NSArray) {
        titleNameLbl?.text = "单次任务"
        dwnTitleLbl?.text = "奖励DWN"
        barView?.frame.size.height = 55*PROSIZE*CGFloat(list.count) + 60*PROSIZE
        taskCV?.frame.size.height = 55*PROSIZE*CGFloat(list.count)
        taskCV?.reloadData()
        arrData = list
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TaskRewardCell = taskCV?.dequeueReusableCell(withReuseIdentifier: "TaskRewardId", for: indexPath) as! TaskRewardCell
        cell.setTaskRewardCell(listModel: arrData![indexPath.item] as! QuestRewardsListModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: barView!.frame.size.width, height: 55*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rewardDelegate?.taskRewardAction(listModel: arrData![indexPath.item] as! QuestRewardsListModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
