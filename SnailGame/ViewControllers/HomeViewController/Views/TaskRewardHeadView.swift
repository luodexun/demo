//
//  TaskRewardHeadView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TaskRewardHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 100*PROSIZE))
        bg.image = UIImage.init(named: "ic_task_reward_bg")
        self.addSubview(bg)
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
