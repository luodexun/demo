//
//  GameDetailCancelView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GameDetailCancelView: UIView {

    var arrowBtn , moreBtn , cancelBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 0/255.0, alpha: 0.1)
        
        self.layer.cornerRadius = 16*PROSIZE
        self.layer.masksToBounds = true
        
        arrowBtn = UIButton.init(type: .custom)
        arrowBtn?.frame = CGRect.init(x: 0, y: 0, width: 20*PROSIZE, height: self.frame.size.height)
        arrowBtn?.setImage(UIImage.init(named: "ic_game_right"), for: .normal)
        self.addSubview(arrowBtn!)
    
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-20*PROSIZE, height: self.frame.size.height))
        barView.backgroundColor = UIColor.init(white: 0/255.0, alpha: 0.3)
        barView.layer.cornerRadius = 16*PROSIZE
        barView.layer.masksToBounds = true
        self.addSubview(barView)
        
        let line = UIView.init(frame: CGRect.init(x: barView.frame.size.width/2, y: 8*PROSIZE, width: 1, height: 16*PROSIZE))
        line.backgroundColor = UIColor.init(white: 255/255.0, alpha: 0.5)
        barView.addSubview(line)
        
        moreBtn = UIButton.init(type: .custom)
        moreBtn?.frame = CGRect.init(x: 0, y: 0, width: barView.frame.size.width/2, height: barView.frame.size.height)
        moreBtn?.setImage(UIImage.init(named: "ic_game_more"), for: .normal)
        barView.addSubview(moreBtn!)
        
        cancelBtn = UIButton.init(type: .custom)
        cancelBtn?.frame = CGRect.init(x: barView.frame.size.width/2, y: 0, width: barView.frame.size.width/2, height: barView.frame.size.height)
        cancelBtn?.setImage(UIImage.init(named: "ic_game_cancel"), for: .normal)
        barView.addSubview(cancelBtn!)
        
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
