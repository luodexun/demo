//
//  ScanView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ScanView: UIView {

    var scanLine : UIImageView?
    
    var openLightBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let barView = UIView.init(frame: CGRect.init(x: (self.frame.size.width-200*PROSIZE)/2, y: 160*PROSIZE, width: 200*PROSIZE, height: 200*PROSIZE))
        barView.clipsToBounds = true
        self.addSubview(barView)
        
        let barImageView = UIImageView.init(frame: barView.bounds)
        barImageView.image = UIImage.init(named: "ic_scan_bg")
        barImageView.contentMode = UIView.ContentMode.scaleToFill
        barView.addSubview(barImageView)
        
        scanLine = UIImageView.init(frame: CGRect.init(x: 0, y: -6*PROSIZE, width: 200*PROSIZE, height: 6*PROSIZE))
        scanLine?.image = UIImage.init(named: "ic_scan_scanline")
        barView.addSubview(scanLine!)
        
        openLightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        openLightBtn?.frame = CGRect.init(x: (self.frame.size.width-54*PROSIZE)/2, y: barView.frame.origin.y+barView.frame.size.height+10*PROSIZE, width: 54*PROSIZE, height: 54*PROSIZE)
        openLightBtn?.setImage(UIImage.init(named: "ic_scan_open"), for: UIControl.State.normal)
        self.addSubview(openLightBtn!)
        
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
