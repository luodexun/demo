//
//  RegisterPhoneViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegisterPhoneViewController: BaseViewController , HumanVerifyDelegate {

    var registerView : RegisterPhoneView?
    
    var isCheck : Bool = false

    var regionCode : String?
    
    var countTimer : Timer?

    var totalCount : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "注册", titleColor: colorWithHex(hex: 0x333333))
        initRegisterPhoneView()
        registerView?.regionCodeLbl?.text = "+"+regionCode!
    }
    
    func initRegisterPhoneView() {
        registerView = RegisterPhoneView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-SAFE_BOTTOM-44))
        self.view.addSubview(registerView!)
        
        registerView?.phoneTxtF?.addTarget(self, action: #selector(registerTextChange), for: UIControl.Event.editingChanged)
        
        registerView?.codeTxtF?.addTarget(self, action: #selector(registerTextChange), for: UIControl.Event.editingChanged)
        
        registerView?.inviteTxtF?.addTarget(self, action: #selector(registerTextChange), for: UIControl.Event.editingChanged)
        
        registerView?.regionChooseBtn?.addTarget(self, action: #selector(regionChooseAction), for: UIControl.Event.touchUpInside)
        
        let codeTap = UITapGestureRecognizer.init(target: self, action: #selector(getCodeAction))
        registerView?.getCodeLbl?.isUserInteractionEnabled = true
        registerView?.getCodeLbl?.addGestureRecognizer(codeTap)
        
        registerView?.registerBtn?.addTarget(self, action: #selector(registerAction), for: UIControl.Event.touchUpInside)
        
        registerView?.checkBtn?.addTarget(self, action: #selector(checkAction), for: UIControl.Event.touchUpInside)
        
        registerView?.agreementBtn?.addTarget(self, action: #selector(agreementAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func regionChooseAction(sender:UIButton) {
        let regionView : RegionSelectView = RegionSelectView.init()
        regionView.show()
        regionView.regionSelectHandel = {(name,code) in
            self.registerView?.regionCodeLbl?.text = "+"+code
            self.regionCode = code
        }
    }
    
    @objc func getCodeAction(tap:UIGestureRecognizer) {
        
        if registerView?.phoneTxtF?.text?.count == 0 {
            showTextToast(text: "请输入手机号", view: self.view)
            return
        }
        
        if isMobilePhone(regionCode: regionCode!, phoneStr: (registerView?.phoneTxtF!.text)!) == false {
            showTextToast(text: "请输入正确手机号", view: self.view)
            return
        }
        
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "sendCode"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction()  {
        registerView?.getCodeLbl?.isUserInteractionEnabled = false
        BusinessEngine.init().sendCode(mobile: (registerView?.phoneTxtF!.text)!, type: "userRegister", region: regionCode!, successResponse: { (BaseModel) in
            self.totalCount = 60
            self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
            self.countTimer!.fire()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
            self.registerView?.getCodeLbl?.isUserInteractionEnabled = true
        }
    }
    
    @objc func countDownAction(sender:Timer){
        if totalCount == 1 {
            registerView?.getCodeLbl?.isUserInteractionEnabled = true
            registerView?.getCodeLbl?.text = "获取验证码"
            countTimer?.invalidate()
            countTimer = nil
        } else {
            totalCount! -= 1
            registerView?.getCodeLbl?.text = String(totalCount!)+"s"
        }
    }
    
    @objc func registerAction(sender:UIButton) {
        
        if isCheck == false {
            showTextToast(text: "请同意用户注册协议", view: self.view)
            return
        }
        
        var refer = ""
        if registerView?.inviteTxtF!.text != nil {
            refer = (registerView?.inviteTxtF!.text)!
        }
        showLoading(view: self.view)
        BusinessEngine.init().register(mobile: (registerView?.phoneTxtF!.text)!, code: (registerView?.codeTxtF!.text)!, referrer: refer, successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let registerDataVC = RegisterDataViewController.init()
            self.navigationController?.pushViewController(registerDataVC, animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
//    func getUserInfo() {
//        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
//            self.view.hideToastActivity()
//            let userModel : UserLoginModel = BaseModel as! UserLoginModel
//            if userModel.data?.status == 1 || userModel.data?.status == 2 {
//                let registerPayVC = RegisterPayViewController.init()
//                self.navigationController?.pushViewController(registerPayVC, animated: true)
//            } else if userModel.data?.status == 3 {
//                let setPauseVC = SetPauseViewController.init()
//                self.navigationController?.pushViewController(setPauseVC, animated: true)
//            } else {
//                self.navigationController?.dismiss(animated: true, completion: nil)
//            }
//        }) { (BaseModel) in
//            self.view.hideToastActivity()
//            showTextToast(text: BaseModel.message!, view: self.view)
//        }
//    }
    
    @objc func checkAction(sender:UIButton) {
        if isCheck {
            registerView?.checkBtn?.setImage(UIImage.init(named: "ic_register_check_nol"), for: UIControl.State.normal)
            isCheck = false
        } else {
            registerView?.checkBtn?.setImage(UIImage.init(named: "ic_register_check_sel"), for: UIControl.State.normal)
            isCheck = true
        }
    }
    
    @objc func agreementAction(sender:UIButton) {
        
    }
    
    @objc func registerTextChange(sender:UIButton) {
        if isMobilePhone(regionCode: "86", phoneStr: (registerView?.phoneTxtF!.text)!) && registerView?.codeTxtF?.text?.count != 0 {
            registerView?.registerBtn?.isUserInteractionEnabled = true
            registerView?.registerBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            registerView?.registerBtn?.isUserInteractionEnabled = false
            registerView?.registerBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
