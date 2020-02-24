//
//  RegisterPayViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegisterPayViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    var registerPayView : RegisterPayView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "设置支付密码", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initRegisterPayView()
    }
    
    func initRegisterPayView() {
        registerPayView = RegisterPayView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT))
        self.view.addSubview(registerPayView!)
        
        registerPayView?.payPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        registerPayView?.againPwdTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        
        registerPayView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func payTextChange(txtF:UITextField) {
        if (registerPayView?.payPwdTxtF!.text!.count)! > 5 && (registerPayView?.againPwdTxtF!.text!.count)! > 5 {
            registerPayView?.submitBtn?.isUserInteractionEnabled = true
            registerPayView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            registerPayView?.submitBtn?.isUserInteractionEnabled = false
            registerPayView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    @objc func submitAction(sender:UIButton) {
        if registerPayView?.payPwdTxtF!.text != registerPayView?.againPwdTxtF!.text  {
            showTextToast(text: "两次输入不一样", view: self.view)
            return
        }
        
        showLoading(view: self.view)
        let param = NSMutableDictionary.init()
        param.setValue(registerPayView?.payPwdTxtF!.text, forKey: "pay_password")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
            let setPauseVC = SetPauseViewController.init()
            self.navigationController?.pushViewController(setPauseVC, animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
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
