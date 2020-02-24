//
//  RightDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RightDetailViewController: BaseViewController {

    var detailWebView : WKWebView?
    
    var pushType = 1  // 1.蜗牛VIP 2.蜗牛VIP 3.区块浏览器

    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        setUpViews()
    }
    
    func setUpViews() {
        detailWebView = WKWebView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        detailWebView?.sizeToFit()
        self.view.addSubview(detailWebView!)
        
        if pushType == 1 {
            let str = UserDefaults.standard.string(forKey: GAMECONFIG)
            let configModel = ConfigModel.deserialize(from: str)
            let loadUrlStr = configModel!.web_domain! + "/index/Member/ruleVip.html"
            detailWebView?.load(NSURLRequest.init(url: NSURL.init(string: loadUrlStr)! as URL) as URLRequest)
            initNaviTitle(titleStr: "蜗牛VIP", titleColor: colorWithHex(hex: 0x333333))
        } else if pushType == 2 {
            let str = UserDefaults.standard.string(forKey: GAMECONFIG)
            let configModel = ConfigModel.deserialize(from: str)
            let loadUrlStr = configModel!.web_domain! + "/index/Member/detailVip.html"
            detailWebView?.load(NSURLRequest.init(url: NSURL.init(string: loadUrlStr)! as URL) as URLRequest)
            initNaviTitle(titleStr: "蜗牛VIP", titleColor: colorWithHex(hex: 0x333333))
        } else if pushType == 3 {
            detailWebView?.load(NSURLRequest.init(url: NSURL.init(string: BROWSER_HOST)! as URL) as URLRequest)
            initNaviTitle(titleStr: "区块浏览器", titleColor: colorWithHex(hex: 0x333333))
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
