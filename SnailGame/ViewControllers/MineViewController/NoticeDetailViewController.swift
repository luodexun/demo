//
//  NoticeDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class NoticeDetailViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pushType : Int? // 1.消息通知

    var noticeId : Int?
    
    var webview : WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initViews()
        var loadUrl = ""
        if pushType == 1 {
            initNaviTitle(titleStr: "消息通知", titleColor: colorWithHex(hex: 0x333333))
            let str = UserDefaults.standard.string(forKey: GAMECONFIG)
            let configModel = ConfigModel.deserialize(from: str)
            loadUrl = (configModel?.web_domain!)! + "/index/information/notice/id/"+String(noticeId!)
            readNotice()
        }
        webview?.load(NSURLRequest.init(url: NSURL.init(string: loadUrl)! as URL) as URLRequest)
    }
    
    func initViews() {
        webview = WKWebView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(webview!)
    }

    func readNotice() {
        BusinessEngine.init().readNotice(noitceId: String(noticeId!), successResponse: { (baseModel) in
            self.getUserInfo()
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
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
