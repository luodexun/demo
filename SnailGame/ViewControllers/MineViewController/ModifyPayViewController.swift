//
//  ModifyPayViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ModifyPayViewController: BaseViewController , HumanVerifyDelegate {

    var payView : ModifyPayView?
    
    var userModel : UserLoginDataModel?
    
    var countTimer : Timer?

    var totalCount : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "修改支付密码", titleColor: colorWithHex(hex: 0x333333))
        initModifyPayView()
        userModel = BusinessEngine.init().getLoginUserModel()
    }
    
    func initModifyPayView() {
        payView = ModifyPayView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(payView!)
        
        let sendCodeTap = UITapGestureRecognizer.init(target: self, action: #selector(sendCodeAction))
        payView?.getCodeLbl?.addGestureRecognizer(sendCodeTap)
        
        payView?.originalPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        payView?.codeTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        payView?.nowPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        payView?.confirmPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        payView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        
        payView?.forgetBtn?.addTarget(self, action: #selector(forgetAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func sendCodeAction(tap:UIGestureRecognizer) {
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "sendCode"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction()  {
        payView?.getCodeLbl?.isUserInteractionEnabled = false
        BusinessEngine.init().sendCode(mobile: userModel!.mobile!, type: "editPassword", region: userModel!.region!, successResponse: { (BaseModel) in
            self.totalCount = 60
            self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
            self.countTimer!.fire()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
            self.payView?.getCodeLbl?.isUserInteractionEnabled = true
        }
    }
    
    @objc func countDownAction(sender:Timer){
        if totalCount == 1 {
            payView?.getCodeLbl?.isUserInteractionEnabled = true
            payView?.getCodeLbl?.text = "获取验证码"
            countTimer?.invalidate()
            countTimer = nil
        } else {
            totalCount! -= 1
            payView?.getCodeLbl?.text = String(totalCount!)+"s"
        }
    }
    
    @objc func payTextChange(txtF : UITextField) {
        if (payView?.originalPwdTxtF?.text!.count)! > 5 && payView?.codeTxtF?.text?.count != 0 && (payView?.nowPwdTxtF?.text!.count)! > 5 && (payView?.confirmPwdTxtF?.text!.count)! > 5 {
            payView?.submitBtn?.isUserInteractionEnabled = true
            payView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            payView?.submitBtn?.isUserInteractionEnabled = false
            payView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    @objc func submitAction(sender : UIButton) {
        if payView?.confirmPwdTxtF?.text != payView?.nowPwdTxtF?.text {
            showTextToast(text: "两次密码输入不正确", view: self.view)
            return
        }
        showLoading(view: self.view)
        BusinessEngine.init().checkCode(type: "editPassword", verifyCode: (payView?.codeTxtF!.text)!, mobile: (userModel?.mobile!)!, successResponse: { (baseModel) in
            self.payVerify()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func payVerify() {
        BusinessEngine.init().payVerify(code: (payView?.originalPwdTxtF!.text)!, successResponse: { (baseModel) in
            self.updateUserPassword()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func updateUserPassword() {
        let param = NSMutableDictionary.init()
        param.setValue(payView?.nowPwdTxtF?.text!, forKey: "pay_password")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (baseModel) in
            self.getUserInfo()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            let loginModel = BaseModel as! UserLoginModel
            let secretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: loginModel.data!.mobile)
            if secretStr != nil {
                SSKeychain.deletePassword(forService: Bundle.main.bundleIdentifier, account: loginModel.data!.mobile)
                let mnemonic = downUser_mnemonic_decrypt(wordStr: secretStr!, keyStr: (self.payView?.originalPwdTxtF?.text!)!)
                let secretKey = upUser_mnemonic_encrypt(wordStr: mnemonic, keyStr: (self.payView?.nowPwdTxtF?.text!)!)
                SSKeychain.setPassword(secretKey, forService: Bundle.main.bundleIdentifier, account: loginModel.data!.mobile)
            }
            self.view.hideToastActivity()
            self.navigationController?.popViewController(animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }

    @objc func forgetAction(sender : UIButton) {
        if userModel?.is_certified == 1 {
            let forgetPayVC = ForgetPayViewController.init()
            self.navigationController?.pushViewController(forgetPayVC, animated: true)
        } else if userModel?.is_certified == 2 {
            showTextToast(text: "实名认证中，请耐心等待！！", view: self.view)
        } else {
            showAlert(currentVC: self, title: "还未实名认证", meg: "修改支付密码需要实名认证,否立即去认证?", cancel: "稍后去", sure: "确定", cancelHandler: { (action) in
                
            }) { (action) in
                let realNameVC = RealNameViewController.init()
                self.navigationController?.pushViewController(realNameVC, animated: true)
            }
        }
    }
    
    deinit {
        countTimer?.invalidate()
        countTimer = nil
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
