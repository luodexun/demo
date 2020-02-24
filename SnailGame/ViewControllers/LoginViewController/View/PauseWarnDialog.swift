//
//  PauseWarnDialog.swift
//  SnailGame
//
//  Created by Edison on 2019/12/10.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PauseWarnDialog: UIView {

    var coverView , whiteView : UIView?
    
    var whiteViewStartFrame: CGRect = CGRect.init(x: SCREEN_WIDE/2 - 10*PROSIZE, y: SCREEN_HEIGHT/2 - 10*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE)
    
    var whiteViewEndFrame: CGRect = CGRect.init(x: 30*PROSIZE, y: (SCREEN_HEIGHT - 480*PROSIZE)/2, width: SCREEN_WIDE - 60*PROSIZE, height: 480*PROSIZE)
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setUpViews()
    }
    
    func setUpViews() {
        
        coverView = UIView.init(frame: self.bounds)
        coverView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        addSubview(coverView!)
        
        whiteView = UIView.init(frame: whiteViewStartFrame)
        whiteView?.backgroundColor = UIColor.white
        whiteView?.layer.masksToBounds = true
        whiteView?.layer.cornerRadius = 5
        whiteView?.clipsToBounds = true
        self.addSubview(whiteView!)
    }
    
    func setUpSubViews() {
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: (whiteView?.frame.size.width)!, height: 100*PROSIZE))
        barView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        whiteView?.addSubview(barView)
        
        let warnIcon = UIImageView.init(frame: CGRect.init(x: 75*PROSIZE, y: 25*PROSIZE, width: 165*PROSIZE, height: 60*PROSIZE))
        warnIcon.image = UIImage.init(named: "ic_set_pause_warn")
        barView.addSubview(warnIcon)
        
        let contentIcon = UIImageView.init(frame: CGRect.init(x: 30*PROSIZE, y: barView.frame.size.height+20*PROSIZE, width: 255*PROSIZE, height: 290*PROSIZE))
        contentIcon.image = UIImage.init(named: "ic_set_pause_warn_content")
        whiteView?.addSubview(contentIcon)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: (whiteView?.frame.size.height)! - 56*PROSIZE, width: (whiteView?.frame.size.width)!, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        whiteView?.addSubview(line)
        
        let konwBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        konwBtn.frame = CGRect.init(x: 0, y: (whiteView?.frame.size.height)!-54*PROSIZE, width: (whiteView?.frame.size.width)!, height: 54*PROSIZE)
        konwBtn.setTitle("朕知道了", for: UIControl.State.normal)
        konwBtn.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        konwBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        konwBtn.addTarget(self, action: #selector(konwAction), for: UIControl.Event.touchUpInside)
        whiteView?.addSubview(konwBtn)
        
    }
    
    @objc func konwAction(sender:UIButton) {
        close()
    }
    
    func show() {
           UIApplication.shared.keyWindow?.addSubview(self)
           UIView.animate(withDuration: 0.5, animations: {
               self.whiteView?.frame = self.whiteViewEndFrame
           }) { (_) in
               self.setUpSubViews()
           }
       }
       
       func close() {
           for view in whiteView!.subviews {
               view.removeFromSuperview()
           }
           UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
               self.whiteView?.frame = self.whiteViewStartFrame
           }) { (_) in
               self.removeFromSuperview()
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
