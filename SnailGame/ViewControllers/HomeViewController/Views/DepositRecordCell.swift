//
//  DepositRecordCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositRecordCell: UICollectionViewCell {
    
    var operaNameLbl , stateNameLbl , createTimeLbl , earnDwnLbl : UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        operaNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 16*PROSIZE, width: 23*PROSIZE, height: 23*PROSIZE))
        operaNameLbl?.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        operaNameLbl?.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        operaNameLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(operaNameLbl!)
        
        createTimeLbl = UILabel.init(frame: CGRect.init(x: 51*PROSIZE, y: 13*PROSIZE, width: 170*PROSIZE, height: 16*PROSIZE))
        createTimeLbl?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        createTimeLbl?.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(createTimeLbl!)
        
        stateNameLbl = UILabel.init(frame: CGRect.init(x: 51*PROSIZE, y: 32*PROSIZE, width: 170*PROSIZE, height: 12*PROSIZE))
        stateNameLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        stateNameLbl?.textColor = colorWithHex(hex: 0x0077ff)
        self.addSubview(stateNameLbl!)
        
        earnDwnLbl = UILabel.init(frame: CGRect.init(x: self.frame.size.width-130*PROSIZE, y: 15*PROSIZE, width: 110*PROSIZE, height: 25*PROSIZE))
        earnDwnLbl?.font = UIFont.systemFont(ofSize: 20*PROSIZE)
        earnDwnLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(earnDwnLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 50*PROSIZE, y: 54*PROSIZE, width: self.frame.size.width-50*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    func setDepositRecordCell(dataModel:EscrowRecordDataModel) {
        if dataModel.type == 8 {
            operaNameLbl?.text = "存"
            operaNameLbl?.textColor = colorWithHex(hex: 0xff7700)
            earnDwnLbl?.textColor = colorWithHex(hex: 0xff7700)
            earnDwnLbl?.text = "+" + KeepSomeDecimal(num: calculateAChuyiB(a: dataModel.num!, b: TOKEN_RATIO), decimal: 2)
        } else {
            operaNameLbl?.text = "提"
            operaNameLbl?.textColor = colorWithHex(hex: 0x333333)
            earnDwnLbl?.textColor = colorWithHex(hex: 0x333333)
            earnDwnLbl?.text = "-" + KeepSomeDecimal(num: calculateAChuyiB(a: dataModel.num!, b: TOKEN_RATIO), decimal: 2)
        }
        createTimeLbl?.text = intervalSinceNow(stamp: dataModel.create_time!)
        switch dataModel.status {
        case 0:
            stateNameLbl?.text = "未完成"
            break
        case 1:
            stateNameLbl?.text = "确认中"
            break
        case 2:
            stateNameLbl?.text = "成功"
            break
        case 3:
            stateNameLbl?.text = "失败"
            break
        default:
            stateNameLbl?.text = "迷之状态"
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
