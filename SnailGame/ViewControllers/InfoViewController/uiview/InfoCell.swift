//
//  InfoCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class InfoCell: UICollectionViewCell {
    
    var infoNameLbl : UILabel?
    
    var timeShowLbl : UILabel?
    
    var infoImageView : UIImageView?
    
    var viewNumLbl : UILabel?
    
    var zanNumLbl : UILabel?
    
    var shareNumLbl : UILabel?
    
    var commentNumLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        infoNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: SCREEN_WIDE-180*PROSIZE, height: 50*PROSIZE))
        infoNameLbl?.numberOfLines = 0
        infoNameLbl?.textColor = colorWithHex(hex: 0x333333)
        infoNameLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        self.addSubview(infoNameLbl!)
        
        timeShowLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (infoNameLbl?.frame.origin.y)!+(infoNameLbl?.frame.size.height)!+8*PROSIZE, width: SCREEN_WIDE-180*PROSIZE, height: 12*PROSIZE))
        timeShowLbl?.textColor = colorWithHex(hex: 0x999999)
        timeShowLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        self.addSubview(timeShowLbl!)
        
        infoImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDE-140*PROSIZE, y: 20*PROSIZE, width: 120*PROSIZE, height: 85*PROSIZE))
        self.addSubview(infoImageView!)
        
        let eyeIcon = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 119*PROSIZE, width: 17*PROSIZE, height: 13*PROSIZE))
        eyeIcon.image = UIImage.init(named: "ic_info_eye")
        self.addSubview(eyeIcon)
        
        viewNumLbl = UILabel.init(frame: CGRect.init(x: 41*PROSIZE, y: 119*PROSIZE, width: 60*PROSIZE, height: 13*PROSIZE))
        viewNumLbl?.textColor = colorWithHex(hex: 0x999999)
        viewNumLbl?.font = UIFont.systemFont(ofSize: 13*PROSIZE)
        self.addSubview(viewNumLbl!)
        
        let zanIcon = UIImageView.init(frame: CGRect.init(x: (viewNumLbl?.frame.origin.x)!+(viewNumLbl?.frame.size.width)!+6*PROSIZE, y: 119*PROSIZE, width: 17*PROSIZE, height: 13*PROSIZE))
        zanIcon.image = UIImage.init(named: "ic_info_zan")
        self.addSubview(zanIcon)
        
        zanNumLbl = UILabel.init(frame: CGRect.init(x: zanIcon.frame.origin.x+zanIcon.frame.size.width+6*PROSIZE, y: 119*PROSIZE, width: 44*PROSIZE, height: 13*PROSIZE))
        zanNumLbl?.textColor = colorWithHex(hex: 0x999999)
        zanNumLbl?.font = UIFont.systemFont(ofSize: 13*PROSIZE)
        self.addSubview(zanNumLbl!)
        
        let shareIcon = UIImageView.init(frame: CGRect.init(x: (zanNumLbl?.frame.origin.x)!+(zanNumLbl?.frame.size.width)!+6*PROSIZE, y: 119*PROSIZE, width: 17*PROSIZE, height: 13*PROSIZE))
        shareIcon.image = UIImage.init(named: "ic_info_share")
        shareIcon.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(shareIcon)
        
        shareNumLbl = UILabel.init(frame: CGRect.init(x: shareIcon.frame.origin.x+shareIcon.frame.size.width+4*PROSIZE, y: 119*PROSIZE, width: 44*PROSIZE, height: 13*PROSIZE))
        shareNumLbl?.textColor = colorWithHex(hex: 0x999999)
        shareNumLbl?.font = UIFont.systemFont(ofSize: 13*PROSIZE)
        self.addSubview(shareNumLbl!)
        
        let commentIcon = UIImageView.init(frame: CGRect.init(x: (shareNumLbl?.frame.origin.x)!+(shareNumLbl?.frame.size.width)!+6*PROSIZE, y: 119*PROSIZE, width: 17*PROSIZE, height: 13*PROSIZE))
        commentIcon.image = UIImage.init(named: "ic_info_msg")
        commentIcon.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(commentIcon)
        
        commentNumLbl = UILabel.init(frame: CGRect.init(x: commentIcon.frame.origin.x+commentIcon.frame.size.width+4*PROSIZE, y: 119*PROSIZE, width: 60*PROSIZE, height: 13*PROSIZE))
        commentNumLbl?.textColor = colorWithHex(hex: 0x999999)
        commentNumLbl?.font = UIFont.systemFont(ofSize: 13*PROSIZE)
        self.addSubview(commentNumLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 145*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setInfoCell(dataModel: InfoDataModel) {
        infoImageView?.dwn_setImageView(urlStr: dataModel.icon!, imageName: "")
        infoNameLbl?.text = dataModel.title
        timeShowLbl?.text = dataModel.cate! + "•" + intervalSinceNow(stamp: dataModel.create_time!)
        viewNumLbl?.text = String(dataModel.view_count!)
        zanNumLbl?.text = String(dataModel.star_count!)
        shareNumLbl?.text = String(dataModel.share_count!)
        commentNumLbl?.text = String(dataModel.comment_count!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
