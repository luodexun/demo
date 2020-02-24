//
//  CustomerServiceViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CustomerServiceViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var serviceView : CustomerServiceView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "联系客服", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initCustomerServiceView()
    }
    
    func initCustomerServiceView() {
        serviceView = CustomerServiceView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(serviceView!)
        
        serviceView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func submitAction(sender:UIButton) {
        if serviceView?.noteTxtView?.palceholdertextView.text.count == 0 {
            showTextToast(text: "请输入留言", view: self.view)
            return
        }
        showLoading(view: self.view)
        BusinessEngine.init().submitMsg(msg: (serviceView?.noteTxtView?.palceholdertextView.text)!, successResponse: { (baseModel) in
            self.serviceView?.noteTxtView?.palceholdertextView.text = ""
            self.serviceView?.noteTxtView?.plaleLabel.text = "请输入留言"
            self.view.hideToastActivity()
            showTextToast(text: "留言提交成功", view: self.view)
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
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
