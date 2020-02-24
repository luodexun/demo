//
//  TrinketWallCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TrinketWallCell: UICollectionViewCell {
    
    var rightImageView : UIImageView?
    
    var rightNameLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rightImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-112*PROSIZE)/2, y: 10*PROSIZE, width: 112*PROSIZE, height: 112*PROSIZE))
        rightImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(rightImageView!)
        
        rightNameLbl = UILabel.init(frame: CGRect.init(x: 0, y: rightImageView!.frame.origin.y+rightImageView!.frame.size.height+10*PROSIZE, width: self.frame.size.width, height: 14*PROSIZE))
        rightNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rightNameLbl?.textColor = colorWithHex(hex: 0x333333)
        rightNameLbl?.textAlignment = NSTextAlignment.center
        
        self.addSubview(rightNameLbl!)
    }
    
    func setTrinketWallCell(wallModel:TrinketWallDataModel) {
        if wallModel.status == 1 {
            rightImageView?.dwn_setImageView(urlStr: wallModel.icon_active!, imageName: "")
            rightNameLbl?.text = wallModel.name
        } else {
            rightImageView?.dwn_setImageView(urlStr: wallModel.icon_no_active!, imageName: "")
            rightNameLbl?.text = wallModel.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
