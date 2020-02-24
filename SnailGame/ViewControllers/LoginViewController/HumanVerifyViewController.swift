//
//  HumanVerifyViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/9.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import WebKit

protocol HumanVerifyDelegate {
    func humanVerifyResultAction()
}

class HumanVerifyViewController: BaseViewController {

    var verifyType : String?

    var verifyDelegate : HumanVerifyDelegate?
    
    var dwebview : DWKWebView?
    
    var loadUrlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_login")
        initNaviTitle(titleStr: "安全验证", titleColor: colorWithHex(hex: 0x333333))
        initViews()
    }
    
    func initViews() {
        
        let gameObject = GameJsApiObject.init()
        
        gameObject.humanVerifyHandel = {(result) in
            self.humanVerify(str: result)
        }
        
        dwebview = DWKWebView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(dwebview!)
        dwebview!.addJavascriptObject(gameObject, namespace: nil)
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        loadUrlStr = configModel!.web_domain! + "/index/Member/detection.html"
        dwebview!.loadUrl(loadUrlStr)
        
    }
    
    func humanVerify(str:String) {
        BusinessEngine.init().humanVerify(type: verifyType!, sign: str, successResponse: { (BaseModel) in
            self.verifyDelegate?.humanVerifyResultAction()
            self.dismiss(animated: true, completion: nil)
        }) { (BaseModel) in
            self.dwebview!.loadUrl(self.loadUrlStr)
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    override func naviBackAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
