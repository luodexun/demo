//
//  UpdatePayViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class UpdatePayViewController: BaseViewController {

    var updateView : UpdatePayView?
    
    var userModel : UserLoginDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "修改支付密码", titleColor: colorWithHex(hex: 0x333333))
        userModel = BusinessEngine.init().getLoginUserModel()
        initUpdatePayView()
    }
    
    func initUpdatePayView() {
        
        updateView = UpdatePayView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(updateView!)
        
        updateView?.payPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        updateView?.againPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        updateView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func submitAction(sender:UIButton) {
        if updateView?.payPwdTxtF!.text != updateView?.againPwdTxtF!.text  {
            showTextToast(text: "两次输入不一样", view: self.view)
            return
        }
        showLoading(view: self.view)
        let param = NSMutableDictionary.init()
        param.setValue(updateView?.payPwdTxtF!.text, forKey: "pay_password")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            SSKeychain.deletePassword(forService: Bundle.main.bundleIdentifier, account: self.userModel!.mobile)
            self.navigationController?.popToRootViewController(animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func payTextChange(txtF:UITextField) {
        if (updateView?.payPwdTxtF!.text!.count)! > 5 && (updateView?.againPwdTxtF!.text!.count)! > 5 {
            updateView?.submitBtn?.isUserInteractionEnabled = true
            updateView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            updateView?.submitBtn?.isUserInteractionEnabled = false
            updateView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
