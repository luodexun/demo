//
//  PromotionShareViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/10/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionShareViewController: BaseViewController {

    var pushType = 1 //1.推广 2.快讯
    
    var baseScrlView : UIScrollView?
    
    var imageView : UIImageView?

    var imageUrl : String?
    
    var images = ["ic_share_save","ic_share_wechat","ic_share_friends"]
    
    var titles = ["保存","朋友圈","微信好友"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorWithHex(hex: 0x457DF7)
        initViews()
        showLoading(view: self.view)
        if pushType == 1 {
            getPromotionCode()
        } else {
            getMornNews()
        }
    }
    
    func initViews() {
        
        baseScrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT-180*PROSIZE-SAFE_BOTTOM))
        baseScrlView?.showsVerticalScrollIndicator = false
        self.view.addSubview(baseScrlView!)
        
        if #available(iOS 11.0, *){
            baseScrlView?.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 489*PROSIZE))
        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        baseScrlView?.addSubview(imageView!)
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-180*PROSIZE-SAFE_BOTTOM, width: SCREEN_WIDE, height: 180*PROSIZE+SAFE_BOTTOM))
        barView.backgroundColor = UIColor.white
        self.view.addSubview(barView)
        
        let shareTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 200*PROSIZE, height: 14*PROSIZE))
        shareTitleLbl.text = "请选择"
        shareTitleLbl.textColor = colorWithHex(hex: 0x999999)
        shareTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        barView.addSubview(shareTitleLbl)
        
        for (i,item) in images.enumerated() {
            let itemView = shareItemView.init(frame: CGRect.init(x: CGFloat(i) * SCREEN_WIDE/CGFloat(images.count), y: 45*PROSIZE, width: SCREEN_WIDE/CGFloat(images.count), height: 70*PROSIZE))
            itemView.itemImageView?.image = UIImage.init(named: item)
            itemView.itemTitleLbl?.text = titles[i]
            itemView.itemBtn?.tag = 2000+i
            itemView.itemBtn?.addTarget(self, action: #selector(shareAction), for: UIControl.Event.touchUpInside)
            barView.addSubview(itemView)
        }
        
        let cancelBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        cancelBtn.frame = CGRect.init(x: 0, y: 130*PROSIZE, width: SCREEN_WIDE, height: 50*PROSIZE)
        cancelBtn.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        cancelBtn.setTitle("取消", for: UIControl.State.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        cancelBtn.setTitleColor(colorWithHex(hex: 0x333333), for: UIControl.State.normal)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
        barView.addSubview(cancelBtn)
    }
    
    func getPromotionCode() {
        BusinessEngine.init().promotionCode(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let codeModel : PromotionCodeModel = BaseModel as! PromotionCodeModel
            self.imageUrl = codeModel.data?.url
            self.imageView?.dwn_setImageView(urlStr: codeModel.data!.url!, imageName: "")
            self.baseScrlView?.contentSize = CGSize.init(width: SCREEN_WIDE, height: 489*PROSIZE)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getMornNews() {
        BusinessEngine.init().mornNews(successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let mornModel : MornNewsModel = baseModel as! MornNewsModel
            self.imageUrl = mornModel.data?.url
            self.imageView?.af_setImage(withURL: URL.init(string: mornModel.data!.url!)!, completion: { (dataResponse) in
                var realH:CGFloat = 0.0
                if dataResponse.result.value != nil {
                    realH = (dataResponse.result.value?.size.height)! * SCREEN_WIDE / (dataResponse.result.value?.size.width)!
                }
                self.imageView?.frame.size.height = realH
                self.baseScrlView?.contentSize = CGSize.init(width: SCREEN_WIDE, height: realH)
            })
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    @objc func shareAction(sender:UIButton) {
        if sender.tag == 2000 {
            UIImageWriteToSavedPhotosAlbum( imageView!.image!, self, #selector(save(image:didFinishSavingWithError:contextInfo:)), nil)
        } else if sender.tag == 2001 {
            shareWebPageToPlatformType(platformType: .wechatSession)
        } else {
            shareWebPageToPlatformType(platformType: .wechatTimeLine)
        }
    }
    
    func shareWebPageToPlatformType(platformType:UMSocialPlatformType) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareImageObject()
        shareObject.shareImage = imageView?.image
        messageObject.shareObject = shareObject
        UMSocialManager.default()?.share(to: platformType, messageObject: messageObject, currentViewController: self, completion: { (data, error) in
            if (error != nil) {
                print("************Share fail with error " )
            } else {
                print(data as Any)
            }
        })
    }
    
    @objc func save(image:UIImage, didFinishSavingWithError:NSError?,contextInfo:AnyObject) {
        if didFinishSavingWithError != nil {
            showTextToast(text: "保存失败", view: self.view)
        } else {
            showTextToast(text: "保存成功", view: self.view)
        }
    }
    
    @objc func cancelAction(sender:UIButton) {
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

class shareItemView: UIView {
    
    var itemBtn : UIButton?
    
    var itemTitleLbl : UILabel?
    
    var itemImageView : UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        itemImageView = UIImageView.init(frame: CGRect.init(x: (self.frame.size.width-45*PROSIZE)/2, y: 0, width: 45*PROSIZE, height: 45*PROSIZE))
        self.addSubview(itemImageView!)
        
        itemTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 55*PROSIZE, width: self.frame.size.width, height: 14*PROSIZE))
        itemTitleLbl?.textColor = colorWithHex(hex: 0x333333)
        itemTitleLbl?.font = UIFont.systemFont(ofSize: 14*PROSIZE)
        itemTitleLbl?.textAlignment = NSTextAlignment.center
        self.addSubview(itemTitleLbl!)
        
        itemBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        itemBtn?.frame = self.bounds
        self.addSubview(itemBtn!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
