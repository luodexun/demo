//
//  WalletPasswordViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class WalletPasswordViewController: BaseViewController , HumanVerifyDelegate {
   
    var amountStr : String?
    
    var passwordView : WalletPasswordView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "提到钱包", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initWalletPasswordView()
        
        passwordView?.dwnNumLbl?.text = amountStr
        passwordView?.walletAddressLbl?.text = BusinessEngine.init().getLoginUserModel().wallet_address
    }
    
    func initWalletPasswordView() {
        passwordView = WalletPasswordView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 390*PROSIZE))
        self.view.addSubview(passwordView!)
        
        passwordView?.payTxtF?.addTarget(self, action: #selector(passwordTextChange), for: UIControl.Event.editingChanged)
        
        passwordView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func passwordTextChange(txtF:UITextField){
        if passwordView!.payTxtF!.text!.count > 0 {
            passwordView?.submitBtn?.isUserInteractionEnabled = true
            passwordView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            passwordView?.submitBtn?.isUserInteractionEnabled = false
            passwordView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    @objc func submitAction(sender:UIButton) {
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "exchange"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction()  {
        showLoading(view: self.view)
        BusinessEngine.init().payVerify(code: (passwordView?.payTxtF!.text)!, successResponse: { (BaseModel) in
            self.mentionMoney()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func mentionMoney() {
        BusinessEngine.init().mentionMoney(num: amountStr!, address: BusinessEngine.init().getLoginUserModel().wallet_address!, remark: "提出到钱包", successResponse: { (BaseModel) in
            self.getUserInfo()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            self.navigationController?.popToRootViewController(animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
