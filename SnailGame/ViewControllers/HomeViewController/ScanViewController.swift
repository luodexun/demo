//
//  ScanViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol ScanResultDelegate {
    func scanResultAction(result:String)
}

class ScanViewController: BaseViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var scanView : ScanView?
    var sessionManager : AVCaptureSessionManager?
    var link: CADisplayLink?
    var torchState = false
    var scanDelegate : ScanResultDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "扫描", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "相册", titleColor: colorWithHex(hex: 0x333333))
        initScanView()
        
        link = CADisplayLink(target: self, selector: #selector(scan))
        sessionManager = AVCaptureSessionManager(captureType: .AVCaptureTypeBoth, scanRect: CGRect.null, success: { (result) in
            if result != nil {
                self.scanDelegate?.scanResultAction(result: result!)
                self.navigationController?.popViewController(animated: true)
            }
        })
        sessionManager?.showPreViewLayerIn(view: view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        link?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        sessionManager?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        link?.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
        sessionManager?.stop()
    }
    
    func initScanView() {
        scanView = ScanView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(scanView!)
        
        scanView?.openLightBtn?.addTarget(self, action: #selector(openLightAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func scan() {
        scanView?.scanLine?.frame.origin.y += 1
        if (scanView!.scanLine!.frame.origin.y >= 200*PROSIZE) {
            scanView?.scanLine?.frame.origin.y = -6*PROSIZE;
        }
    }
    
    @objc func openLightAction(sender:UIButton) {
        torchState = !torchState
        let imageStr = torchState ? "ic_scan_close" : "ic_scan_open"
        sessionManager?.turnTorch(state: torchState)
        sender.setImage(UIImage.init(named: imageStr), for: UIControl.State.normal)
    }
    
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func rightImageAction(sender: UIButton) {
        AVCaptureSessionManager.checkAuthorizationStatusForPhotoLibrary(grant: {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }) {
            let action = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
                let url = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            })
            let con = UIAlertController(title: "权限未开启",
                                        message: "您未开启相册权限，点击确定跳转至系统设置开启",
                                        preferredStyle: UIAlertController.Style.alert)
            con.addAction(action)
            self.present(con, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        sessionManager?.start()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            self.sessionManager?.start()
           // let image = (info[.originalImage] as! UIImage ).compressImageMid(maxLength: 80*80)
  
            self.sessionManager?.scanPhoto(image: info[.originalImage] as! UIImage, success: { (str) in
                if let result = str {
                    self.scanDelegate?.scanResultAction(result: result)
                    self.navigationController?.popViewController(animated: true)
                }else {
                    print("未识别到二维码")
                }
            })
            
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
