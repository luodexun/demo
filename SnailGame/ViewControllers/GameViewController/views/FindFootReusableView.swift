//
//  FindFootReusableView.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class FindFootReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 16*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
