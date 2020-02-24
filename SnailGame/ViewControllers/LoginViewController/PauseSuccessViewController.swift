//
//  PauseSuccessViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PauseSuccessViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    var pauseSuccessView : PauseSuccessView?
    
    var tailorView : TailorPhotoView?

    var walletAddress : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "设置钱包", titleColor: colorWithHex(hex: 0x333333))
        initPauseSecondView()
        pauseSuccessView?.addressNameLbl?.text = walletAddress
        tailorView?.addressNameLbl?.text = walletAddress
        setUpQRImage()
    }
    
    func setUpQRImage() {
        let image = setupQRCodeImage(text: walletAddress!)
        pauseSuccessView?.qrImageView?.image = image
        tailorView?.qrImageView?.image = image
    }
    
    func initPauseSecondView() {
        pauseSuccessView = PauseSuccessView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(pauseSuccessView!)
        
        tailorView = TailorPhotoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT))
    
        pauseSuccessView?.addressCopyBtn?.addTarget(self, action: #selector(addressCopyAction), for: UIControl.Event.touchUpInside)
        
        pauseSuccessView?.complateBtn?.addTarget(self, action: #selector(complateAction), for: UIControl.Event.touchUpInside)
        
        pauseSuccessView?.savePhotoBtn?.addTarget(self, action: #selector(savePhotoAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func addressCopyAction(sender:UIButton) {
        showTextToast(text: "复制成功", view: self.view)
        UIPasteboard.general.string = walletAddress
    }
    
    @objc func complateAction(sender:UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func savePhotoAction(sender:UIButton) {
        UIImageWriteToSavedPhotosAlbum( tailorViewToImage(view: tailorView!), self, #selector(save(image:didFinishSavingWithError:contextInfo:)), nil)
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
