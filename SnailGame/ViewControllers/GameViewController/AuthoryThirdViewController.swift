//
//  AuthoryThirdViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AuthoryThirdViewController: BaseViewController {

    var detailModel : GameDataModel?
    
    var authoryView : AuthoryThirdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: " 授权", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_login")
        initAuthoryThirdView()
    }
    
    func initAuthoryThirdView() {
        authoryView = AuthoryThirdView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(authoryView!)
        
        authoryView?.agreeBtn?.addTarget(self, action: #selector(agreeAction), for: .touchUpInside)
        
        authoryView?.refuseBtn?.addTarget(self, action: #selector(refuseAction), for: .touchUpInside)
        
        authoryView?.logoIcon?.dwn_setImageView(urlStr: (detailModel?.icon!)!, imageName: "")
        authoryView?.appNameLbl?.text = detailModel?.name
    }
    
    @objc func agreeAction(sender:UIButton) {
        let timeInterval: TimeInterval = NSDate.init().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        UserDefaults.standard.set(timeStamp, forKey: AUTHORY_DATE)
        let url:URL? = URL.init(string: detailModel!.address!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refuseAction(sender:UIButton) {
        if UserDefaults.standard.object(forKey: AUTHORY_DATE) != nil {
            UserDefaults.standard.removeObject(forKey: AUTHORY_DATE)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
