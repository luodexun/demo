//
//  ReleaseSayViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ReleaseSayViewController: BaseViewController {

    var sayView : ReleaseSayView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_login")
        initNaviTitle(titleStr: "发表牛说", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "发表", titleColor: colorWithHex(hex: 0x0077FF))
        initReleaseSayView()
    }
    
    func initReleaseSayView() {
        sayView = ReleaseSayView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(sayView!)
    }
    
    override func rightImageAction(sender: UIButton) {
        if sayView?.sayTextView?.palceholdertextView.text.count == 0 {
            showTextToast(text: "请输入牛说内容", view: self.view)
            return
        }
        showLoading(view: self.view)
        BusinessEngine.init().updateSpeak(speak: (sayView?.sayTextView?.palceholdertextView.text)!, successResponse: { (baseModel) in
            self.getUserInfo()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: "发表成功，等待审核", view: self.view.window!)
            self.dismiss(animated: true, completion: nil)
        }) { (BaseModel) in
            self.view.hideToastActivity()
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
