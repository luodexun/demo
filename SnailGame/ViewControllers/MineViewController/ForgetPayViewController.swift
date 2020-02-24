//
//  ForgetPayViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ForgetPayViewController: BaseViewController , HumanVerifyDelegate {
    
    var forgetView : ForgetPayView?
    
    var userModel : UserLoginDataModel?
    
    var countTimer : Timer?

    var totalCount : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "身份验证", titleColor: colorWithHex(hex: 0x333333))
        userModel = BusinessEngine.init().getLoginUserModel()
        initForgetPayView()
    }
    
    func initForgetPayView() {
        
        forgetView = ForgetPayView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 160*PROSIZE ))
        self.view.addSubview(forgetView!)
        
        let codeTap = UITapGestureRecognizer.init(target: self, action: #selector(sendCodeAction))
        forgetView?.getCodeLbl?.isUserInteractionEnabled = true
        forgetView?.getCodeLbl?.addGestureRecognizer(codeTap)
        
        forgetView?.codeTxtF?.addTarget(self, action: #selector(forgetTextChange), for: UIControl.Event.editingChanged)
        
        forgetView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
    }
   
    @objc func sendCodeAction (tap:UIGestureRecognizer) {
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "sendCode"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction() {
        forgetView?.getCodeLbl?.isUserInteractionEnabled = false
        BusinessEngine.init().sendCode(mobile: (userModel?.mobile!)!, type: "authentication", region: (userModel?.region!)!, successResponse: { (BaseModel) in
            showTextToast(text: "发送成功", view: self.view)
            self.totalCount = 60
            self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
            self.countTimer!.fire()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
            self.forgetView?.getCodeLbl?.isUserInteractionEnabled = true
        }
    }
    
    @objc func countDownAction(sender:Timer){
        if totalCount == 1 {
            forgetView?.getCodeLbl?.isUserInteractionEnabled = true
            forgetView?.getCodeLbl?.text = "获取验证码"
            countTimer?.invalidate()
            countTimer = nil
        } else {
            totalCount! -= 1
            forgetView?.getCodeLbl?.text = String(totalCount!)+"s"
        }
    }
    
    @objc func submitAction(sender:UIButton) {
        showLoading(view: self.view)
        BusinessEngine.init().checkCode(type: "authentication", verifyCode: (forgetView?.codeTxtF!.text)!, mobile: (userModel?.mobile!)!, successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let updatePayVC = UpdatePayViewController.init()
            self.navigationController?.pushViewController(updatePayVC, animated: true)
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    @objc func forgetTextChange(txtF:UITextField){
        if forgetView?.codeTxtF?.text?.count != 0  {
            forgetView?.submitBtn?.isUserInteractionEnabled = true
            forgetView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            forgetView?.submitBtn?.isUserInteractionEnabled = false
            forgetView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
