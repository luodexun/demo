//
//  DrawWalletViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DrawWalletViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var drawWalletView : DrawWalletView?
    
    var communityDwnStr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "提到钱包", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "提存记录", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initDrawWalletView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userModel = BusinessEngine.init().getLoginUserModel()
        communityDwnStr = KeepSomeDecimal(num: calculateAChuyiB(a: userModel.token!, b: TOKEN_RATIO), decimal: 2)
        drawWalletView?.totalDwnLbl?.text = "（社区余额：" + communityDwnStr! + "）"
    }
    
    func initDrawWalletView() {
        drawWalletView = DrawWalletView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 250*PROSIZE))
        self.view.addSubview(drawWalletView!)
        
        drawWalletView?.amountTxtF?.addTarget(self, action: #selector(drawTextChange), for: UIControl.Event.editingChanged)
        
        drawWalletView?.putAllBtn?.addTarget(self, action: #selector(putAllAction), for: UIControl.Event.touchUpInside)
        
        drawWalletView?.nextStepBtn?.addTarget(self, action: #selector(nextStepAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func drawTextChange(txtF:UITextField){
        if drawWalletView!.amountTxtF!.text!.count > 0 {
            drawWalletView?.nextStepBtn?.isUserInteractionEnabled = true
            drawWalletView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            drawWalletView?.nextStepBtn?.isUserInteractionEnabled = false
            drawWalletView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }

    @objc func putAllAction(sender:UIButton) {
        if Double(communityDwnStr!)! > 0 {
            drawWalletView?.amountTxtF?.text = communityDwnStr
            drawWalletView?.nextStepBtn?.isUserInteractionEnabled = true
            drawWalletView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        } else {
            showTextToast(text: "社区空空如也", view: self.view)
        }
    }
    
    @objc func nextStepAction(sender:UIButton) {
        
        if isTwoDecimalPlaces(string:(drawWalletView?.amountTxtF!.text)!) == false {
            showTextToast(text: "请输入正确数量", view: self.view)
            return
        }
        
        if Double((drawWalletView?.amountTxtF!.text)!)! > Double(communityDwnStr!)! {
            showTextToast(text: "社区余额不足", view: self.view)
            return
        }
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        let minDwn = calculateAChuyiB(a: configModel!.exchange_limit_mini!, b: TOKEN_RATIO)
        let maxDwn = calculateAChuyiB(a: (configModel?.exchange_limit_max!)!, b: TOKEN_RATIO)
        
        if calculateADayuB(a: minDwn, b: (drawWalletView?.amountTxtF!.text)!) {
            showTextToast(text: "转出数量不低于"+minDwn, view: self.view)
            return
        }
        
        if calculateADayuB(a: (drawWalletView?.amountTxtF!.text)!, b: maxDwn) {
            showTextToast(text: "转出数量不大于"+maxDwn, view: self.view)
            return
        }
        
        let walletPasswordVC = WalletPasswordViewController.init()
        walletPasswordVC.amountStr = drawWalletView?.amountTxtF!.text
        self.navigationController?.pushViewController(walletPasswordVC, animated: true)
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
