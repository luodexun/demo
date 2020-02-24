//
//  VipRightDialog.swift
//  SnailGame
//
//  Created by Edison on 2019/10/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class VipRightDialog: UIView {
    
    var coverView , whiteView : UIView?
    
    var whiteViewStartFrame: CGRect = CGRect.init(x: 20*PROSIZE, y: -570*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 570*PROSIZE)
    
    var model : VipInfoDetailModel?
    
    init(detailModel:VipInfoDetailModel) {
        super.init(frame: UIScreen.main.bounds)
        setupView(detailModel: detailModel)
    }
    
    func setupView(detailModel:VipInfoDetailModel) {
        
        coverView = UIView.init(frame: self.bounds)
        coverView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        addSubview(coverView!)
        
        let coverTap = UITapGestureRecognizer.init(target: self, action: #selector(coverClose))
        coverView?.addGestureRecognizer(coverTap)
        
        whiteView = UIView.init(frame: whiteViewStartFrame)
        whiteView?.backgroundColor = UIColor.white
        whiteView?.layer.masksToBounds = true
        whiteView?.layer.cornerRadius = 5
        self.addSubview(whiteView!)
        
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: (whiteView?.frame.size.width)!, height: 140*PROSIZE))
        bg.image = UIImage.init(named: "ic_vip_right_dialog_bg")
        whiteView?.addSubview(bg)
        
        let cancelBtn = UIButton.init(type: UIButton.ButtonType.custom)
        cancelBtn.frame = CGRect.init(x: (whiteView?.frame.size.width)!-68*PROSIZE, y: 0, width: 68*PROSIZE, height: 58*PROSIZE)
        cancelBtn.setImage(UIImage.init(named: "ic_back_login"), for: UIControl.State.normal)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
        whiteView?.addSubview(cancelBtn)
        
        let contentSccrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: 140*PROSIZE, width: (whiteView?.frame.size.width)!, height: 430*PROSIZE))
        whiteView?.addSubview(contentSccrlView)
        
        let icon = UIImageView.init(frame: CGRect.init(x: ((whiteView?.frame.size.width)!-95*PROSIZE)/2, y: 30*PROSIZE, width: 95*PROSIZE, height: 95*PROSIZE))
        icon.dwn_setImageView(urlStr: detailModel.icon_active!, imageName: "")
        contentSccrlView.addSubview(icon)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: icon.frame.origin.y+icon.frame.size.height+16*PROSIZE, width: (whiteView?.frame.size.width)!-40*PROSIZE, height: 23*PROSIZE))
        titleNameLbl.text = detailModel.title
        titleNameLbl.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        titleNameLbl.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl.textAlignment = NSTextAlignment.center
        contentSccrlView.addSubview(titleNameLbl)
        
        let synoNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: titleNameLbl.frame.origin.y+titleNameLbl.frame.size.height+10*PROSIZE, width: (whiteView?.frame.size.width)!-40*PROSIZE, height: 14*PROSIZE))
        synoNameLbl.text = detailModel.synopsis
        synoNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        synoNameLbl.textColor = colorWithHex(hex: 0x999999)
        synoNameLbl.textAlignment = NSTextAlignment.center
        contentSccrlView.addSubview(synoNameLbl)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 30*PROSIZE, y: synoNameLbl.frame.origin.y+synoNameLbl.frame.size.height+15*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        contentSccrlView.addSubview(fstLine)
        
        let vipNameLbl = UILabel.init(frame: CGRect.init(x: ((whiteView?.frame.size.width)!-48*PROSIZE)/2, y: fstLine.frame.origin.y+fstLine.frame.size.height+11*PROSIZE, width: 48*PROSIZE, height: 18*PROSIZE))
        vipNameLbl.text = "VIP"
        vipNameLbl.textColor = colorWithHex(hex: 0x333333)
        vipNameLbl.backgroundColor = colorWithHex(hex: 0xE8CF73)
        vipNameLbl.layer.cornerRadius = 2
        vipNameLbl.layer.masksToBounds = true
        vipNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        vipNameLbl.textAlignment = NSTextAlignment.center
        contentSccrlView.addSubview(vipNameLbl)
        
        let secLine = UIView.init(frame: CGRect.init(x: 30*PROSIZE, y: vipNameLbl.frame.origin.y+vipNameLbl.frame.size.height+11*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        contentSccrlView.addSubview(secLine)
        
        let descSize = NSString.calStrSize(textStr: detailModel.details! as NSString, width: (whiteView?.frame.size.width)!-60*PROSIZE, fontSize: 17*PROSIZE)
        
        let descNameLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: secLine.frame.origin.y+secLine.frame.size.height+26*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: descSize.height))
        descNameLbl.text = detailModel.details
        descNameLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        descNameLbl.textColor = colorWithHex(hex: 0x333333)
        descNameLbl.numberOfLines = 0
        contentSccrlView.addSubview(descNameLbl)
        
        contentSccrlView.contentSize = CGSize.init(width: (whiteView?.frame.size.width)!, height: descNameLbl.frame.origin.y+descNameLbl.frame.size.height+20*PROSIZE)
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration:0.5, animations: {
            self.whiteView?.frame.origin.y = (SCREEN_HEIGHT-570*PROSIZE)/2+20*PROSIZE
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations: {
                self.whiteView?.frame.origin.y = (SCREEN_HEIGHT-570*PROSIZE)/2-20*PROSIZE
            }, completion: { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.whiteView?.frame.origin.y = (SCREEN_HEIGHT-570*PROSIZE)/2
                })
            })
        }
    }
    
    func close() {
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteView!.frame.origin.y = -570*PROSIZE
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelAction(sender:UIButton) {
        close()
    }
    
    @objc func coverClose(tap:UIGestureRecognizer) {
        close()
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
