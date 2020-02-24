//
//  UpdatePhotoView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class UpdatePhotoView: UIView {

    var photoImageView , promptImageView : UIImageView?
    
    var takePhotoBtn : UIButton?
    
    var promptTitleLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let photoBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 115*PROSIZE))
        photoBarView.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        photoBarView.layer.cornerRadius = 5
        photoBarView.layer.masksToBounds = true
        self.addSubview(photoBarView)
    
        let addImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-25*PROSIZE)/2, y: 35*PROSIZE, width: 25*PROSIZE, height: 25*PROSIZE))
        addImageView.image = UIImage.init(named: "ic_identify_authen_add")
        photoBarView.addSubview(addImageView)
        
        let addTitleLbl = UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: 70*PROSIZE, width: self.frame.size.width-20*PROSIZE, height: 12*PROSIZE))
        addTitleLbl.text = "点击上传"
        addTitleLbl.textAlignment = NSTextAlignment.center
        addTitleLbl.textColor = colorWithHex(hex: 0x999999)
        addTitleLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        photoBarView.addSubview(addTitleLbl)
        
        photoImageView = UIImageView.init(frame: photoBarView.bounds)
        photoBarView.addSubview(photoImageView!)
        
        takePhotoBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        takePhotoBtn?.frame = photoBarView.bounds
        photoBarView.addSubview(takePhotoBtn!)
        
        promptImageView = UIImageView.init(frame: CGRect.init(x: 26*PROSIZE, y: photoBarView.frame.size.height+10*PROSIZE, width: 30*PROSIZE, height: 21*PROSIZE))
        self.addSubview(promptImageView!)
        
        promptTitleLbl = UILabel.init(frame: CGRect.init(x: 61*PROSIZE, y: photoBarView.frame.size.height+12*PROSIZE, width: self.frame.size.width-66*PROSIZE, height: 14*PROSIZE))
        promptTitleLbl?.textColor = colorWithHex(hex: 0x333333)
        promptTitleLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(promptTitleLbl!)
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
