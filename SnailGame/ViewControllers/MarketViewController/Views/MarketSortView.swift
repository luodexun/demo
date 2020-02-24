//
//  MarketSortView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias marketSortBlock = (_ key:String,_ value:String) -> Void

class MarketSortView: UIView {
    
    var capImageView , priceImageView , upImageView : UIImageView?
    
    var capSelect , priceSelect , upSelect : String?
    
    
    var marketSortHandel : marketSortBlock?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        let capSize = NSString.calStrSize(textStr: "名称/市值", height: 35*PROSIZE, fontSize: 14*PROSIZE)
        let capLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE/6 - (capSize.width+15*PROSIZE)/2, y: 0, width: capSize.width, height: 35*PROSIZE))
        capLbl.textColor = colorWithHex(hex: 0x999999)
        capLbl.text = "名称/市值"
        capLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        self.addSubview(capLbl)
        
        capImageView = UIImageView.init(frame: CGRect.init(x: capLbl.frame.origin.x+capLbl.frame.size.width+6*PROSIZE, y: 12*PROSIZE, width: 9*PROSIZE, height: 12*PROSIZE))
        capImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
        self.addSubview(capImageView!)
        
        let priceSize = NSString.calStrSize(textStr: "价格", height: 35*PROSIZE, fontSize: 14*PROSIZE)
        let priceLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE/2-(priceSize.width+15*PROSIZE)/2, y: 0, width: priceSize.width, height: 35*PROSIZE))
        priceLbl.textColor = colorWithHex(hex: 0x999999)
        priceLbl.text = "价格"
        priceLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        self.addSubview(priceLbl)
        
        priceImageView = UIImageView.init(frame: CGRect.init(x: priceLbl.frame.origin.x+priceLbl.frame.size.width+6*PROSIZE, y: 12*PROSIZE, width: 9*PROSIZE, height: 12*PROSIZE))
        priceImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
        self.addSubview(priceImageView!)
        
        let upSize = NSString.calStrSize(textStr: "24H涨幅", height: 35*PROSIZE, fontSize: 14*PROSIZE)
        let upLbl = UILabel.init(frame: CGRect.init(x: 5*SCREEN_WIDE/6-(upSize.width+15*PROSIZE)/2, y: 0, width: upSize.width, height: 35*PROSIZE))
        upLbl.textColor = colorWithHex(hex: 0x999999)
        upLbl.text = "24H涨幅"
        upLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        self.addSubview(upLbl)
        
        upImageView = UIImageView.init(frame: CGRect.init(x: upLbl.frame.origin.x+upLbl.frame.size.width+6*PROSIZE, y: 12*PROSIZE, width: 9*PROSIZE, height: 12*PROSIZE))
        upImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
        self.addSubview(upImageView!)
        
        for index in 0...2 {
            let tabBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
            tabBtn.frame = CGRect.init(x: CGFloat(index) * SCREEN_WIDE / 3, y: 0, width: SCREEN_WIDE / 3, height: 35*PROSIZE)
            tabBtn.tag = 5000+index
            tabBtn.addTarget(self, action: #selector(tabAction), for: UIControl.Event.touchUpInside)
            self.addSubview(tabBtn)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tabAction(sender:UIButton) {
        
        var key : String = ""
        var value : String = ""
        
        if sender.tag == 5000 {
            
            if capSelect == "2" {
                key = "asc"
                capSelect = "1"
                capImageView?.image = UIImage.init(named: "ic_market_sort_up")
            } else {
                key = "desc"
                capSelect = "2"
                capImageView?.image = UIImage.init(named: "ic_market_sort_down")
            }

            value = "market_cap_usd"
            priceSelect = "0"
            upSelect = "0"
            priceImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
            upImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
            
        } else if sender.tag == 5001 {
            
            if priceSelect == "2" {
                key = "asc"
                priceSelect = "1"
                priceImageView?.image = UIImage.init(named: "ic_market_sort_up")
            } else {
                key = "desc"
                priceSelect = "2"
                priceImageView?.image = UIImage.init(named: "ic_market_sort_down")
            }
            
            value = "price_usd"
            capSelect = "0"
            upSelect = "0"
            capImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
            upImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
            
        } else {
            if upSelect == "2" {
                key = "asc"
                upSelect = "1"
                upImageView?.image = UIImage.init(named: "ic_market_sort_up")
            } else {
                key = "desc"
                upSelect = "2"
                upImageView?.image = UIImage.init(named: "ic_market_sort_down")
            }
            value = "rise_usd"
            capSelect = "0"
            priceSelect = "0"
            capImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
            priceImageView?.image = UIImage.init(named: "ic_market_sort_nomal")
        }
        
        self.marketSortHandel!(key,value)
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
