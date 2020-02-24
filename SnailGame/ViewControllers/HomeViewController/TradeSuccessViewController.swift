//
//  TradeSuccessViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/15.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TradeSuccessViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviTitle(titleStr: "转出", titleColor: UIColor.white)
        initViews()
    }
    
    func initViews() {
        
        let icon = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-40*PROSIZE)/2, y: STABAR_HEIGHT+44+52*PROSIZE, width: 40*PROSIZE, height: 40*PROSIZE))
        icon.image = UIImage.init(named: "ic_trade_success")
        self.view.addSubview(icon)
        
        let successTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: icon.frame.origin.y+icon.frame.size.height+16*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 16*PROSIZE))
        successTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        successTitleLbl.textColor = colorWithHex(hex: 0xFF0F59)
        successTitleLbl.textAlignment = NSTextAlignment.center
        successTitleLbl.text = "交易提交成功！"
        self.view.addSubview(successTitleLbl)
        
        let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: successTitleLbl.frame.origin.y+successTitleLbl.frame.size.height+9*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 14*PROSIZE))
        promptTitleLbl.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        promptTitleLbl.textColor = colorWithHex(hex: 0x999999)
        promptTitleLbl.textAlignment = NSTextAlignment.center
        promptTitleLbl.text = "实际到账会因网络等原因延迟3-10分钟。"
        self.view.addSubview(promptTitleLbl)
        
        let doneBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        doneBtn.frame = CGRect.init(x: 20*PROSIZE, y: promptTitleLbl.frame.origin.y+promptTitleLbl.frame.size.height+41*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 36*PROSIZE)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        doneBtn.setTitle("完成", for: UIControl.State.normal)
        doneBtn.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        doneBtn.addTarget(self, action: #selector(doneAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(doneBtn)
    }
    
    @objc func doneAction(sender:UIButton) {
        for (_,controller) in (self.navigationController?.viewControllers.enumerated())! {
            if controller.isKind(of: WalletDetailViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
