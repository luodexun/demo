//
//  AuthentySuccessViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AuthentySuccessViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var successView : AuthentySuccessView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "实名认证", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initViews()
    }
    
    func initViews() {
        let userModel = BusinessEngine.init().getLoginUserModel()
        var promptH:CGFloat = 0.0
        if userModel.is_certified != 1 {
            promptH = 65*PROSIZE
            let promptBarView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 65*PROSIZE))
            promptBarView.backgroundColor = colorWithHex(hex: 0xFFFCE8)
            self.view.addSubview(promptBarView)
            
            let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: promptBarView.frame.size.width-40*PROSIZE, height: promptBarView.frame.size.height))
            promptTitleLbl.text = "您已上传认证信息，请等待审核。审核会在48小时 内完成，如遇节假日可能会产生顺延。"
            promptTitleLbl.textColor = colorWithHex(hex: 0x333333)
            promptTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
            promptTitleLbl.numberOfLines = 0
            promptBarView.addSubview(promptTitleLbl)
        }
        
        successView = AuthentySuccessView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+promptH, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44-promptH))
        self.view.addSubview(successView!)
        
        if userModel.nickname != nil {
            successView?.userNameLbl?.text = userModel.nickname
        }
        
        if userModel.avatar != nil {
            successView?.userImageView?.dwn_setImageView(urlStr: userModel.avatar!, imageName: "ic_mine_portrait_default")
        }
        
        if userModel.is_certified != 1 {
            successView?.authenImageView?.image = UIImage.init(named: "ic_authenty_ing")
        } else {
            successView?.authenImageView?.image = UIImage.init(named: "ic_authenty_complate")
        }
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
