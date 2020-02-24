//
//  MineLineCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineLineCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
