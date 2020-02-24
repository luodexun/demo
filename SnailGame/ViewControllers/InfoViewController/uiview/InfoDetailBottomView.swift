//
//  InfoDetailBottomView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class InfoDetailBottomView: UIView {
    
    var zanImageView : UIImageView?
    
    var zanTitleLbl : UILabel?
    
    var zanPushBtn , sharePushBtn , commentPushBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        zanImageView = UIImageView.init(frame: CGRect.init(x: 38*PROSIZE, y: 12*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        zanImageView?.image = UIImage.init(named: "ic_info_detail_zan_no")
        self.addSubview(zanImageView!)
        
        zanTitleLbl = UILabel.init(frame: CGRect.init(x: (zanImageView?.frame.origin.x)!+(zanImageView?.frame.size.width)!+4*PROSIZE, y: 12*PROSIZE, width: 60*PROSIZE, height: 25*PROSIZE))
        zanTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        zanTitleLbl?.textColor = colorWithHex(hex: 0xaaaaaa)
        zanTitleLbl?.text = "赞"
        self.addSubview(zanTitleLbl!)
        
        let shareImageView = UIImageView.init(frame: CGRect.init(x: 163*PROSIZE, y: 12*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        shareImageView.image = UIImage.init(named: "ic_info_detail_share")
        self.addSubview(shareImageView)
        
        let shareTitleLbl = UILabel.init(frame: CGRect.init(x: shareImageView.frame.origin.x+shareImageView.frame.size.width+4*PROSIZE, y: 12*PROSIZE, width: 60*PROSIZE, height: 25*PROSIZE))
        shareTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        shareTitleLbl.textColor = colorWithHex(hex: 0xaaaaaa)
        shareTitleLbl.text = "分享"
        self.addSubview(shareTitleLbl)
        
        let commentImageView = UIImageView.init(frame: CGRect.init(x: 288*PROSIZE, y: 12*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        commentImageView.image = UIImage.init(named: "ic_info_detail_comment")
        self.addSubview(commentImageView)
        
        let commentTitleLbl = UILabel.init(frame: CGRect.init(x: commentImageView.frame.origin.x+commentImageView.frame.size.width+4*PROSIZE, y: 12*PROSIZE, width: 60*PROSIZE, height: 25*PROSIZE))
        commentTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        commentTitleLbl.textColor = colorWithHex(hex: 0xaaaaaa)
        commentTitleLbl.text = "评论"
        self.addSubview(commentTitleLbl)
        
        zanPushBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        zanPushBtn?.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width/3, height: self.frame.size.height)
        self.addSubview(zanPushBtn!)
        
        sharePushBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        sharePushBtn?.frame = CGRect.init(x: self.frame.size.width/3, y: 0, width: self.frame.size.width/3, height: self.frame.size.height)
        self.addSubview(sharePushBtn!)
        
        commentPushBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        commentPushBtn?.frame = CGRect.init(x: 2 * self.frame.size.width/3, y: 0, width: self.frame.size.width/3, height: self.frame.size.height)
        self.addSubview(commentPushBtn!)
        
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
