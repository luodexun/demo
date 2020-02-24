//
//  RegionSelectCell.swift
//  SnailGame
//
//  Created by Edison on 2019/10/10.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegionSelectCell: UITableViewCell {

    var regionNameLbl , regionCodeLbl : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        regionNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 160*PROSIZE, height: 20*PROSIZE))
        regionNameLbl?.textColor = colorWithHex(hex: 0x333333)
        regionNameLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        self.addSubview(regionNameLbl!)
        
        
        regionCodeLbl = UILabel.init(frame: CGRect.init(x: SCREEN_WIDE-180*PROSIZE, y: 15*PROSIZE, width: 160*PROSIZE, height: 20*PROSIZE))
        regionCodeLbl?.textColor = colorWithHex(hex: 0x333333)
        regionCodeLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        regionCodeLbl?.textAlignment = NSTextAlignment.right
        self.addSubview(regionCodeLbl!)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 49*PROSIZE, width: SCREEN_WIDE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
