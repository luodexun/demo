//
//  RollInViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RollInViewController: BaseViewController , SetNumberDelegate {

    var rollInView : RollInView?

    var photoView : SavePhotoView?
    
    var walletAddress : String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_white")
        initNaviTitle(titleStr: "收入", titleColor: colorWithHex(hex: 0xffffff))
        initRollInView()
        walletAddress = BusinessEngine.init().getLoginUserModel().wallet_address
        createQrcodeImg(qrCodeStr: walletAddress!)
        rollInView?.walletAddressLbl?.text = walletAddress
        photoView?.addressNameLbl?.text = walletAddress
    }
    
    func initRollInView() {
        rollInView = RollInView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(rollInView!)
        
        photoView = SavePhotoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT))
       
        rollInView?.coppyBtn?.addTarget(self, action: #selector(coppyAction), for: UIControl.Event.touchUpInside)
        
        rollInView?.setNumBtn?.addTarget(self, action: #selector(setNumAction), for: UIControl.Event.touchUpInside)
        
        rollInView?.savePhotoBtn?.addTarget(self, action: #selector(savePhotoAction), for: UIControl.Event.touchUpInside)
        
    }
    
    func createQrcodeImg(qrCodeStr:String) {
        let image = setupQRCodeImage(text: qrCodeStr)
        rollInView?.qrCodeImageView?.image = image
        photoView?.qrImageView?.image = image
    }
    
    @objc func coppyAction(sender:UIButton) {
        UIPasteboard.general.string = walletAddress
        showTextToast(text: "复制成功", view: self.view)
    }
    
    @objc func setNumAction(sender:UIButton) {
        let setNumberVC = SetNumberViewController.init()
        setNumberVC.numberDelegate = self
        self.navigationController?.pushViewController(setNumberVC, animated: true)
    }
    
    func setNumberAction(numStr:String) {
        rollInView?.dwnNumLbl?.isHidden = false
        rollInView?.barView?.frame = CGRect.init(x: 0, y: 329*PROSIZE, width: SCREEN_WIDE, height: 217*PROSIZE)
        let numAttrStr = NSMutableAttributedString.init(string: numStr + " DWN")
        numAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xFF7700), range:NSRange.init(location:0, length: numStr.count))
        rollInView?.dwnNumLbl?.attributedText = numAttrStr
        photoView?.dwnNumLbl?.attributedText = numAttrStr
        createQrcodeImg(qrCodeStr: walletAddress!+"#"+numStr)
    }
    
    @objc func savePhotoAction(sender:UIButton) {
        UIImageWriteToSavedPhotosAlbum( tailorViewToImage(view: photoView!), self, #selector(save(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save(image:UIImage, didFinishSavingWithError:NSError?,contextInfo:AnyObject) {
        if didFinishSavingWithError != nil {
            showTextToast(text: "保存失败", view: self.view)
        } else {
            showTextToast(text: "保存成功", view: self.view)
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
