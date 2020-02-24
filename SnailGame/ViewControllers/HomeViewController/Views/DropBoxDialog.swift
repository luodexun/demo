//
//  DropBoxDialog.swift
//  SnailGame
//
//  Created by Edison on 2019/12/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias DropBoxBlock = () -> Void

class DropBoxDialog: UIView {

    var dropBoxHandel : DropBoxBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        let deleteBtn = UIButton.init(type: .custom)
        deleteBtn.frame = CGRect.init(x: self.frame.size.width-15*PROSIZE, y: 0, width: 15*PROSIZE, height: 15*PROSIZE)
        deleteBtn.setImage(UIImage.init(named: "ic_home_drop_cancel"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        self.addSubview(deleteBtn)
        
        let dropIcon = UIImageView.init(frame: CGRect.init(x: 0, y: 15*PROSIZE, width: 72*PROSIZE, height: 72*PROSIZE))
        dropIcon.image = UIImage.init(named: "ic_home_drop")
        self.addSubview(dropIcon)
        
        let dropBtn = UIButton.init(type: .roundedRect)
        dropBtn.frame = CGRect.init(x: 5*PROSIZE, y: 20*PROSIZE, width: 62*PROSIZE, height: 62*PROSIZE)
        dropBtn.addTarget(self, action: #selector(dropAction), for: .touchUpInside)
        self.addSubview(dropBtn)
    }
    
    func show() {
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.frame.origin.y  = SCREEN_HEIGHT-SAFE_BOTTOM-70-87*PROSIZE
        }, completion: nil)
    }
    
    func close() {
        self.frame.origin.y  = -87*PROSIZE
    }
    
    @objc func deleteAction(sender:UIButton) {
        close()
    }
    
    @objc func dropAction(sender:UIButton) {
        dropBoxHandel!()
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
