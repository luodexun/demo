//
//  MarketCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MarketCell: UICollectionViewCell {
    
    var companyImageView : UIImageView?
    
    var companyNameLbl , yuanPriceLbl , assetsLbl , dollarPriceLbl , upPrecentLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        companyImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        self.addSubview(companyImageView!)
        
        companyNameLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 7*PROSIZE, width: 70*PROSIZE, height: 20*PROSIZE))
        companyNameLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        companyNameLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(companyNameLbl!)
        
        assetsLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 27*PROSIZE, width: 70*PROSIZE, height: 20*PROSIZE))
        assetsLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        assetsLbl?.textColor = colorWithHex(hex: 0x999999)
        self.addSubview(assetsLbl!)
        
        yuanPriceLbl = UILabel.init(frame: CGRect.init(x: 130*PROSIZE, y: 7*PROSIZE, width: 120*PROSIZE, height: 20*PROSIZE))
        yuanPriceLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        yuanPriceLbl?.textColor = colorWithHex(hex: 0x333333)
        yuanPriceLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(yuanPriceLbl!)
        
        dollarPriceLbl = UILabel.init(frame: CGRect.init(x: 130*PROSIZE, y: 27*PROSIZE, width: 120*PROSIZE, height: 20*PROSIZE))
        dollarPriceLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        dollarPriceLbl?.textColor = colorWithHex(hex: 0x999999)
        dollarPriceLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(dollarPriceLbl!)
        
        upPrecentLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-110*PROSIZE, y: 17*PROSIZE, width: 90*PROSIZE, height: 20*PROSIZE))
        upPrecentLbl?.text = "+1.00%"
        upPrecentLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        upPrecentLbl?.textColor = colorWithHex(hex: 0x01B577)
        upPrecentLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(upPrecentLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 55*PROSIZE, y: 54*PROSIZE, width: SCREEN_WIDE-55*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setMarketCell(dataModel:MarketDataModel) {
        if dataModel.is_hot == 1 {
            self.backgroundColor = colorWithHex(hex: 0xFFFCE8)
        } else {
            self.backgroundColor = UIColor.white
        }
        companyImageView?.dwn_setImageView(urlStr: dataModel.icon_url!, imageName: "")
        companyNameLbl?.text = dataModel.currency!
        assetsLbl?.text = dataModel.market_cap_rmb!
        yuanPriceLbl?.text = "¥"+dataModel.price_rmb!
        dollarPriceLbl?.text = "$"+KeepSomeDecimal(num: dataModel.price_usd!, decimal: 4)
        if dataModel.rise_rmb!.hasPrefix("-") {
            upPrecentLbl?.text = dataModel.rise_rmb!
            upPrecentLbl?.textColor = colorWithHex(hex: 0xFF0000)
        } else {
            upPrecentLbl?.text = "+" + dataModel.rise_rmb!
            upPrecentLbl?.textColor = colorWithHex(hex: 0x00B477)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
