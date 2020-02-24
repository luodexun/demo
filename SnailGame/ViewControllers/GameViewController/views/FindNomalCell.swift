//
//  FindNomalCell.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class FindNomalCell: UICollectionViewCell {
    
    var iconView : UIImageView?
    
    var titleNameLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height-26*PROSIZE))
        iconView?.layer.cornerRadius = 13*PROSIZE
        iconView?.layer.masksToBounds = true
        self.addSubview(iconView!)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 0, y: iconView!.frame.size.height+6*PROSIZE, width: self.frame.size.width, height: 20*PROSIZE))
        titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        self.addSubview(titleNameLbl!)
        
    }
    
    func setFindNomalCell(detailModel:FindListDetailModel) {
        iconView?.dwn_setImageView(urlStr: detailModel.icon!, imageName: "")
        titleNameLbl?.text = detailModel.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
