//
//  TaskRewardReusableView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TaskRewardReusableView: UICollectionReusableView {
    
    var titleNameLbl , dwnTitleLbl : UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 10*PROSIZE, y: 10*PROSIZE, width: SCREEN_WIDE-20*PROSIZE, height: 55*PROSIZE))
        barView.backgroundColor = UIColor.white
        let maskBezier = UIBezierPath.init(roundedRect: barView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize.init(width: 10, height: 10))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = barView.bounds
        maskLayer.path = maskBezier.cgPath
        barView.layer.mask = maskLayer
        self.addSubview(barView)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: 200*PROSIZE, height: 30*PROSIZE))
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl?.textColor = colorWithHex(hex: 0xFF4342)
        titleNameLbl?.text = "每日任务"
        barView.addSubview(titleNameLbl!)
        
        let taskBarView = UIView.init(frame: CGRect.init(x: 0, y: 30*PROSIZE, width: barView.frame.size.width, height: 25*PROSIZE))
        taskBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        barView.addSubview(taskBarView)
        
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
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
