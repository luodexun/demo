//
//  SecuritySetViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SecuritySetViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "安全设置", titleColor: colorWithHex(hex: 0x333333))
        initViews()
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
    }
    
    @objc func accountPushAction () {
        let accountVC = AccountViewController.init()
        self.navigationController?.pushViewController(accountVC, animated: true)
    }
    
    @objc func updatePushAction () {
        let modifyPayVC = ModifyPayViewController.init()
        self.navigationController?.pushViewController(modifyPayVC, animated: true)
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
   
        let accountNext = UIImageView.init(frame: CGRect.init(x: accountBarView.frame.size.width-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        accountNext.image = UIImage.init(named: "ic_mine_next")
        accountBarView.addSubview(accountNext)
        
        let accountBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        accountBtn.frame = accountBarView.bounds
        accountBtn.addTarget(self, action: #selector(accountPushAction), for: UIControl.Event.touchUpInside)
        accountBarView.addSubview(accountBtn)
        
        let updateBarView = UIView.init(frame: CGRect.init(x: 0, y: accountBarView.frame.origin.y+accountBarView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE, height: 54*PROSIZE))
        updateBarView.backgroundColor = UIColor.white
        self.view.addSubview(updateBarView)
        
        let updateTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 17*PROSIZE, width: 140*PROSIZE, height: 20*PROSIZE))
        updateTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        updateTitleLbl.text = "修改支付密码"
        updateTitleLbl.textColor = colorWithHex(hex: 0x333333)
        updateBarView.addSubview(updateTitleLbl)
        
        let updateNext = UIImageView.init(frame: CGRect.init(x: updateBarView.frame.size.width-28*PROSIZE, y: 20*PROSIZE, width: 8*PROSIZE, height: 14*PROSIZE))
        updateNext.image = UIImage.init(named: "ic_mine_next")
        updateBarView.addSubview(updateNext)
        
        let updateBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        updateBtn.frame = updateBarView.bounds
        updateBtn.addTarget(self, action: #selector(updatePushAction), for: UIControl.Event.touchUpInside)
        updateBarView.addSubview(updateBtn)
        
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
