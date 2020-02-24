//
//  RealNameViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RealNameViewController: BaseViewController , HumanVerifyDelegate {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var realView : RealNameView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "实名认证", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initRealNameView()
    }
    
    func initRealNameView() {
        realView = RealNameView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44-10*PROSIZE))
        self.view.addSubview(realView!)
        realView?.userNameTxtF?.addTarget(self, action: #selector(realTextChange), for: UIControl.Event.editingChanged)
        realView?.userNumTxtF?.addTarget(self, action: #selector(realTextChange), for: UIControl.Event.editingChanged)
        realView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        
    }
    
    @objc func submitAction(sender:UIButton) {
        let  humanVerifyVC = HumanVerifyViewController.init()
        humanVerifyVC.verifyType = "idCardVerify"
        humanVerifyVC.verifyDelegate = self
        self.navigationController?.present(humanVerifyVC, animated: true, completion: nil)
    }
    
    func humanVerifyResultAction() {
        showLoading(view: self.view)
        BusinessEngine.init().usernameVerify(userName: (realView?.userNameTxtF!.text)!, idCard: (realView?.userNumTxtF!.text)!, successResponse: { (baseModel) in
            self.getUserInfo()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            self.navigationController?.popViewController(animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func realTextChange(txtF:UITextField){
        if realView?.userNameTxtF?.text?.count != 0 && (realView?.userNumTxtF?.text!.count)! > 10 {
            realView?.submitBtn?.isUserInteractionEnabled = true
            realView?.submitBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            realView?.submitBtn?.isUserInteractionEnabled = false
            realView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
