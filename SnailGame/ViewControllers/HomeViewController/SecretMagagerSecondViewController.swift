//
//  SecretMagagerSecondViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SecretMagagerSecondViewController: BaseViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var paySecretTxtView : SnailTextView?
    
    var userModel:UserLoginDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviTitle(titleStr: "助记词管理", titleColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_white")
        userModel = BusinessEngine.init().getLoginUserModel()
        setUpViews()
    }
    
    @objc func saveAction(sender:UIButton) {
        if paySecretTxtView?.palceholdertextView.text.count == 0 {
            showTextToast(text: "请填写您的助记词", view: self.view)
            return
        }
        let address = ArkDwnWallet.getAddressFromPassparse(paySecretTxtView?.palceholdertextView.text)
        if BusinessEngine.init().getLoginUserModel().wallet_address != address {
            showTextToast(text: "钱包密钥不正确", view: self.view)
            return
        }
        let payDialog = PayCheckDialog.init()
        payDialog.show()
        payDialog.payCheckSuccessHandel = {(payStr) in
            let secretKey = upUser_mnemonic_encrypt(wordStr: (self.paySecretTxtView?.palceholdertextView.text)!, keyStr: payStr)
            SSKeychain.setPassword(secretKey, forService: Bundle.main.bundleIdentifier, account: self.userModel?.mobile)
            let magagerThirdVC = SecretMagagerThirdViewController.init()
            self.navigationController?.pushViewController(magagerThirdVC, animated: true)
            self.removeCurrentVeiw()
        }
    }
    
    func removeCurrentVeiw() {
        let array = NSMutableArray.init()
        for (_,item) in self.navigationController!.viewControllers.enumerated() {
            if !((item is SecretMagagerSecondViewController) || (item is SecretMagagerFirstViewController)) {
                array.add(item)
            }
        }
        self.navigationController?.viewControllers = array as! [UIViewController]
    }
    
    func setUpViews() {
        
        let barView = UIView.init(frame: CGRect.init(x: 18*PROSIZE, y: STABAR_HEIGHT+44+32*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 120*PROSIZE))
        self.view.addSubview(barView)
        
        let barIcon = UIImageView.init(frame: barView.bounds)
        barIcon.image = UIImage.init(named: "ic_secret_manager_bar")
        barView.addSubview(barIcon)
        
        paySecretTxtView = SnailTextView.init(placeholder: "请填写您的助记词", placeholderColor: colorWithHex(hex: 0x999999), frame: barView.bounds)
        paySecretTxtView?.backgroundColor = UIColor.init(white: 255/255.0, alpha: 0.0)
        paySecretTxtView?.palceholdertextView.textColor = colorWithHex(hex: 0x333333)
        paySecretTxtView?.isShowCountLabel = false
        paySecretTxtView?.palceholdertextView.backgroundColor = UIColor.init(white: 255/255.0, alpha: 0.0)
        barView.addSubview(paySecretTxtView!)
        
        let saveBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        saveBtn.frame = CGRect.init(x: 18*PROSIZE, y: barView.frame.origin.y+barView.frame.size.height+48*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 46*PROSIZE)
        saveBtn.setTitle("保存在本地", for: UIControl.State.normal)
        saveBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        saveBtn.backgroundColor = colorWithHex(hex: 0x333333)
        saveBtn.layer.cornerRadius = 5
        saveBtn.layer.masksToBounds = true
        self.view.addSubview(saveBtn)
        
        let titleStr = "保存后，只能方便您查看与使用，不能代替您在纸文本上的保存。请牢记您的助记词。当您卸载客户端，本地的助记词将被清空"
        
        let secretTitleLbl = UILabel.init(frame: CGRect.init(x: 18*PROSIZE, y: saveBtn.frame.origin.y+saveBtn.frame.size.height+10*PROSIZE, width: SCREEN_WIDE-36*PROSIZE, height: 80*PROSIZE))
        secretTitleLbl.font = UIFont.boldSystemFont(ofSize: 14*PROSIZE)
        secretTitleLbl.textColor = colorWithHex(hex: 0x333333)
        secretTitleLbl.numberOfLines = 0
        self.view.addSubview(secretTitleLbl)
        
        let secretPromptStr = NSMutableAttributedString.init(string: titleStr)
        secretPromptStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x999999), range:NSRange.init(location:0, length: 29))
        secretTitleLbl.attributedText = secretPromptStr
    
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
