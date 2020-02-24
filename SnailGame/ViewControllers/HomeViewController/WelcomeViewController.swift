//
//  WelcomeViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/13.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol WelcomePushDelegate {
    func welcomePushAction()
}

class WelcomeViewController: BaseViewController {

    var welcomeImageView : UIImageView?
    
    var countBarView : UIView?
    
    var countDownLbl : UILabel?
    
    var countTimer : Timer?

    var totalCount : Int?
    
    var adImage : String?
    
    var countIndex = 0
    
    var ipList : NSArray?
    
    var welcomeDelegate : WelcomePushDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        adImage = UserDefaults.standard.object(forKey: "welcome_ad") as? String
        if adImage != nil {
            let modelH = UserDefaults.standard.object(forKey: "welcome_ad_h")
            var realH:CGFloat = 0.0
            if modelH != nil {
                realH = modelH as! CGFloat
            }
            let realY = SCREEN_HEIGHT-SAFE_BOTTOM-100*PROSIZE-realH
            welcomeImageView?.frame.origin.y = realY
            welcomeImageView?.frame.size.height = realH
            welcomeImageView?.dwn_setImageView(urlStr: adImage!, imageName: "")
        }
    
        welcomeAdvert()
        getNetWorkConfig()
    }
    
    func setUpViews() {
        
        welcomeImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT-SAFE_BOTTOM-100*PROSIZE))
        welcomeImageView?.contentMode = .scaleAspectFill
        self.view.addSubview(welcomeImageView!)
        
        let bottomBarView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-SAFE_BOTTOM-100*PROSIZE, width: SCREEN_WIDE, height: SAFE_BOTTOM+100*PROSIZE))
        bottomBarView.backgroundColor = UIColor.white
        self.view.addSubview(bottomBarView)
        
        let logoImageView = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-163*PROSIZE)/2, y: 32*PROSIZE, width: 163*PROSIZE, height: 33.5*PROSIZE))
        logoImageView.image = UIImage.init(named: "ic_welcome_logo")
        bottomBarView.addSubview(logoImageView)
        
        countBarView = UIView.init(frame: CGRect.init(x: SCREEN_WIDE-85*PROSIZE, y: STABAR_HEIGHT+18*PROSIZE, width: 65*PROSIZE, height: 30*PROSIZE))
        countBarView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        countBarView?.layer.cornerRadius = 15*PROSIZE
        countBarView?.layer.masksToBounds = true
        countBarView?.isHidden = true
        self.view.addSubview(countBarView!)
        
        countDownLbl = UILabel.init(frame: countBarView!.bounds)
        countDownLbl?.textAlignment = .center
        countDownLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        countDownLbl?.textColor = UIColor.white
        countDownLbl?.text = "3跳过"
        countBarView?.addSubview(countDownLbl!)
        
        let pushBtn = UIButton.init(type: .roundedRect)
        pushBtn.frame = countBarView!.bounds
        pushBtn.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        countBarView?.addSubview(pushBtn)
        
    }
    
    @objc func pushAction(sender:UIButton) {
        countTimer?.invalidate()
        countTimer = nil
        welcomeDelegate?.welcomePushAction()
    }
    
    func getNetWorkConfig() {
        BusinessEngine.init().getNetWorkConfig(successResponse: { (baseModel) in
            self.getNetworkPeers()
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getNetworkPeers() {
        BusinessEngine.init().getNetworkPeers(successResponse: { (baseModel) in
            let allModel = baseModel as! AllPortModel
            self.ipList = allModel.list as NSArray?
            self.getNetWorkPort()
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getNetWorkPort() {
        if countIndex == ipList?.count {
            showTextToast(text: "暂无节点可用", view: self.view)
            return
        }
        let ipModel:IPPortModel = ipList![countIndex] as! IPPortModel
        let urlStr = "http://" + ipModel.ip! +  ":4103/api/v2/transactions/fees"
        do {
            let result = try NSString.init(contentsOf: URL.init(string: urlStr)!, encoding: String.Encoding.utf8.rawValue)
            let data = result.data(using: String.Encoding.utf8.rawValue)
            let dict : NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
            if dict["data"] != nil {
                let model = SnailDynamicModel.deserialize(from: dict)
                model?.data?.ip = ipModel.ip!
                model?.data?.port = ipModel.port!
                let userDefault = UserDefaults.standard
                userDefault.set(model?.data?.toJSONString(), forKey: NetWorkPort)
                self.countBarView?.isHidden = false
                self.totalCount = 4
                self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
                self.countTimer!.fire()
            } else {
                self.countIndex += 1;
                self.getNetWorkPort()
            }
        }catch {
            self.countIndex += 1;
            self.getNetWorkPort()
        }

//        BusinessEngine.init().getNetWorkPort(ip: ipModel.ip!, port: ipModel.port!, successResponse: { (baseModel) in
//            self.countBarView?.isHidden = false
//            self.totalCount = 4
//            self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
//            self.countTimer!.fire()
//        }) { (baseModel) in
//            self.countIndex += 1;
//            self.getNetWorkPort()
//        }
    }
    
    func welcomeAdvert() {
        BusinessEngine.init().welcomeAdvert(successResponse: { (baseModel) in
            let welcomeModel = baseModel as! WelcomeModel
            if welcomeModel.data!.count > 0 {
                if self.adImage != welcomeModel.data![0] {
                    UserDefaults.standard.set(welcomeModel.data![0], forKey: "welcome_ad")
                    self.welcomeImageView?.af_setImage(withURL: URL.init(string: welcomeModel.data![0])!, completion: { (dataResponse) in
                        var realH:CGFloat = 0.0
                        var realY:CGFloat = 0.0
                        if dataResponse.result.value != nil {
                            realH = (dataResponse.result.value?.size.height)! * SCREEN_WIDE / (dataResponse.result.value?.size.width)!
                            realY = SCREEN_HEIGHT - SAFE_BOTTOM - 100*PROSIZE - realH
                        }
                        self.welcomeImageView?.frame.origin.y = realY
                        self.welcomeImageView?.frame.size.height = realH
                        UserDefaults.standard.set(realH, forKey: "welcome_ad_h")
                    })
                }
            }
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    @objc func countDownAction(sender:Timer){
        if totalCount == 1 {
            countTimer?.invalidate()
            countTimer = nil
            welcomeDelegate?.welcomePushAction()
        } else {
            totalCount! -= 1
            countDownLbl?.text = String(totalCount!)+"跳过"
        }
    }

    deinit {
        countTimer?.invalidate()
        countTimer = nil
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
