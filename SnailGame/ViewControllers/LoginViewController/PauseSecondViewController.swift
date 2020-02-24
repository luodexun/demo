//
//  PauseSecondViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PauseSecondViewController: BaseViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    var pauseSecondView : PauseSecondView?
    
    var walletAddress , mnemonicWorld : String?
    
    var wordList : NSArray?
    
    var payWord : String?
    
    var pushType : Int?  //1.登录走 2.替换走
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "设置钱包", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initPauseSecondView()
        getWordList()
        showPauseWarnDialog()
    }
    
    func initPauseSecondView() {
        pauseSecondView = PauseSecondView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 400*PROSIZE))
        self.view.addSubview(pauseSecondView!)
        pauseSecondView?.secretCV?.delegate = self
        pauseSecondView?.secretCV?.dataSource = self
        pauseSecondView?.secretCV?.register(PauseKeyCell.self, forCellWithReuseIdentifier: "PauseKeyId")
        pauseSecondView?.writeBtn?.addTarget(self, action: #selector(writeAction), for: UIControl.Event.touchUpInside)
        pauseSecondView?.coppyBtn?.addTarget(self, action: #selector(coppyAction), for: UIControl.Event.touchUpInside)
    }
    
    func showPauseWarnDialog() {
        let dialog : PauseWarnDialog = PauseWarnDialog.init()
        dialog.show()
    }
    
    func getWordList() {
        let array = mnemonicWorld!.components(separatedBy:" ")
        wordList = array as NSArray
    }
    
    @objc func writeAction(sender:UIButton) {
        
        let payDialog : PayCheckDialog = PayCheckDialog.init()
        payDialog.show()
        payDialog.payCheckSuccessHandel = { (payStr) in
            self.payWord = payStr
            self.createWallet()
        }
    }
    
    func createWallet() {
        showLoading(view: self.view)
        let param = NSMutableDictionary.init()
        let secret = upSecret_aci_encrypt(jsonStr:mnemonicWorld!)
        param.setValue(walletAddress, forKey: "wallet_address")
        param.setValue(secret, forKey: "secret")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
            self.getUserInfo()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            let loginModel:UserLoginModel = BaseModel as! UserLoginModel
            let nomalSecretStr = SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: loginModel.data?.mobile)
            if nomalSecretStr != nil {
                SSKeychain.deletePassword(forService: Bundle.main.bundleIdentifier, account: loginModel.data?.mobile)
            }
            let secretStr = upUser_mnemonic_encrypt(wordStr: self.mnemonicWorld!, keyStr: self.payWord!)
            SSKeychain.setPassword(secretStr, forService: Bundle.main.bundleIdentifier, account: loginModel.data?.mobile)
            self.updateWalletBalance()
            self.view.hideToastActivity()
            if self.pushType == 2 {
                let replaceSuccessVC = ReplacePurseSuccessViewController.init()
                self.navigationController?.pushViewController(replaceSuccessVC, animated: true)
            } else {
                let pauseSuccessVC = PauseSuccessViewController.init()
                pauseSuccessVC.walletAddress = self.walletAddress
                self.navigationController?.pushViewController(pauseSuccessVC, animated: true)
            }
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func updateWalletBalance() {
        BusinessEngine.init().updateLinkWallet(walletAddress: walletAddress!, successResponse: { (baseModel) in
        }) { (baseModel) in
            
        }
    }
    
    @objc func coppyAction(sender:UIButton) {
        let pastboard = UIPasteboard.general
        pastboard.string = mnemonicWorld
        showTextToast(text: "复制成功!!", view: self.view)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PauseKeyCell = pauseSecondView?.secretCV!.dequeueReusableCell(withReuseIdentifier: "PauseKeyId", for: indexPath) as! PauseKeyCell
        cell.setPauseKeyCell(itemStr: wordList![indexPath.item] as! String)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = NSString.calStrSize(textStr: wordList![indexPath.item] as! NSString, height: 25*PROSIZE, fontSize: 15*PROSIZE)
        return CGSize.init(width: 20*PROSIZE+itemSize.width, height: 25*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 15*PROSIZE, left: 20*PROSIZE, bottom: 0, right: 10*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10*PROSIZE
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
