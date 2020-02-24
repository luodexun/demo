//
//  CommunitySecretViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CommunitySecretViewController: BaseViewController {

    var pushType : Int? // 1.存入社区 2.转出给他人
    
    var secretView : CommunitySecretView?
    
    var amountStr : String?
    
    var address : String?
    
    var userModel:UserLoginDataModel?
    
    var ischeck = false
    
    var keyStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "密钥输入", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initCommunitySecretView()
        userModel = BusinessEngine.init().getLoginUserModel()
        
        secretView?.walletAddressLbl?.text = address
        if pushType == 1 {
            secretView?.dwnTitleLbl?.text = "数量（DWN）"
            secretView?.dwnNumLbl?.text = amountStr
            secretView?.noteContentLbl?.text = "存入到社区"
        } else {
            secretView?.dwnTitleLbl?.text = "数量/费用（DWN）"
            let str = UserDefaults.standard.string(forKey: NetWorkPort)
            let portModel = SnailDynamicFeesModel.deserialize(from: str)
            let transferStr = calculateAChuyiB(a: portModel!.transfer!, b: TOKEN_RATIO)
            secretView?.dwnNumLbl?.text = amountStr! + " / " + transferStr
            secretView?.noteContentLbl?.text = "--"
        }
        
        let secretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: userModel?.mobile)
        if secretStr != nil {
            ischeck = true
            secretView?.saveView?.isHidden = true
            secretView?.clearView?.isHidden = false
        } else {
           ischeck = false
            secretView?.saveView?.isHidden = false
            secretView?.clearView?.isHidden = true
        }
    }
    
    func initCommunitySecretView() {
        secretView = CommunitySecretView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 506*PROSIZE))
        self.view.addSubview(secretView!)
        
        secretView?.saveView?.saveSecretBtn?.addTarget(self, action: #selector(saveSecretAction), for: .touchUpInside)
        
        secretView?.clearView?.useSecretBtn?.addTarget(self, action: #selector(useSecretAction), for: .touchUpInside)
        
        secretView?.clearView?.clearSecretBtn?.addTarget(self, action: #selector(clearSecretAction), for: .touchUpInside)
        
        secretView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func saveSecretAction(sender:UIButton) {
        if ischeck {
            ischeck = false
            secretView?.saveView?.saveSecretBtn?.setImage(UIImage.init(named: "ic_community_secret_save_nol"), for: .normal)
        } else {
            if secretView?.paySecretTxtView?.palceholdertextView.text.count == 0 {
                showTextToast(text: "请输入钱包助记词", view: self.view)
                return
            }
            let payDialog = PayCheckDialog.init()
            payDialog.show()
            payDialog.payCheckSuccessHandel = {(payStr) in
                self.keyStr = payStr
                self.ischeck = true
                self.secretView?.saveView?.saveSecretBtn?.setImage(UIImage.init(named: "ic_community_secret_save_sel"), for: .normal)
            }
        }
    }
    
    @objc func useSecretAction(sender:UIButton) {
        let payDialog = PayCheckDialog.init()
        payDialog.show()
        payDialog.payCheckSuccessHandel = {(payStr) in
            let secretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: self.userModel?.mobile)
            let mnemonic = downUser_mnemonic_decrypt(wordStr: secretStr!, keyStr: payStr)
            self.secretView?.paySecretTxtView?.palceholdertextView.text = mnemonic
            self.secretView?.paySecretTxtView?.placeholderGlobal = ""
        }
    }
    
    @objc func clearSecretAction(sender:UIButton) {
        showAlert(currentVC: self, title: "删除本地助记词", meg: "确定要删除本地助记词吗？", cancel: "取消", sure: "确定", cancelHandler: { (action) in
            
        }) { (action) in
            self.secretView?.paySecretTxtView?.palceholdertextView.text = ""
            self.ischeck = false
            self.secretView?.saveView?.saveSecretBtn?.setImage(UIImage.init(named: "ic_community_secret_save_nol"), for: .normal)
            self.secretView?.saveView?.isHidden = false
            self.secretView?.clearView?.isHidden = true
            SSKeychain.deletePassword(forService: Bundle.main.bundleIdentifier, account: self.userModel?.mobile)
        }
    }
    
    @objc func submitAction(sender:UIButton) {
        if secretView?.paySecretTxtView?.palceholdertextView.text.count == 0 {
            showTextToast(text: "请输入钱包密钥", view: self.view)
            return
        }
        
        let address = ArkDwnWallet.getAddressFromPassparse(secretView?.paySecretTxtView?.palceholdertextView.text)
        if BusinessEngine.init().getLoginUserModel().wallet_address != address {
            showTextToast(text: "钱包密钥不正确", view: self.view)
            return
        }
        showLoading(view: self.view)
        if pushType == 1 {
            recharge()
        } else {
            transfer()
        }
    }
    
    func recharge() {
        BusinessEngine.init().recharge(num: amountStr!, successResponse: { (BaseModel) in
            let rechargeModel:RechargeModel = BaseModel as! RechargeModel
            self.createTransation(rechargeId: rechargeModel.data!.id!)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func createTransation(rechargeId:String) {
        
        let str = UserDefaults.standard.string(forKey: NetWorkPort)
        let portModel = SnailDynamicFeesModel.deserialize(from: str)
        let amount = calculateAJianB(a: calculateAChengyiB(a: amountStr!, b: TOKEN_RATIO), b: portModel!.transfer!)
        let result = ArkDwnWallet.createTransation(address, withIp: portModel?.ip, withSecretKey: secretView?.paySecretTxtView?.palceholdertextView.text, amount: Int(amount)!, vendorField: "存入到社区")
        if result == nil {
            self.view.hideToastActivity()
            showTextToast(text: "存入失败", view: self.view)
            return
        }
        
        let dict : NSDictionary = getDictionaryFromJSONString(jsonString: result!)
        let accept : NSDictionary = dict["data"] as! NSDictionary
        let acceptArray : NSArray = accept["accept"]! as! NSArray
        
        if acceptArray.count == 0 {
            self.view.hideToastActivity()
            showTextToast(text: "存入失败", view: self.view)
            return
        }
        
        BusinessEngine.init().rechargeUpdate(r_id: rechargeId, t_id: acceptArray[0] as! String, successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            if self.ischeck == true {
                self.saveSecretToLocal()
            }
            showTextToast(text: BaseModel.message!, view: self.view.window!)
            self.navigationController?.popToRootViewController(animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func transfer() {
        let str = UserDefaults.standard.string(forKey: NetWorkPort)
        let portModel = SnailDynamicFeesModel.deserialize(from: str)
        let amount = calculateAChengyiB(a: amountStr!, b: TOKEN_RATIO)
        let result = ArkDwnWallet.createTransation(address, withIp: portModel?.ip, withSecretKey: secretView?.paySecretTxtView?.palceholdertextView.text, amount: Int(amount)!, vendorField: "")
        if result == nil {
            self.view.hideToastActivity()
            showTextToast(text: "交易失败", view: self.view)
            return
        }
        
        let dict : NSDictionary = getDictionaryFromJSONString(jsonString: result!)
        let accept : NSDictionary = dict["data"] as! NSDictionary
        let acceptArray : NSArray = accept["accept"]! as! NSArray
        
        if acceptArray.count == 0 {
            self.view.hideToastActivity()
            showTextToast(text: "交易失败", view: self.view)
            return
        }
        self.view.hideToastActivity()
        if self.ischeck == true {
            saveSecretToLocal()
        }
        let tradeSuccessVC = TradeSuccessViewController.init()
        self.navigationController?.pushViewController(tradeSuccessVC, animated: true)
    }
    
    func saveSecretToLocal() {
        let secretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: userModel?.mobile)
        if secretStr == nil {
            secretView?.saveView?.isHidden = true
            secretView?.clearView?.isHidden = false
            let secretKey = upUser_mnemonic_encrypt(wordStr: (secretView?.paySecretTxtView?.palceholdertextView.text)!, keyStr: keyStr)
            SSKeychain.setPassword(secretKey, forService: Bundle.main.bundleIdentifier, account: userModel?.mobile)
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
