//
//  SecretMagagerThirdView.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SecretMagagerThirdView: UIView {
    
    var eyeIcon : UIImageView?

    var eyeBtn , clearBtn : UIButton?
    
    var mnemonicLbl : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barView = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: 32*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 191*PROSIZE))
        barView.backgroundColor = UIColor.white
        barView.layer.cornerRadius = 4
        barView.layer.masksToBounds = true
        self.addSubview(barView)
        
        let secretTitleLbl = UILabel.init(frame: CGRect.init(x: 110*PROSIZE, y: 40*PROSIZE, width: 71*PROSIZE, height: 24*PROSIZE))
        secretTitleLbl.font = UIFont.boldSystemFont(ofSize: 17*PROSIZE)
        secretTitleLbl.textColor = colorWithHex(hex: 0x333333)
        secretTitleLbl.text = "助记词"
        secretTitleLbl.textAlignment = .right
        barView.addSubview(secretTitleLbl)
        
        eyeIcon = UIImageView.init(frame: CGRect.init(x: secretTitleLbl.frame.origin.x+secretTitleLbl.frame.size.width+7*PROSIZE, y: 40*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE))
        eyeIcon?.image = UIImage.init(named: "icon_home_eye_nol")
        barView.addSubview(eyeIcon!)
        
        eyeBtn = UIButton.init(type: .roundedRect)
        eyeBtn?.frame = CGRect.init(x: 128*PROSIZE, y: 40*PROSIZE, width: 84*PROSIZE, height: 24*PROSIZE)
        barView.addSubview(eyeBtn!)
        
        mnemonicLbl =  UILabel.init(frame: CGRect.init(x: 10*PROSIZE, y: secretTitleLbl.frame.origin.y+secretTitleLbl.frame.size.height+10*PROSIZE, width: barView.frame.size.width-20*PROSIZE, height: 68*PROSIZE))
        mnemonicLbl?.font = UIFont.boldSystemFont(ofSize: 17*PROSIZE)
        mnemonicLbl?.textColor = colorWithHex(hex: 0x333333)
        mnemonicLbl?.textAlignment = .center
        mnemonicLbl?.numberOfLines = 0
        barView.addSubview(mnemonicLbl!)
        
        clearBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        clearBtn?.frame = CGRect.init(x: 18*PROSIZE, y: barView.frame.origin.y+barView.frame.size.height+48*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 46*PROSIZE)
        clearBtn?.setTitle("从本地删除", for: UIControl.State.normal)
        clearBtn?.setTitleColor(colorWithHex(hex: 0x333333), for: UIControl.State.normal)
        clearBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        clearBtn?.layer.borderWidth = 1
        clearBtn?.layer.borderColor = colorWithHex(hex: 0x333333).cgColor
        clearBtn?.layer.cornerRadius = 5
        clearBtn?.layer.masksToBounds = true
        self.addSubview(clearBtn!)
        
        let clearTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: clearBtn!.frame.origin.y+clearBtn!.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 15*PROSIZE))
        clearTitleLbl.font = UIFont.boldSystemFont(ofSize: 14*PROSIZE)
        clearTitleLbl.textColor = colorWithHex(hex: 0x333333)
        clearTitleLbl.text = "删除后，将无任何方法找回助记词"
        self.addSubview(clearTitleLbl)
        
        let clearDescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: clearTitleLbl.frame.origin.y+clearTitleLbl.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 60*PROSIZE))
        clearDescLbl.font = UIFont.boldSystemFont(ofSize: 14*PROSIZE)
        clearDescLbl.textColor = colorWithHex(hex: 0x333333)
        clearDescLbl.text = "此本地保存只为方便您查看与使用，不能代替您在纸质文本上的保存，请牢记您的助记词"
        clearDescLbl.numberOfLines = 0
        self.addSubview(clearDescLbl)
        
    }
    
    required init?(coder: NSCoder) {
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
