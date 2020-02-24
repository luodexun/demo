//
//  ReplacePurseViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ReplacePurseViewController: BaseViewController , HumanVerifyDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var replaceView : ReplacePurseView?
    
    var countTimer : Timer?

    var totalCount : Int?
    
    var userModel : UserLoginDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviTitle(titleStr: "替换钱包", titleColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_white")
        userModel = BusinessEngine.init().getLoginUserModel()
        initReplacePurseView()
    }
    
    func initReplacePurseView() {
        replaceView = ReplacePurseView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(replaceView!)
        
        let codeTap = UITapGestureRecognizer.init(target: self, action: #selector(sendCodeAction))
        replaceView?.getCodeLbl?.isUserInteractionEnabled = true
        replaceView?.getCodeLbl?.addGestureRecognizer(codeTap)
        
        replaceView?.codeTxtF?.addTarget(self, action: #selector(replaceTextChange), for: UIControl.Event.editingChanged)
        
        replaceView?.payPwdTxtF?.addTarget(self, action: #selector(replaceTextChange), for: UIControl.Event.editingChanged)
    
        replaceView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func sendCodeAction(tap:UIGestureRecognizer) {
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "sendCode"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction() {
        replaceView?.getCodeLbl?.isUserInteractionEnabled = false
        BusinessEngine.init().sendCode(mobile: userModel!.mobile!, type: "authentication", region: userModel!.region!, successResponse: { (BaseModel) in
            showTextToast(text: "发送成功", view: self.view)
            self.totalCount = 60
            self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
            self.countTimer!.fire()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
            self.replaceView?.getCodeLbl?.isUserInteractionEnabled = true
        }
    }
    
    @objc func countDownAction(sender:Timer){
        if totalCount == 1 {
            replaceView?.getCodeLbl?.isUserInteractionEnabled = true
            replaceView?.getCodeLbl?.text = "获取验证码"
            countTimer?.invalidate()
            countTimer = nil
        } else {
            totalCount! -= 1
            replaceView?.getCodeLbl?.text = String(totalCount!)+"s"
        }
    }
    
    @objc func submitAction(sender:UIButton) {
        showLoading(view: self.view)
        BusinessEngine.init().checkCode(type: "authentication", verifyCode: (replaceView?.codeTxtF!.text)!, mobile: (userModel?.mobile!)!, successResponse: { (baseModel) in
            self.payVerfy()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func payVerfy() {
        BusinessEngine.init().payVerify(code: (replaceView?.payPwdTxtF!.text)!, successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let setPauseVC = SetPauseViewController.init()
            setPauseVC.pushType = 2
            self.navigationController?.pushViewController(setPauseVC, animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func replaceTextChange(txtF:UITextField){
        if replaceView?.codeTxtF?.text?.count != 0 && (replaceView?.payPwdTxtF?.text!.count)! > 5 {
            replaceView?.submitBtn?.isUserInteractionEnabled = true
            replaceView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            replaceView?.submitBtn?.isUserInteractionEnabled = false
            replaceView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
