//
//  LoginViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController , HumanVerifyDelegate {

    var loginView : LoginView?

    var regionCode = "86"
    
    var countTimer : Timer?

    var totalCount : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_login")
        initNaviTitle(titleStr: "登录", titleColor: colorWithHex(hex: 0x333333))
        initLoginView()
    }
    
    func initLoginView() {
        loginView = LoginView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44-SAFE_BOTTOM))
        self.view.addSubview(loginView!)
        
        let codeTap = UITapGestureRecognizer.init(target: self, action: #selector(sendCodeAction))
        loginView?.getCodeLbl?.isUserInteractionEnabled = true
        loginView?.getCodeLbl?.addGestureRecognizer(codeTap)
        
        loginView?.phoneTxtF?.addTarget(self, action: #selector(loginTextChange), for: UIControl.Event.editingChanged)
        
        loginView?.codeTxtF?.addTarget(self, action: #selector(loginTextChange), for: UIControl.Event.editingChanged)
        
        loginView?.regionChooseBtn?.addTarget(self, action: #selector(chooseRegionAction), for: UIControl.Event.touchUpInside)
        
        loginView?.loginBtn?.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
        
        loginView?.registerBtn?.addTarget(self, action: #selector(registerAction), for: UIControl.Event.touchUpInside)

    }
    
    @objc func sendCodeAction(tap:UIGestureRecognizer) {
        
        if loginView?.phoneTxtF?.text?.count == 0 {
            showTextToast(text: "请输入手机号", view: self.view)
            return
        }
        
        if isMobilePhone(regionCode: regionCode, phoneStr: (loginView?.phoneTxtF!.text)!) == false {
            showTextToast(text: "请输入正确手机号", view: self.view)
            return
        }
        
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "sendCode"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction()  {
        loginView?.getCodeLbl?.isUserInteractionEnabled = false
        BusinessEngine.init().sendCode(mobile: (loginView?.phoneTxtF!.text)!, type: "verifyLogin", region: regionCode, successResponse: { (BaseModel) in
            showTextToast(text: "发送成功", view: self.view)
            self.totalCount = 60
            self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
            self.countTimer!.fire()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
            self.loginView?.getCodeLbl?.isUserInteractionEnabled = true
        }
    }
    
    @objc func countDownAction(sender:Timer){
        if totalCount == 1 {
            loginView?.getCodeLbl?.isUserInteractionEnabled = true
            loginView?.getCodeLbl?.text = "获取验证码"
            countTimer?.invalidate()
            countTimer = nil
        } else {
            totalCount! -= 1
            loginView?.getCodeLbl?.text = String(totalCount!)+"s"
        }
    }
    
    @objc func chooseRegionAction(sender:UIButton) {
        let regionView : RegionSelectView = RegionSelectView.init()
        regionView.show()
        regionView.regionSelectHandel = {(name,code) in
            self.loginView?.regionCodeLbl?.text = "+"+code
            self.regionCode = code
        }
    }
    
    @objc func loginAction(sender:UIButton) {
        showLoading(view: self.view)
        BusinessEngine.init().sendCodeLogin(mobile: loginView!.phoneTxtF!.text!, code: (loginView?.codeTxtF!.text)!, region: regionCode, successResponse: { (BaseModel) in
            self.getUserInfo()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let userModel : UserLoginModel = BaseModel as! UserLoginModel
            if userModel.data?.status == 1 || userModel.data?.status == 2 {
                let registerPayVC = RegisterPayViewController.init()
                self.navigationController?.pushViewController(registerPayVC, animated: true)
            } else if userModel.data?.status == 3 {
                let setPauseVC = SetPauseViewController.init()
                self.navigationController?.pushViewController(setPauseVC, animated: true)
            } else {
                self.updateLinkWallet(walletAddress: userModel.data!.wallet_address!)
            }
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func updateLinkWallet(walletAddress:String) {
        BusinessEngine.init().updateLinkWallet(walletAddress: walletAddress, successResponse: { (BaseModel) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }) { (BaseModel) in
            if BaseModel.code == 404 {
                self.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                self.view.hideToastActivity()
                showTextToast(text: BaseModel.message!, view: self.view)
            }
        }
    }
    
    @objc func registerAction(sender:UIButton) {
        let regionVC = RegionChooseViewController.init()
        self.navigationController?.pushViewController(regionVC, animated: true)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func loginTextChange(txtF:UITextField){
        if isMobilePhone(regionCode: regionCode, phoneStr: (loginView?.phoneTxtF!.text)!) && loginView?.codeTxtF?.text?.count != 0 {
            loginView?.loginBtn?.isUserInteractionEnabled = true
            loginView?.loginBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            loginView?.loginBtn?.isUserInteractionEnabled = false
            loginView?.loginBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
