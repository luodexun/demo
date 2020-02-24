//
//  LuckyDropScrollView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class LuckyDropScrollView: UIScrollView {
    
    var titleNameLbl , lessDwnLbl , totalDwnLbl , endDateLbl , getNumLbl : UILabel?
    
    var getLuckyBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 293*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 238*PROSIZE))
        self.addSubview(barView)
        
        let barIcon = UIImageView.init(frame: barView.bounds)
        barIcon.image = UIImage.init(named: "ic_lucky_drop_box")
        barView.addSubview(barIcon)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 56*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 15*PROSIZE))
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl?.textColor = colorWithHex(hex: 0xFF7700)
        titleNameLbl?.textAlignment = .center
        barView.addSubview(titleNameLbl!)
        
        lessDwnLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: titleNameLbl!.frame.origin.y+titleNameLbl!.frame.size.height+9*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 40*PROSIZE))
        lessDwnLbl?.font = UIFont.systemFont(ofSize: 38*PROSIZE)
        lessDwnLbl?.textColor = colorWithHex(hex: 0xFE5B00)
        lessDwnLbl?.textAlignment = .center
        barView.addSubview(lessDwnLbl!)
        
        totalDwnLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: lessDwnLbl!.frame.origin.y+lessDwnLbl!.frame.size.height+14*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 12*PROSIZE))
        totalDwnLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        totalDwnLbl?.textColor = colorWithHex(hex: 0xFF7700)
        totalDwnLbl?.textAlignment = .center
        barView.addSubview(totalDwnLbl!)
        
        getLuckyBtn = UIButton.init(type: .roundedRect)
        getLuckyBtn?.frame = CGRect.init(x: 20*PROSIZE, y: totalDwnLbl!.frame.origin.y+totalDwnLbl!.frame.size.height+16*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 40*PROSIZE)
        getLuckyBtn?.backgroundColor = colorWithHex(hex: 0xFF7700)
        getLuckyBtn?.setTitle("领取今日幸运", for: .normal)
        getLuckyBtn?.setTitleColor(UIColor.white, for: .normal)
        getLuckyBtn?.layer.cornerRadius = 20*PROSIZE
        getLuckyBtn?.layer.masksToBounds = true
        barView.addSubview(getLuckyBtn!)
        
        getNumLbl = UILabel.init(frame: CGRect.init(x: (SCREEN_WIDE-180*PROSIZE)/2, y: barView.frame.origin.y+barView.frame.size.height+14*PROSIZE, width: 180*PROSIZE, height: 24*PROSIZE))
        getNumLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        getNumLbl?.backgroundColor = colorWithHex(hex: 0xFF9F40)
        getNumLbl?.textColor = UIColor.white
        getNumLbl?.textAlignment = .center
        getNumLbl?.layer.cornerRadius = 2
        getNumLbl?.layer.masksToBounds = true
        self.addSubview(getNumLbl!)
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        
        let dropDescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: getNumLbl!.frame.origin.y+getNumLbl!.frame.size.height+40*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 28*PROSIZE))
        dropDescLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        dropDescLbl.textColor = UIColor.white
        dropDescLbl.numberOfLines = 0
        dropDescLbl.lineBreakMode = .byWordWrapping
        self.addSubview(dropDescLbl)
        
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: configModel!.luck_rule!)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, configModel!.luck_rule!.count))
        dropDescLbl.attributedText = attributedString
        dropDescLbl.sizeToFit()
        
        self.contentSize = CGSize.init(width: SCREEN_WIDE, height: dropDescLbl.frame.origin.y+dropDescLbl.frame.size.height+20*PROSIZE)

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
