//
//  MineNomalCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineNomalCell: UICollectionViewCell {
    
    var iconView : UIImageView?
    
    var titleNameLbl : UILabel?
    
    var contentDescLbl : UILabel?
    
    var bottomLine : UIView?
    
    var promoteBarView : MinePromoteView?
    
    var budgeNumLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        iconView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        iconView?.image = UIImage.init(named: "ic_mine_promote")
        self.addSubview(iconView!)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 55*PROSIZE, y: 18*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        titleNameLbl?.text = "推广奖励";
        titleNameLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(titleNameLbl!)
        
        contentDescLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-180*PROSIZE, y: 18*PROSIZE, width: 132*PROSIZE, height: 20*PROSIZE))
        contentDescLbl?.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        contentDescLbl?.textColor = colorWithHex(hex: 0xF575A2)
        contentDescLbl?.text = "超多DWN等你赚";
        contentDescLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(contentDescLbl!)
        
        promoteBarView = MinePromoteView.init(frame: CGRect.init(x: SCREEN_WIDE-173*PROSIZE, y: 9*PROSIZE, width: 125*PROSIZE, height: 37*PROSIZE))
        promoteBarView?.isHidden = true
        self.addSubview(promoteBarView!)
        
        budgeNumLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-68*PROSIZE, y: 18*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE))
        budgeNumLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        budgeNumLbl?.textColor = UIColor.white
        budgeNumLbl?.isHidden = true
        budgeNumLbl?.textAlignment = NSTextAlignment.center
        budgeNumLbl?.backgroundColor = colorWithHex(hex: 0xFF0000)
        budgeNumLbl?.layer.cornerRadius = 10*PROSIZE
        budgeNumLbl?.layer.masksToBounds = true
        self.addSubview(budgeNumLbl!)

        let nextIcon = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-28*PROSIZE, y: 21*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        nextIcon.image = UIImage.init(named: "ic_mine_next")
        self.addSubview(nextIcon)
        
        bottomLine = UIView.init(frame: CGRect.init(x: 55*PROSIZE, y: 54*PROSIZE, width: SCREEN_WIDE-55*PROSIZE, height: 1*PROSIZE))
        bottomLine?.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(bottomLine!)
    }
    
    func setMineNomalCell(showModel:MineShowModel) {
        iconView?.image = UIImage.init(named: showModel.imageStr!)
        titleNameLbl?.text = showModel.titleName
        
        if showModel.operaType == 1 {
            if showModel.contentStr?.count != 0 {
                promoteBarView?.isHidden = false
                promoteBarView?.promoteCodeLbl?.text = showModel.contentStr
            } else {
                promoteBarView?.isHidden = true
            }
            contentDescLbl?.isHidden = true
        }else{
            promoteBarView?.isHidden = true
            contentDescLbl?.isHidden = false
        }
    
        if showModel.operaType == 8{
            if showModel.contentStr?.count != 0 {
                budgeNumLbl?.isHidden = false
                let numSize : CGSize = NSString.calStrSize(textStr: showModel.contentStr! as NSString, height: 20*PROSIZE, fontSize: 10*PROSIZE)
                budgeNumLbl?.frame = CGRect.init(x: SCREEN_WIDE-64*PROSIZE-numSize.width, y: 18*PROSIZE, width: numSize.width+16*PROSIZE, height: 20*PROSIZE)
                budgeNumLbl?.text = showModel.contentStr
                
            } else {
                budgeNumLbl?.isHidden = true
            }
            contentDescLbl?.isHidden = true
        }else{
            budgeNumLbl?.isHidden = true
            contentDescLbl?.isHidden = false
        }
        
        if showModel.operaType == 2 || showModel.operaType == 5 || showModel.operaType == 7 || showModel.operaType == 9 || showModel.operaType == 10 {
            bottomLine?.backgroundColor = UIColor.white
        } else {
            bottomLine?.backgroundColor = colorWithHex(hex: 0xeeeeee)
        }
        
        if showModel.operaType == 2{
            contentDescLbl?.textColor = colorWithHex(hex: 0xF575A2)
        }else{
            contentDescLbl?.textColor = colorWithHex(hex: 0xcccccc)
        }
        
        contentDescLbl?.text = showModel.contentStr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
