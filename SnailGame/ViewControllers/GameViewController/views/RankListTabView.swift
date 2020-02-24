//
//  RankListTabView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias RankListTabBlock = (_ tagIndex:Int) -> Void

class RankListTabView: UIView {
    
    var titleList : NSArray?
    
    var tabLine : UIView?
    
    var rankListTabHandel : RankListTabBlock?
    
    init(frame: CGRect,list:NSArray) {
        super.init(frame: frame)
        
        titleList = list
        for (i,item) in list.enumerated() { 
            let tab = UIButton.init(type: UIButton.ButtonType.roundedRect)
            tab.frame = CGRect.init(x: CGFloat(i) * 74 * PROSIZE + (self.frame.size.width - 74 * PROSIZE * CGFloat(list.count)) / 2, y: 0, width: 74 * PROSIZE, height: 44*PROSIZE)
            tab.setTitle(item as? String, for: UIControl.State.normal)
            tab.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
            tab.tag = 4000 + i
            if i == 0 {
                tab.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
            } else {
                tab.setTitleColor(colorWithHex(hex: 0x333333), for: UIControl.State.normal)
            }
            tab.addTarget(self, action: #selector(tabSelectAction), for: UIControl.Event.touchUpInside)
            self.addSubview(tab)
        }
        
        let fstTab = self.viewWithTag(4000)
        tabLine = UIView.init(frame: CGRect.init(x: 0, y: 42*PROSIZE, width: 50*PROSIZE, height: 2*PROSIZE))
        tabLine?.center.x = (fstTab?.center.x)!
        tabLine?.backgroundColor = colorWithHex(hex: 0x0077FF)
        self.addSubview(tabLine!)
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 44*PROSIZE, width: self.frame.size.width, height: 30*PROSIZE))
        barView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        self.addSubview(barView)
        
        let rankTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0*PROSIZE, width: 60*PROSIZE, height: barView.frame.size.height))
        rankTitleLbl.text = "名次"
        rankTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        rankTitleLbl.textColor = colorWithHex(hex: 0x999999)
        barView.addSubview(rankTitleLbl)
        
        let nickTitleLbl = UILabel.init(frame: CGRect.init(x: 80*PROSIZE, y: 0*PROSIZE, width: 60*PROSIZE, height: barView.frame.size.height))
        nickTitleLbl.text = "昵称"
        nickTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        nickTitleLbl.textColor = colorWithHex(hex: 0x999999)
        barView.addSubview(nickTitleLbl)
        
        let walletTitleLbl = UILabel.init(frame: CGRect.init(x: 240*PROSIZE, y: 0*PROSIZE, width: 60*PROSIZE, height: barView.frame.size.height))
        walletTitleLbl.text = "奖励"
        walletTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        walletTitleLbl.textColor = colorWithHex(hex: 0x999999)
        barView.addSubview(walletTitleLbl)
        
        let integralTitleLbl = UILabel.init(frame: CGRect.init(x: barView.frame.size.width-70*PROSIZE, y: 0*PROSIZE, width: 50*PROSIZE, height: barView.frame.size.height))
        integralTitleLbl.text = "积分"
        integralTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        integralTitleLbl.textColor = colorWithHex(hex: 0x999999)
        integralTitleLbl.textAlignment = NSTextAlignment.right
        barView.addSubview(integralTitleLbl)
        
    }
    
    @objc func tabSelectAction(sender:UIButton) {
        for (i,_) in titleList!.enumerated() {
            let tab : UIButton = self.viewWithTag(4000+i) as! UIButton
            tab.setTitleColor(colorWithHex(hex: 0x333333), for: UIControl.State.normal)
        }
        sender.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        UIView.animate(withDuration: 0.3) {
            self.tabLine?.center.x = sender.center.x
        }
        rankListTabHandel!(sender.tag-4000)
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
