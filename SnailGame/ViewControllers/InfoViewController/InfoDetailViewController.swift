//
//  InfoDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import IQKeyboardManagerSwift

protocol InfoDetailUpdateDelegate {
    func infoDetailUpdateAction()
}

class InfoDetailViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pushType : Int? //1.资讯 2.行情
    
    var infoModel : InfoDataModel?
    
    var marketModel : MarketDataModel?
    
    var webView : WKWebView?
    
    var bottomView : InfoDetailBottomView?
    
    var commentView : InfoDetailCommentView?
    
    var infoUpdateDelegate : InfoDetailUpdateDelegate?
    
    var isCollect = false
    
    var loadUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()

        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)

         NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    func initViews() {
        var topH : CGFloat = 0.0
        var bottomH : CGFloat = 0.0
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        if pushType == 1 {
            bottomH = 50*PROSIZE+SAFE_BOTTOM
            loadUrl = (configModel?.web_domain!)! + "/index/Information/details.html?id=" + infoModel!.id!
            bottomView = InfoDetailBottomView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-SAFE_BOTTOM-50*PROSIZE, width: SCREEN_WIDE, height: 50*PROSIZE))
            self.view.addSubview(bottomView!)
            if infoModel?.is_star == "1" {
                bottomView?.zanPushBtn?.isUserInteractionEnabled = false
                bottomView?.zanTitleLbl?.text = "已赞"
                bottomView?.zanImageView?.image = UIImage.init(named: "ic_info_detail_zan_yes")
            } else {
                bottomView?.zanPushBtn?.isUserInteractionEnabled = true
                bottomView?.zanTitleLbl?.text = "赞"
                bottomView?.zanImageView?.image = UIImage.init(named: "ic_info_detail_zan_no")
            }
            bottomView?.zanPushBtn?.addTarget(self, action: #selector(zanPushAction), for: UIControl.Event.touchUpInside)
            bottomView?.sharePushBtn?.addTarget(self, action: #selector(sharePushAction), for: UIControl.Event.touchUpInside)
            bottomView?.commentPushBtn?.addTarget(self, action: #selector(commentPushAction), for: UIControl.Event.touchUpInside)
            
        } else {
            topH = STABAR_HEIGHT+44
            initNaviView(bgColor: UIColor.white)
            initNaviBackBtn(imageStr: "ic_back_nomal")
            initNaviTitle(titleStr: marketModel!.currency!, titleColor: colorWithHex(hex: 0x333333))
            initRightImageButton(imageStr: "ic_info_detail_star_nol")
            loadUrl = (configModel?.web_domain!)! + "/index/trend/detail/currency_code/"+marketModel!.currency_code!+"/range/day/type/price_usd.html"
            favoriteExit()
        }
        webView = WKWebView.init(frame: CGRect.init(x: 0, y: topH, width: SCREEN_WIDE, height: SCREEN_HEIGHT-topH-bottomH))
        webView?.sizeToFit()
        webView?.load(NSURLRequest.init(url: NSURL.init(string: loadUrl!)! as URL) as URLRequest)
        self.view.addSubview(webView!)
        
        if #available(iOS 11.0, *){
            webView?.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        
        if pushType == 1 {
            initNaviView(bgColor: UIColor.clear)
            initNaviBackBtn(imageStr: "ic_back_info")
            commentView = InfoDetailCommentView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDE, height: 50*PROSIZE))
            commentView?.sendBtn?.addTarget(self, action: #selector(sendAction), for: UIControl.Event.touchUpInside)
            self.view.addSubview(commentView!)
        }
    }

    @objc func zanPushAction(sender:UIButton) {
        sender.isUserInteractionEnabled = false
        BusinessEngine.init().giveLikeInfo(infoId: infoModel!.id!, successResponse: { (baseModel) in
            showTextToast(text: "点赞成功", view: self.view)
            self.bottomView?.zanTitleLbl?.text = "已赞"
            self.bottomView?.zanImageView?.image = UIImage.init(named: "ic_info_detail_zan_yes")
            self.infoUpdateDelegate?.infoDetailUpdateAction()
        }) { (baseModel) in
            sender.isUserInteractionEnabled = true
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    @objc func sharePushAction(sender:UIButton) {
        let shareView : NomalShareDialog = NomalShareDialog.init()
        shareView.show()
        shareView.nomalShareHandel = {(platformType:UMSocialPlatformType) in
            self.shareWebPageToPlatformType(platformType: platformType)
        }
    }
    
    func shareWebPageToPlatformType(platformType:UMSocialPlatformType) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareWebpageObject()
        shareObject.title = infoModel?.title
        shareObject.descr = infoModel?.desc
        shareObject.thumbImage = infoModel?.icon
        shareObject.webpageUrl = self.loadUrl
        messageObject.shareObject = shareObject
        UMSocialManager.default()?.share(to: platformType, messageObject: messageObject, currentViewController: self, completion: { (data, error) in
            if (error != nil) {
                print("************Share fail with error " )
            } else {
                print(data as Any)
            }
        })
    }
    
    @objc func commentPushAction(sender:UIButton) {
        commentView?.commentTextF!.becomeFirstResponder()
    }
    
    @objc func sendAction(sender:UIButton) {
        if commentView?.commentTextF?.text?.count == 0 {
            showTextToast(text: "请输入评论内容", view: self.view)
            return
        }
        commentView?.commentTextF!.resignFirstResponder()
        
        BusinessEngine.init().commentInfo(content: (commentView?.commentTextF!.text)!, infoId: infoModel!.id!, successResponse: { (baseModel) in
            showTextToast(text: "提交成功，等待审核发布", view: self.view)
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func favoriteExit() {
        let collectBtn : UIButton = naviView?.viewWithTag(50000) as! UIButton
        BusinessEngine.init().favoriteExit(currencyCode: marketModel!.currency_code!, successResponse: { (baseModel) in
            self.isCollect = true
            collectBtn.setImage( UIImage.init(named: "ic_info_detail_star_sel"), for: UIControl.State.normal)
        }) { (baseModel) in
            self.isCollect = false
            collectBtn.setImage( UIImage.init(named: "ic_info_detail_star_nol"), for: UIControl.State.normal)
        }
    }
    
    override func rightImageAction(sender: UIButton) {
        if judgeLoginAndPush() {
            let collectBtn : UIButton = naviView?.viewWithTag(50000) as! UIButton
            if isCollect {
                BusinessEngine.init().favoriteCancel(currencyCode: marketModel!.currency_code!, successResponse: { (baseModel) in
                    showTextToast(text: "取消收藏成功", view: self.view)
                    self.isCollect = false
                    collectBtn.setImage( UIImage.init(named: "ic_info_detail_star_nol"), for: UIControl.State.normal)
                }) { (baseModel) in
                    showTextToast(text: baseModel.message!, view: self.view)
                }
            } else {
                BusinessEngine.init().favorite(currencyCode: marketModel!.currency_code!, successResponse: { (baseModel) in
                    showTextToast(text: "收藏成功", view: self.view)
                    self.isCollect = true
                    collectBtn.setImage( UIImage.init(named: "ic_info_detail_star_sel"), for: UIControl.State.normal)
                }) { (baseModel) in
                    showTextToast(text: baseModel.message!, view: self.view)
                }
            }
        }
    }
    
    @objc func keyBoardWillShow(note:NSNotification) {

        let userInfo  = note.userInfo! as NSDictionary
        
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        UIView.animate(withDuration: duration) {
            self.commentView?.frame.origin.y = SCREEN_HEIGHT-50*PROSIZE
        }
    }

    @objc func keyBoardWillHide(note:NSNotification) {
        
        let userInfo  = note.userInfo! as NSDictionary
        
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        UIView.animate(withDuration: duration) {
            self.commentView?.frame.origin.y = SCREEN_HEIGHT
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
