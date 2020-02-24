//
//  IdentityAuthentyViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class IdentityAuthentyViewController: BaseViewController , AVCaptureDelegate , JQAVCaptureDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var authentyView : IdentityAuthentyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "身份认证", titleColor: colorWithHex(hex: 0x333333))
        initIdentityAuthentyView()
    }
    
    func initIdentityAuthentyView() {
        authentyView = IdentityAuthentyView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(authentyView!)
        
        authentyView?.positiveView?.takePhotoBtn?.addTarget(self, action: #selector(positiveAction), for: .touchUpInside)
        authentyView?.reverseView?.takePhotoBtn?.addTarget(self, action: #selector(reverseAction), for: .touchUpInside)
    }
    
    @objc func positiveAction(sender:UIButton) {
        let AVCaptureVC = AVCaptureViewController.init()
        AVCaptureVC.avDelegate = self
        self.navigationController?.pushViewController(AVCaptureVC, animated: true)
    }
    
    @objc func reverseAction(sender:UIButton) {
        let JQCaptureVC = JQAVCaptureViewController.init()
        JQCaptureVC.jqDelegate = self
        self.navigationController?.pushViewController(JQCaptureVC, animated: true)
    }
    
    func AVCaptureScanBack(info: IDInfo, subImage: UIImage) {
        authentyView?.positiveView?.photoImageView?.image = subImage
    }
    
    func JQAVCaptureScanBack(info: IDInfo, subImage: UIImage) {
        authentyView?.reverseView?.photoImageView?.image = subImage
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
