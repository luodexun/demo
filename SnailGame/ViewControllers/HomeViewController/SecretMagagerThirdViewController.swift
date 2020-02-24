//
//  SecretMagagerThirdViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SecretMagagerThirdViewController: BaseViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var magagerThirdView : SecretMagagerThirdView?
    
    var hintStr = " *** *** *** *** *** *** \n *** *** *** *** *** *** "
    
    var userModel : UserLoginDataModel?
    
    var secretStr : String?
    
    var isLook = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviTitle(titleStr: "助记词管理", titleColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_white")
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initSecretMagagerThirdView()
        userModel = BusinessEngine.init().getLoginUserModel()
        secretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: self.userModel?.mobile)
    }
    
    func initSecretMagagerThirdView() {
        magagerThirdView = SecretMagagerThirdView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(magagerThirdView!)
        
        magagerThirdView?.mnemonicLbl?.text = hintStr
        
        magagerThirdView?.eyeBtn?.addTarget(self, action: #selector(eyeAction), for: .touchUpInside)
        
        magagerThirdView?.clearBtn?.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        
    }
    
    @objc func eyeAction(sender:UIButton) {
        if isLook {
            isLook = false
            magagerThirdView?.eyeIcon?.image = UIImage.init(named: "icon_home_eye_nol")
            magagerThirdView?.mnemonicLbl?.text = hintStr
        } else {
            let payDialog = PayCheckDialog.init()
            payDialog.show()
            payDialog.payCheckSuccessHandel = {(payStr) in
                self.isLook = true
                self.magagerThirdView?.eyeIcon?.image = UIImage.init(named: "icon_home_eye_sel")
                let mnemonic = downUser_mnemonic_decrypt(wordStr: self.secretStr!, keyStr: payStr)
                self.magagerThirdView?.mnemonicLbl?.text = mnemonic
            }
        }
    }
    
    @objc func clearAction(sender:UIButton) {
        showAlert(currentVC: self, title: "删除本地助记词", meg: "确定要删除本地助记词吗？", cancel: "取消", sure: "确定", cancelHandler: { (action) in
            
        }) { (action) in
            SSKeychain.deletePassword(forService: Bundle.main.bundleIdentifier, account: self.userModel?.mobile)
            let magagerFirstVC = SecretMagagerFirstViewController.init()
            self.navigationController?.pushViewController(magagerFirstVC, animated: true)
            self.removeCurrentVeiw()
        }
    }
    
    func removeCurrentVeiw() {
        let array = NSMutableArray.init()
        for (_,item) in self.navigationController!.viewControllers.enumerated() {
            if !(item is SecretMagagerThirdViewController) {
                array.add(item)
            }
        }
        self.navigationController?.viewControllers = array as! [UIViewController]
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
