//
//  GameCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    var gameImageView : UIImageView?
    
    var gameNameLbl , gameDescLbl : UILabel?
    
     var bottomLine : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        gameImageView = UIImageView.init(frame: CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 200*PROSIZE))
        gameImageView?.layer.cornerRadius = 10
        gameImageView?.layer.masksToBounds = true
        self.addSubview(gameImageView!)
        
        gameNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (gameImageView?.frame.origin.y)!+(gameImageView?.frame.size.height)!+15*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 17*PROSIZE))
        gameNameLbl?.textColor = colorWithHex(hex: 0x333333)
        gameNameLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        self.addSubview(gameNameLbl!)
        
        gameDescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: (gameNameLbl?.frame.origin.y)!+(gameNameLbl?.frame.size.height)!+10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 17*PROSIZE))
        gameDescLbl?.textColor = colorWithHex(hex: 0x999999)
        gameDescLbl?.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        gameDescLbl?.numberOfLines = 0
        self.addSubview(gameDescLbl!)
        
        bottomLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: (gameDescLbl?.frame.origin.y)!+(gameDescLbl?.frame.size.height)!+20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 1*PROSIZE))
        bottomLine?.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(bottomLine!)
        
    }
    
    func setGameCell(dataModel:GameDataModel) {
        let realH = dataModel.cover_size!.height! * (SCREEN_WIDE-40*PROSIZE) / dataModel.cover_size!.width!
        gameImageView?.frame.size.height = realH
        gameImageView?.dwn_setImageView(urlStr: dataModel.cover!, imageName: "")
        let gameNameSize = NSString.calStrSize(textStr: dataModel.name! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 18*PROSIZE)
        gameNameLbl?.frame = CGRect.init(x: 20*PROSIZE, y: gameImageView!.frame.origin.y+gameImageView!.frame.size.height+15*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: gameNameSize.height)
        gameNameLbl?.text = dataModel.name
        let gameDescSize = NSString.calStrSize(textStr: dataModel.desc! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 18*PROSIZE)
        gameDescLbl?.frame = CGRect.init(x: 20*PROSIZE, y: gameNameLbl!.frame.origin.y + gameNameLbl!.frame.size.height+10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: gameDescSize.height)
        gameDescLbl?.text = dataModel.desc
        bottomLine?.frame.origin.y = gameDescLbl!.frame.origin.y+gameDescLbl!.frame.size.height+20*PROSIZE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
