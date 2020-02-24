//
//  SetViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SetViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setView : SetView?
    
    var addressStr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "设置", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initSetView()
        getUpdateInfo()
        if isLogin() {
            setView?.logoutBtn?.isHidden = false
        } else {
            setView?.logoutBtn?.isHidden = true
        }
        
    }
    
    func initSetView() {
        setView = SetView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 400*PROSIZE))
        self.view.addSubview(setView!)
        
        setView?.clearBtn?.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        
        setView?.aboutBtn?.addTarget(self, action: #selector(aboutAction), for: .touchUpInside)
        
        setView?.updateBtn?.addTarget(self, action: #selector(updateAction), for: .touchUpInside)
        
        setView?.logoutBtn?.addTarget(self, action: #selector(logoutAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func clearAction(sender:UIButton) {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                }
            }
        }
        showTextToast(text: "缓存清理成功！", view: self.view)
    }
    
    @objc func aboutAction(sender:UIButton) {
        let aboutVC = AboutViewController.init()
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
    @objc func updateAction(sender:UIButton) {
        if addressStr != nil {
            UIApplication.shared.open(URL.init(string: addressStr!)!, options: [:], completionHandler: nil)
        } else {
            showTextToast(text: "已经是最新版本了", view: self.view)
        }
    }
    
    @objc func logoutAction(sender:UIButton) {
        showAlert(currentVC: self, title: "退出登录", meg: "是否确定退出登录？", cancel: "取消", sure: "确定", cancelHandler: { (action) in
            
        }) { (action) in
            BusinessEngine.init().logout(successResponse: { (BaseModel) in
                
            }) { (BaseModel) in
                
            }
            BusinessEngine.init().clearLocalUserInfoModel()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getUpdateInfo() {
        BusinessEngine.init().update(successResponse: { (baseModel) in
            let versionModel = baseModel as! VersionModel
            DispatchQueue.main.async {
                if versionModel.data?.is_update != 0 {
                    self.addressStr = versionModel.data?.address
                    self.setView?.versionNoteLbl?.isHidden = false
                } else {
                    self.setView?.versionNoteLbl?.isHidden = true
                }
            }
        }) { (baseModel) in
            DispatchQueue.main.async {
                self.setView?.versionNoteLbl?.isHidden = true
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
