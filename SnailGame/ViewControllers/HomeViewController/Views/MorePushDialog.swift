//
//  MorePushDialog.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias MorePushBlock = (_ tag:Int) -> Void

class MorePushDialog: UIView {

    var coverView , whiteView : UIView?
    
    var whiteViewStartFrame: CGRect = CGRect.init(x: SCREEN_WIDE-154*PROSIZE, y: STABAR_HEIGHT+40, width: 154*PROSIZE, height: 0.0)
    
    var whiteViewEndFrame: CGRect = CGRect.init(x: SCREEN_WIDE-154*PROSIZE, y: STABAR_HEIGHT+40, width: 154*PROSIZE, height: 160*PROSIZE)
    
    var morePushHandel : MorePushBlock?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setUpViews()
    }
    
    func setUpViews() {
        
        coverView = UIView.init(frame: self.bounds)
        coverView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        addSubview(coverView!)
        
        let coverTap = UITapGestureRecognizer.init(target: self, action: #selector(coverClose))
        coverView?.addGestureRecognizer(coverTap)
        
        whiteView = UIView.init(frame: whiteViewStartFrame)
        whiteView?.clipsToBounds = true
        self.addSubview(whiteView!)
        
        let barImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 150*PROSIZE, height: 160*PROSIZE))
        barImageView.image = UIImage.init(named: "ic_wallet_detail_more_bar")
        whiteView?.addSubview(barImageView)

        let browserIcon = UIImageView.init(frame: CGRect.init(x: 14*PROSIZE, y: 18*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE))
        browserIcon.image = UIImage.init(named: "ic_wallet_more_browser")
        whiteView?.addSubview(browserIcon)

        let browserTitleLbl = UILabel.init(frame: CGRect.init(x: 43*PROSIZE, y: 19*PROSIZE, width: whiteView!.frame.size.width-50*PROSIZE, height: 22*PROSIZE))
        browserTitleLbl.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        browserTitleLbl.textColor = colorWithHex(hex: 0x333333)
        browserTitleLbl.text = "区块浏览器"
        whiteView?.addSubview(browserTitleLbl)
        
        let browserBtn = UIButton.init(type: .roundedRect)
        browserBtn.frame = CGRect.init(x: 14*PROSIZE, y: 0, width: whiteView!.frame.size.width-32*PROSIZE, height: 55*PROSIZE)
        browserBtn.tag = 1001
        browserBtn.addTarget(self, action: #selector(browserAction), for: .touchUpInside)
        whiteView?.addSubview(browserBtn)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 14*PROSIZE, y: 55*PROSIZE, width: whiteView!.frame.size.width-32*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        whiteView?.addSubview(fstLine)

        let keyIcon = UIImageView.init(frame: CGRect.init(x: 14*PROSIZE, y: 70*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE))
        keyIcon.image = UIImage.init(named: "ic_wallet_more_key")
        whiteView?.addSubview(keyIcon)

        let keyTitleLbl = UILabel.init(frame: CGRect.init(x: 43*PROSIZE, y: 71*PROSIZE, width: whiteView!.frame.size.width-50*PROSIZE, height: 22*PROSIZE))
        keyTitleLbl.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        keyTitleLbl.textColor = colorWithHex(hex: 0x333333)
        keyTitleLbl.text = "本地助记词"
        whiteView?.addSubview(keyTitleLbl)
        
        let keyBtn = UIButton.init(type: .roundedRect)
        keyBtn.frame = CGRect.init(x: 14*PROSIZE, y: 56*PROSIZE, width: whiteView!.frame.size.width-32*PROSIZE, height: 51*PROSIZE)
        keyBtn.tag = 1002
        keyBtn.addTarget(self, action: #selector(browserAction), for: .touchUpInside)
        whiteView?.addSubview(keyBtn)

        let secLine = UIView.init(frame: CGRect.init(x: 14*PROSIZE, y: 107*PROSIZE, width: whiteView!.frame.size.width-32*PROSIZE, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        whiteView?.addSubview(secLine)

        let walletIcon = UIImageView.init(frame: CGRect.init(x: 14*PROSIZE, y: 122*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE))
        walletIcon.image = UIImage.init(named: "ic_wallet_more_wallet")
        whiteView?.addSubview(walletIcon)

        let walletTitleLbl = UILabel.init(frame: CGRect.init(x: 43*PROSIZE, y: 123*PROSIZE, width: whiteView!.frame.size.width-50*PROSIZE, height: 22*PROSIZE))
        walletTitleLbl.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        walletTitleLbl.textColor = colorWithHex(hex: 0x333333)
        walletTitleLbl.text = "替换钱包"
        whiteView?.addSubview(walletTitleLbl)
        
        let walletBtn = UIButton.init(type: .roundedRect)
        walletBtn.frame = CGRect.init(x: 14*PROSIZE, y: 108*PROSIZE, width: whiteView!.frame.size.width-32*PROSIZE, height: 52*PROSIZE)
        walletBtn.tag = 1003
        walletBtn.addTarget(self, action: #selector(browserAction), for: .touchUpInside)
        whiteView?.addSubview(walletBtn)
        
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration:0.5, animations: {
            self.whiteView?.frame = self.whiteViewEndFrame
        })
    }
    
    func close() {
        self.removeFromSuperview()
    }
    
    @objc func browserAction(sender:UIButton) {
        morePushHandel!(sender.tag-1000)
        close()
    }
    
    @objc func coverClose(tap:UIGestureRecognizer) {
        close()
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
