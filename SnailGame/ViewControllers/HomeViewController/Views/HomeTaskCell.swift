//
//  HomeTaskCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol HomeTaskPushDelegate {
    func homeTaskPushAction(opera:Int)
}

class HomeTaskCell: UICollectionViewCell {
    
    var dailyClockView , pointsExchangeView , taskRewardView : RewardItemView?
    
    var taskDelegate : HomeTaskPushDelegate?
    
    var dailyClockBtn , alertsBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let taskTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 30*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 17*PROSIZE))
        taskTitleLbl.text = "活动奖励"
        taskTitleLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        taskTitleLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(taskTitleLbl)
        
        dailyClockBtn = UIButton.init(type: .custom)
        dailyClockBtn?.frame = CGRect.init(x: 20*PROSIZE, y: 66*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 115*PROSIZE)
        dailyClockBtn?.setBackgroundImage(UIImage.init(named: "icon_home_daily_banner"), for: .normal)
        dailyClockBtn?.addTarget(self, action: #selector(rewardPushAction), for: .touchUpInside)
        dailyClockBtn?.tag = 2001
        self.addSubview(dailyClockBtn!)
        
        dailyClockView = RewardItemView.init(frame: CGRect.init(x: 20*PROSIZE, y: 66*PROSIZE, width: 105*PROSIZE, height: 100*PROSIZE))
        dailyClockView?.isHidden = true
        dailyClockView?.backgroundColor = colorWithHex(hex: 0xF3EFE9)
        dailyClockView?.titleImageView?.image = UIImage.init(named: "ic_home_daily_clock")
        dailyClockView?.titleNameLbl?.text = "每日打卡"
        dailyClockView?.subtitleNameLbl?.text = "价值兑现"
        dailyClockView?.itemPushBtn?.tag = 2001
        dailyClockView?.itemPushBtn?.addTarget(self, action: #selector(rewardPushAction), for: UIControl.Event.touchUpInside)
        self.addSubview(dailyClockView!)
        
        pointsExchangeView = RewardItemView.init(frame: CGRect.init(x: 135*PROSIZE, y: 66*PROSIZE, width: 105*PROSIZE, height: 100*PROSIZE))
        pointsExchangeView?.isHidden = true
        pointsExchangeView?.backgroundColor = colorWithHex(hex: 0xE4ECF3)
        pointsExchangeView?.titleImageView?.image = UIImage.init(named: "ic_home_recommend_reward")
        pointsExchangeView?.titleNameLbl?.text = "推广奖励"
        pointsExchangeView?.subtitleNameLbl?.text = "影响力"
        pointsExchangeView?.itemPushBtn?.tag = 2002
        pointsExchangeView?.itemPushBtn?.addTarget(self, action: #selector(rewardPushAction), for: UIControl.Event.touchUpInside)
        self.addSubview(pointsExchangeView!)
        
        taskRewardView = RewardItemView.init(frame: CGRect.init(x: 250*PROSIZE, y: 66*PROSIZE, width: 105*PROSIZE, height: 100*PROSIZE))
        taskRewardView?.isHidden = true
        taskRewardView?.backgroundColor = colorWithHex(hex: 0xF4E9F1)
        taskRewardView?.titleImageView?.image = UIImage.init(named: "ic_home_task_reward")
        taskRewardView?.titleNameLbl?.text = "任务奖励"
        taskRewardView?.subtitleNameLbl?.text = "高效获益"
        taskRewardView?.itemPushBtn?.tag = 2003
        taskRewardView?.itemPushBtn?.addTarget(self, action: #selector(rewardPushAction), for: UIControl.Event.touchUpInside)
        self.addSubview(taskRewardView!)
        
        alertsBtn = UIButton.init(type: UIButton.ButtonType.custom)
        alertsBtn?.frame = CGRect.init(x: 20*PROSIZE, y: 177*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 70*PROSIZE)
        alertsBtn?.setBackgroundImage(UIImage.init(named: "ic_home_snail_alerts"), for: UIControl.State.normal)
        alertsBtn?.isHidden = true
        alertsBtn?.addTarget(self, action: #selector(alertsAction), for: UIControl.Event.touchUpInside)
        self.addSubview(alertsBtn!)

    }
    
    func setHomeTaskCell(isService:Int) {
        if isService != 0 {
            dailyClockBtn?.isHidden = true
            dailyClockView?.isHidden = false
            taskRewardView?.isHidden = false
            pointsExchangeView?.isHidden = false
            alertsBtn?.isHidden = false
        } else {
            dailyClockBtn?.isHidden = false
            dailyClockView?.isHidden = true
            taskRewardView?.isHidden = true
            pointsExchangeView?.isHidden = true
            alertsBtn?.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rewardPushAction(sender:UIButton) {
        taskDelegate?.homeTaskPushAction(opera: sender.tag-2000)
    }
    
    @objc func alertsAction(sender:UIButton) {
        taskDelegate?.homeTaskPushAction(opera: 4)
    }
    
    
}
