//
//  AccountViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "账号", titleColor: colorWithHex(hex: 0x333333))
        initViews()
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
    }
    
    func initViews() {
        
        let accountBarView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 54*PROSIZE))
        accountBarView.backgroundColor = UIColor.white
        self.view.addSubview(accountBarView)
        
        let accountTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        accountTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        accountTitleLbl.text = "账号（手机号）"
        accountTitleLbl.textColor = colorWithHex(hex: 0x333333)
        accountBarView.addSubview(accountTitleLbl)
        
        let accountLbl = UILabel.init(frame: CGRect.init(x: accountBarView.frame.size.width-200*PROSIZE, y: 17*PROSIZE, width: 180*PROSIZE, height: 20*PROSIZE))
        accountLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        let userModel = BusinessEngine.init().getLoginUserModel()
        accountLbl.text = "+" + userModel.region! + " " + userModel.mobile!
        accountLbl.textColor = colorWithHex(hex: 0x333333)
        accountLbl.textAlignment = NSTextAlignment.right
        accountBarView.addSubview(accountLbl)
        
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
