//
//  SetPauseViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SetPauseViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pushType = 1  //1.登录走 2.替换走

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    var setPauseView : SetPauseView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "设置钱包", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initSetPauseView()
    }
    
    func initSetPauseView() {
        setPauseView = SetPauseView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 452*PROSIZE))
        self.view.addSubview(setPauseView!)
        setPauseView?.createBtn?.addTarget(self, action: #selector(createPauseAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func createPauseAction(sender:UIButton) {
        showLoading(view: self.view)
        determineWalletExists()
    }
    
    func determineWalletExists() {
        let array = ArkDwnWallet.createWallet()
        let walletAddress:String = array![0] as! String
        let mnemonicWorld:String = array![1] as! String
        BusinessEngine.init().updateLinkWallet(walletAddress: walletAddress, successResponse: { (baseModel) in
            self.determineWalletExists()
        }) { (baseModel) in
            if baseModel.code == 404 {
                self.view.hideToastActivity()
                let pauseSecondVC = PauseSecondViewController.init()
                pauseSecondVC.walletAddress = walletAddress
                pauseSecondVC.mnemonicWorld = mnemonicWorld
                pauseSecondVC.pushType = self.pushType
                self.navigationController?.pushViewController(pauseSecondVC, animated: true)
            }
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
