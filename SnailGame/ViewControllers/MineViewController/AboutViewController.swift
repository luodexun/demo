//
//  AboutViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "关于", titleColor: colorWithHex(hex: 0x333333))
        setUpViews()
    }
    
    func setUpViews() {
        
        let logo = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-60*PROSIZE)/2, y: STABAR_HEIGHT+44+58*PROSIZE, width: 60*PROSIZE, height: 60*PROSIZE))
        logo.image = UIImage.init(named: "ic_snial_logo")
        logo.contentMode = .scaleAspectFit
        logo.layer.cornerRadius = 5
        logo.layer.masksToBounds = true
        self.view.addSubview(logo)
        
        let appNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: logo.frame.origin.y+logo.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 22*PROSIZE))
        appNameLbl.textColor = colorWithHex(hex: 0x333333)
        appNameLbl.font = UIFont.systemFont(ofSize: 22*PROSIZE)
        appNameLbl.text = "大蜗牛社区"
        appNameLbl.textAlignment = .center
        self.view.addSubview(appNameLbl)
        
        let versionNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: appNameLbl.frame.origin.y+appNameLbl.frame.size.height+20*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 22*PROSIZE))
        versionNameLbl.textColor = colorWithHex(hex: 0x666666)
        versionNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        versionNameLbl.text = "版本 " + getAppVersion()
        versionNameLbl.textAlignment = .center
        self.view.addSubview(versionNameLbl)
        
        let line = UIView.init(frame: CGRect.init(x: 50*PROSIZE, y: versionNameLbl.frame.origin.y+versionNameLbl.frame.size.height+40*PROSIZE, width: SCREEN_WIDE-100*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.view.addSubview(line)
        
        let str = "大蜗牛社区是新一代的区块链价值互联网平台社区。\n\n用户可以在社区内看资讯、玩游戏、交朋友、学知识，并同时赚取Token资产-DWN。\n\n大蜗牛社区钱包是基于区块链的互联网支付工具，用钱包您可以安全且方便的支付，同时您在钱包内的资产还会享受理财性升值。"
        
        let size = NSString.calStrSize(textStr: str as NSString, width: SCREEN_WIDE-100*PROSIZE, fontSize: 15*PROSIZE)
        
        let descLbl = UILabel.init(frame: CGRect.init(x: 50*PROSIZE, y: line.frame.origin.y+line.frame.size.height+30*PROSIZE, width: SCREEN_WIDE-100*PROSIZE, height: size.height))
        descLbl.textColor = colorWithHex(hex: 0x333333)
        descLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        descLbl.text = str
        descLbl.numberOfLines = 0
        self.view.addSubview(descLbl)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
