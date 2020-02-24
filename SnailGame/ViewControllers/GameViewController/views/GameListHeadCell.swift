//
//  GameListHeadCell.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class GameListHeadCell: UICollectionViewCell {
    
    var titleNameLbl : UILabel?
    
    //var selectLine : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleNameLbl = UILabel.init(frame: CGRect.init(x: 0, y: 1*PROSIZE, width: self.frame.size.width, height: 21*PROSIZE))
        titleNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(titleNameLbl!)
        
//        selectLine = UIView.init(frame: CGRect.init(x: 0, y: 28*PROSIZE, width: self.frame.size.width, height: 2*PROSIZE))
//        selectLine?.backgroundColor = UIColor.white
//        self.addSubview(selectLine!)
    }
    
    func setGameListHeadCell(sectionModel:FindListSectionModel) {
        titleNameLbl?.frame.size.width = self.frame.size.width
        if sectionModel.isSelect! {
            titleNameLbl?.textColor = colorWithHex(hex: 0x333333)
        } else {
            titleNameLbl?.textColor = colorWithHex(hex: 0x999999)
        }
        titleNameLbl?.text = sectionModel.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
