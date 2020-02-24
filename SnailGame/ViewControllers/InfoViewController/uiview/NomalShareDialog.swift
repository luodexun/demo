//
//  NomalShareDialog.swift
//  SnailGame
//
//  Created by Edison on 2020/1/8.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

typealias NomalShareBlock = (_ platformType:UMSocialPlatformType) -> Void

class NomalShareDialog: UIView {
    
    var titleList = ["微信","朋友圈"]
    
    var coverView , contentView : UIView?
    
    var nomalShareHandel : NomalShareBlock?
    
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
        
        contentView = UIView.init(frame: CGRect.init(x: 0, y: frame.height, width: frame.width, height: 136*PROSIZE))
        contentView?.backgroundColor = UIColor.white
        addSubview(contentView!)
        
        let imageList = ["ic_share_wechat","ic_share_friends"]
        
        for (i,item) in titleList.enumerated() {
            let itemView:ShareItemView = ShareItemView.init(frame: CGRect.init(x: CGFloat(i)*SCREEN_WIDE/2 + SCREEN_WIDE/4 - 50*PROSIZE/2, y: 12*PROSIZE, width: 50*PROSIZE, height: 50*PROSIZE))
            itemView.itemBtn?.tag = 1000+i
            itemView.iconView?.image = UIImage.init(named: imageList[i])
            itemView.itemTitleLbl?.text = item
            itemView.itemBtn?.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
            contentView!.addSubview(itemView)
        }
        
        let cancelBtn = UIButton.init(type: .roundedRect)
        cancelBtn.frame = CGRect.init(x: 0, y: (contentView?.frame.size.height)!-44*PROSIZE, width: (contentView?.frame.size.width)!, height: 44*PROSIZE)
        cancelBtn.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(colorWithHex(hex: 0x333333), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        contentView!.addSubview(cancelBtn)
        
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView?.alpha = 1.0
            self.contentView?.transform = CGAffineTransform.init(translationX: 0, y: -(self.contentView?.bounds.height)!)
        }, completion: nil)
    }
    
    func close() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView?.alpha = 0.0
            self.contentView?.transform = CGAffineTransform.identity
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
    
    @objc func shareAction(sender:UIButton) {
        if (UMSocialManager.default()?.isInstall(.wechatSession))! {
            if sender.tag == 1000 {
                nomalShareHandel!(.wechatSession)
            } else {
                nomalShareHandel!(.wechatTimeLine)
            }
            close()
        } else {
            showTextToast(text: "请先安装微信客户端", view: self)
        }
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
