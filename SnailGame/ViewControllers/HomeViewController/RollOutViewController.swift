//
//  RollOutViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RollOutViewController: BaseViewController , ScanResultDelegate {
   
    var outView : RollOutView?

    var walletDwnStr : String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_white")
        initNaviTitle(titleStr: "转出", titleColor: colorWithHex(hex: 0xffffff))
        initRollOutView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let str = UserDefaults.standard.string(forKey: NetWorkPort)
        let portModel = SnailDynamicFeesModel.deserialize(from: str)
        walletDwnStr = KeepSomeDecimal(num: calculateAChuyiB(a: calculateAJianB(a: BusinessEngine.init().getLinkWalletBalance(), b: portModel!.transfer!), b: TOKEN_RATIO), decimal: 2)
        
        if (Double(walletDwnStr!)!) < 0.0 {
            walletDwnStr = "0"
        }
        outView?.totalDwnLbl?.text = "（最多可转：" + walletDwnStr! + "）"
    }
    
    func initRollOutView() {
        outView = RollOutView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(outView!)
        
        outView?.scanPushBtn?.addTarget(self, action: #selector(scanPushAction), for: UIControl.Event.touchUpInside)
        
        outView?.nextStepBtn?.addTarget(self, action: #selector(nextStepAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func scanPushAction(sender:UIButton) {
        AVCaptureSessionManager.checkAuthorizationStatusForCamera(grant: {
            let scanVC = ScanViewController.init()
            scanVC.scanDelegate = self
            self.navigationController?.pushViewController(scanVC, animated: true)
        }){
            let action = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
                let url = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            })
            let con = UIAlertController(title: "权限未开启", message: "您未开启相机权限，点击确定跳转至系统设置开启", preferredStyle: UIAlertController.Style.alert)
            con.addAction(action)
            self.present(con, animated: true, completion: nil)
        }
    }
    
    func scanResultAction(result: String) {
        if result.contains("#") {
            let array = result.components(separatedBy: "#")
            outView?.addressTxtView?.palceholdertextView.text = array[0]
            outView?.addressTxtView?.plaleLabel.text = ""
            outView?.amountTxtF?.text = array[1]
        } else {
            outView?.addressTxtView?.palceholdertextView.text = result
            outView?.addressTxtView?.plaleLabel.text = ""
        }
    }
    
    @objc func nextStepAction(sender:UIButton) {
        
        if outView?.addressTxtView?.palceholdertextView.text.count == 0 {
            showTextToast(text: "请输入对方钱包地址", view: self.view)
            return
        }
        
        if isTwoDecimalPlaces(string:(outView?.amountTxtF!.text)!) == false {
            showTextToast(text: "请输入正确数量", view: self.view)
            return
        }
        
        if Double((outView?.amountTxtF!.text)!)! > Double(walletDwnStr!)! {
            showTextToast(text: "社区余额不足", view: self.view)
            return
        }
        
        if Double((outView?.amountTxtF!.text)!)! < 0.01 {
            showTextToast(text: "数量不能小于0.01", view: self.view)
            return
        }
        
        let communitySecretVC = CommunitySecretViewController.init()
        communitySecretVC.pushType = 2
        communitySecretVC.amountStr = outView?.amountTxtF!.text
        communitySecretVC.address = outView?.addressTxtView?.palceholdertextView.text
        self.navigationController?.pushViewController(communitySecretVC, animated: true)
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
