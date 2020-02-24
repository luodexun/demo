//
//  BaseTabBar.swift
//  SnailGame
//
//  Created by Edison on 2019/12/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class BaseTabBar: UITabBar {
    
    var budgeView , hongBarView : UIView?
    
    var redImageView : UIImageView?
    
    var countTimer :Timer?
    
    var currentCount = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.white

        budgeView = UIView.init(frame: CGRect.init(x: SCREEN_WIDE-26*PROSIZE, y: 5, width: 8, height: 8))
        budgeView?.backgroundColor = colorWithHex(hex: 0xFF0000)
        budgeView?.isHidden = true
        budgeView?.layer.cornerRadius = 4
        budgeView?.layer.masksToBounds = true
        self.addSubview(budgeView!)
        
//        let filePath = Bundle.main.path(forResource: "hong", ofType: "gif")
//        let data = NSData.init(contentsOfFile: filePath!)
//        redImageView = UIImageView.init(frame: CGRect.init(x: 7*SCREEN_WIDE/10-20, y: 5, width: 40, height: 40))
//        redImageView?.image = UIImage.sd_image(withGIFData: data as Data?)
//        self.addSubview(redImageView!)
        
        hongBarView = UIView.init(frame: CGRect.init(x: 7*SCREEN_WIDE/10-20, y: 5, width: 40, height: 40))
        hongBarView?.backgroundColor = UIColor.white
        hongBarView?.layer.cornerRadius = 20
        hongBarView?.layer.masksToBounds = true
        self.addSubview(hongBarView!)

        let filePath = Bundle.main.path(forResource: "lihua", ofType: "gif")
        let data = NSData.init(contentsOfFile: filePath!)

        let flower = UIImageView.init(frame: hongBarView!.bounds)
        flower.image = UIImage.sd_image(withGIFData: data as Data?)
        hongBarView!.addSubview(flower)
                
        redImageView = UIImageView.init(frame: CGRect.init(x: 9, y: 10, width: 22, height: 25))
        redImageView?.image = UIImage.init(named: "ic_hong_red")
        hongBarView!.addSubview(redImageView!)
        
        countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countUpAction), userInfo: nil, repeats: true)
        countTimer!.fire()
        
    }
    
    @objc func countUpAction(timer:Timer) {
        if currentCount%3 == 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.redImageView?.frame.origin.y = 30
            }, completion: { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.redImageView?.frame.origin.y = 10
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.redImageView?.frame.origin.y = 30
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.25, animations: {
                            self.redImageView?.frame.origin.y = 5
                        }, completion: { (_) in
                            
                            UIView.animate(withDuration: 0.05, animations: {
                                self.redImageView?.frame.origin.y = 10
                            })
                        })
                    })
                })
            })
        }
        currentCount += 1
    }

    required init?(coder: NSCoder) {
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
