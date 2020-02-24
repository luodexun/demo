//
//  GameDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GameDetailViewController: BaseViewController , UIGestureRecognizerDelegate , WKNavigationDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    var dwebview : DWKWebView?
    
    var cancelView : GameDetailCancelView?

    var swperView : UIView?
    
    var userModel : UserLoginDataModel?
    
    var configModel : ConfigModel?
    
    var loadUrl , gameName , app_id , gameDetails , gameIcon , gameDesc : String?
    
    var across = 0

    var Safe_Height = SAFE_BOTTOM > 0 ? STABAR_HEIGHT : 0
    
    var isRight = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorWithHex(hex: 0x333333)
        userModel = BusinessEngine.init().getLoginUserModel()
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        configModel = ConfigModel.deserialize(from: str)
        initViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        gameRecord()
    }
    
    func initViews() {
        
        dwebview = DWKWebView.init(frame: CGRect.init(x: 0, y: Safe_Height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-Safe_Height))
        dwebview?.isOpaque = false
        dwebview?.scrollView.backgroundColor = colorWithHex(hex: 0x333333)
        dwebview?.navigationDelegate = self
        self.view.addSubview(dwebview!)
        if #available(iOS 11.0, *){
            dwebview?.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        dwebview?.loadUrl(loadUrl!)
    
        let tap = UISwipeGestureRecognizer(target:self, action:nil)
        tap.delegate = self
        dwebview!.addGestureRecognizer(tap)
        
        cancelView = GameDetailCancelView.init(frame: CGRect.init(x: SCREEN_WIDE-110*PROSIZE, y: Safe_Height+25*PROSIZE, width: 100*PROSIZE, height: 32*PROSIZE))
        cancelView?.arrowBtn?.addTarget(self, action: #selector(arrowAction), for: UIControl.Event.touchUpInside)
        cancelView?.moreBtn?.addTarget(self, action: #selector(moreAction), for: UIControl.Event.touchUpInside)
        cancelView?.cancelBtn?.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(cancelView!)
        
        swperView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15*PROSIZE, height: SCREEN_HEIGHT))
        self.view.addSubview(swperView!)
        
        let swperTap = UISwipeGestureRecognizer(target:self, action:nil)
        swperTap.delegate = self
        swperView!.addGestureRecognizer(swperTap)
        
        let gameObject = GameJsApiObject.init()
        gameObject.currentVC = self
        gameObject.appId = app_id
        dwebview!.addJavascriptObject(gameObject, namespace: nil)
        
        gameObject.launchGameHandel = {(result) in
            self.cancelView?.isHidden = true
            self.dwebview?.stopLoading()
            self.dwebview?.loadUrl(result)
        }
        
        gameObject.getRankHandel = {(result) in
            let rankListVC = RankListViewController.init()
            rankListVC.gameName = self.gameName
            rankListVC.app_id = self.app_id
            self.navigationController?.pushViewController(rankListVC, animated: true)
        }
        
    }
    
    @objc func arrowAction(sender:UIButton) {
        if isRight {
            isRight = false
            UIView.animate(withDuration: 0.3, animations: {
                self.cancelView?.frame.origin.x = 10*PROSIZE
            }) { (compalte) in
                self.cancelView?.arrowBtn?.setImage(UIImage.init(named: "ic_game_left"), for: .normal)
            }
        } else {
            isRight = true
            UIView.animate(withDuration: 0.3, animations: {
                self.cancelView?.frame.origin.x = SCREEN_WIDE-100*PROSIZE
            }) { (compalte) in
                self.cancelView?.arrowBtn?.setImage(UIImage.init(named: "ic_game_right"), for: .normal)
            }
        }
    }
    
    @objc func moreAction(sender:UIButton) {
        showAlertSheet(currentVC: self, cancel: "取消", operas: ["分享","关于"], cancelHandler: { (action) in
            
        }) { (action) in
            if action.title == "分享" {
                let shareView : NomalShareDialog = NomalShareDialog.init()
                shareView.show()
                shareView.nomalShareHandel = {(platformType:UMSocialPlatformType) in
                    self.shareWebPageToPlatformType(platformType: platformType)
                }
            } else {
                let gameAboutVC = GameAboutViewController.init()
                gameAboutVC.gameDesc = self.gameDetails
                gameAboutVC.gameIcon = self.gameIcon
                gameAboutVC.gameName = self.gameName
                self.present(gameAboutVC, animated: true, completion: nil)
            }
        }
    }
    
    func shareWebPageToPlatformType(platformType:UMSocialPlatformType) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareWebpageObject()
        shareObject.title = gameName
        shareObject.descr = gameDesc
        shareObject.thumbImage = gameIcon
        let loadUrl = configModel!.web_domain! + "/index/App/gameShare.html?app_id=" + app_id! + "&uid=" + userModel!.id!
        shareObject.webpageUrl = loadUrl
        messageObject.shareObject = shareObject
        UMSocialManager.default()?.share(to: platformType, messageObject: messageObject, currentViewController: self, completion: { (data, error) in
            if (error != nil) {
                print("************Share fail with error " )
            } else {
                print(data as Any)
            }
        })
    }
    
    @objc func cancelAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func keyBoardHidden(noty: Notification) {
        dwebview?.scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let str = webView.url?.absoluteString
        if (str?.contains("https://wx.tenpay.com"))! || (str?.contains("https://mclient.alipay"))! {
            let header = navigationAction.request.allHTTPHeaderFields
            let refer = header!["Referer"]
            if refer == nil {
                DispatchQueue.main.async {
                    let url = navigationAction.request.url
                    let request:NSMutableURLRequest = NSMutableURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                    request.httpMethod = "GET"
                    request.addValue("SnailFun://", forHTTPHeaderField: "Referer") //Mozilla http://www.baidu.com
                    webView.load(request as URLRequest)
                }
                decisionHandler(.cancel)
                return
            }
        }
        
        let url = navigationAction.request.url
        if url?.scheme == "weixin" {
            if url?.host == "wap" {
                if url?.relativePath == "/pay" {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                }
            }
            decisionHandler(.allow)
            return
        }
        if (str?.contains("https://mclient.alipay"))! {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let str = webView.url?.absoluteString
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if str?.contains("&b="+app_id!) == true || across != 1 {
            appDelegate.blockRotation = false
            cancelView?.isHidden = false
            ArkDwnWallet.interfaceOrientation(.portrait)
            statusBarOrientationChange()
        } else {
            appDelegate.blockRotation = true
            cancelView?.isHidden = true
            ArkDwnWallet.interfaceOrientation(.landscapeRight)
            statusBarOrientationChange()
        }
    }
    
    func statusBarOrientationChange() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.blockRotation {
            dwebview?.frame = CGRect.init(x: Safe_Height, y: 0, width: SCREEN_HEIGHT, height: SCREEN_WIDE-Safe_Height)
        } else {
            dwebview?.frame = CGRect.init(x: 0, y: Safe_Height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-Safe_Height)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.blockRotation {
            appDelegate.blockRotation = false
            ArkDwnWallet.interfaceOrientation(.portrait)
            statusBarOrientationChange()
        }
    }
    
    func gameRecord() {
        BusinessEngine.init().gameRecord(appId: app_id!, successResponse: { (baseModel) in
            
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
