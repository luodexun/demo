//
//  TaskRewardCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TaskRewardCell: UICollectionViewCell {
    
    var questNameLbl , taskNumLbl , rewardDwnLbl , questStateLbl : UILabel?
    
    var line : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        questNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: 64*PROSIZE, height: 14*PROSIZE))
        questNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        questNameLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(questNameLbl!)
        
        taskNumLbl = UILabel.init(frame: CGRect.init(x: questNameLbl!.frame.origin.x+questNameLbl!.frame.size.width+10*PROSIZE, y: 20*PROSIZE, width: 40*PROSIZE, height: 14*PROSIZE))
        taskNumLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        taskNumLbl?.textColor = colorWithHex(hex: 0xFF4848)
        self.addSubview(taskNumLbl!)
        
        rewardDwnLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-135*PROSIZE, y: 20*PROSIZE, width: 50*PROSIZE, height: 14*PROSIZE))
        rewardDwnLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rewardDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        rewardDwnLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(rewardDwnLbl!)
        
        questStateLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-75*PROSIZE, y: 12*PROSIZE, width: 55*PROSIZE, height: 30*PROSIZE))
        questStateLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        questStateLbl?.textColor = colorWithHex(hex: 0x0077FF)
        questStateLbl?.textAlignment = NSTextAlignment.center
        questStateLbl?.backgroundColor = UIColor.white
        questStateLbl?.layer.borderWidth = 1
        questStateLbl?.layer.borderColor = colorWithHex(hex: 0x0077FF).cgColor
        questStateLbl?.layer.cornerRadius = 5
        questStateLbl?.layer.masksToBounds = true
        self.addSubview(questStateLbl!)
        
        line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 54*PROSIZE, width: self.frame.size.width-40*PROSIZE, height: 1))
        line?.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line!)
        
    }
    
    func setTaskRewardCell(listModel:QuestRewardsListModel) {
        let nameSize = NSString.calStrSize(textStr: listModel.name! as NSString, height: 14*PROSIZE, fontSize: 15*PROSIZE)
        questNameLbl?.frame.size.width = nameSize.width
        questNameLbl?.text = listModel.name
        if listModel.repetition != 0 {
            taskNumLbl?.isHidden = false
            taskNumLbl?.frame.origin.x = questNameLbl!.frame.origin.x+questNameLbl!.frame.size.width+10*PROSIZE
            taskNumLbl?.text = listModel.schedule
        } else {
            taskNumLbl?.isHidden = true
        }
        rewardDwnLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: listModel.count!, b: TOKEN_RATIO), decimal: 2)
        if listModel.draw == 0 {
            questStateLbl?.text = "领奖励"
            questStateLbl?.textColor = UIColor.white
            questStateLbl?.backgroundColor = colorWithHex(hex: 0x0077FF)
            questStateLbl?.layer.borderColor = colorWithHex(hex: 0x0077FF).cgColor
        } else if listModel.draw == 1 {
            questStateLbl?.text = "已领取"
            questStateLbl?.textColor = colorWithHex(hex: 0x333333)
            questStateLbl?.backgroundColor = UIColor.white
            questStateLbl?.layer.borderColor = UIColor.white.cgColor
        } else {
            questStateLbl?.text = "做任务"
            questStateLbl?.textColor = colorWithHex(hex: 0x0077FF)
            questStateLbl?.backgroundColor = UIColor.white
            questStateLbl?.layer.borderColor = colorWithHex(hex: 0x0077FF).cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
