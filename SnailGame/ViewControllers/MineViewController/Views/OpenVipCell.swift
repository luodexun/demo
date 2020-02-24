//
//  OpenVipCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class OpenVipCell: UITableViewCell {

    var promptNameLbl : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        promptNameLbl = UILabel.init(frame: CGRect.init(x: 34*PROSIZE, y: 14*PROSIZE, width: SCREEN_WIDE-68*PROSIZE, height: 12*PROSIZE))
        promptNameLbl?.text = "当前余额不足，无法购买。"
        promptNameLbl?.textAlignment = NSTextAlignment.center
        promptNameLbl?.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        promptNameLbl?.textColor = colorWithHex(hex: 0xFF0F59)
        self.addSubview(promptNameLbl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
