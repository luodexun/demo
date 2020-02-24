//
//  DepositCommunityViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositCommunityViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var walletDwnStr : String?
    
    var depositView : DepositCommunityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "存入社区", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "提存记录", titleColor: colorWithHex(hex: 0x333333))
        initDepositCommunityView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let balance = BusinessEngine.init().getLinkWalletBalance()
        walletDwnStr = KeepSomeDecimal(num: calculateAChuyiB(a: balance, b: TOKEN_RATIO), decimal: 2)
        depositView?.totalDwnLbl?.text = "（钱包余额：" + walletDwnStr! + "）"
    }
    
    func initDepositCommunityView() {
        
        depositView = DepositCommunityView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 290*PROSIZE))
        self.view.addSubview(depositView!)
        
        depositView?.putAllBtn?.addTarget(self, action: #selector(putAllAction), for: UIControl.Event.touchUpInside)
        
        depositView?.amountTxtF?.addTarget(self, action: #selector(depositTextChange), for: UIControl.Event.editingChanged)
        
        depositView?.nextStepBtn?.addTarget(self, action: #selector(nextStepAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func depositTextChange(txtF:UITextField){
        if depositView!.amountTxtF!.text!.count > 0 {
            depositView?.nextStepBtn?.isUserInteractionEnabled = true
            depositView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            depositView?.nextStepBtn?.isUserInteractionEnabled = false
            depositView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    @objc func putAllAction(sender:UIButton) {
        if Double(walletDwnStr!)! > 0 {
            depositView?.amountTxtF?.text = walletDwnStr
            depositView?.nextStepBtn?.isUserInteractionEnabled = true
            depositView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        } else {
            showTextToast(text: "钱包空空如也", view: self.view)
        }
    }

    @objc func nextStepAction(sender:UIButton) {
        
        if isTwoDecimalPlaces(string:(depositView?.amountTxtF!.text)!) == false {
            showTextToast(text: "请输入正确数量", view: self.view)
            return
        }
        
        if Double((depositView?.amountTxtF!.text)!)! > Double(walletDwnStr!)! {
            showTextToast(text: "社区余额不足", view: self.view)
            return
        }
        
        if Double((depositView?.amountTxtF!.text)!)! < 1 {
            showTextToast(text: "数量不能小于1", view: self.view)
            return
        }
        
        let communitySecretVC = CommunitySecretViewController.init()
        communitySecretVC.pushType = 1
        communitySecretVC.amountStr = depositView!.amountTxtF!.text
        communitySecretVC.address = kRechareAddress
        self.navigationController?.pushViewController(communitySecretVC, animated: true)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func rightImageAction(sender: UIButton) {
        let depositRecordVC = DepositRecordViewController.init()
        self.navigationController?.pushViewController(depositRecordVC, animated: true)
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
