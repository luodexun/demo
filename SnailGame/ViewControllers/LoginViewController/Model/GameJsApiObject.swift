//
//  GameJsApiObject.swift
//  SnailGame
//
//  Created by Edison on 2019/10/9.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias GameBlock = (_ result:String) -> Void

class GameJsApiObject: NSObject {

    var humanVerifyHandel : GameBlock?
    
    var launchGameHandel : GameBlock?
    
    var getRankHandel : GameBlock?
    
    var currentVC : UIViewController?
    
    var appId : String?
    
    @objc func submitIntegral( _ arg:String, handler: @escaping (String, Bool)->Void) {
        BusinessEngine.init().uploadGameResult(datas: arg, successResponse: { (result) in
            handler(getJSONStringFromDictionary(dictionary: result), true)
        }) { (baseModel) in
            showAlert(currentVC: self.currentVC!, title: "上传结果失败", meg: "是否重新提交？", cancel: "取消", sure: "确定", cancelHandler: { (action) in
            }, sureHandler: { (action) in
                self.submitIntegral(arg, handler: { (result, complete) in
                })
            })
        }
    }
    
    @objc func addMouseMove( _ arg:String, handler: @escaping (String, Bool)->Void) {
        BusinessEngine.init().piecewiseUploadData(jsonData: arg, successResponse: { (result) in
            handler(getJSONStringFromDictionary(dictionary: result), true)
        }) { (baseModel) in
        
        }
    }
    
    @objc func getRank( _ arg:String, handler: @escaping (String, Bool)->Void) {
        getRankHandel!(arg)
    }
    
    @objc func launchGame( _ arg:String, handler: @escaping (String, Bool)->Void) {
        launchGameHandel!(arg)
    }
    
    @objc func gameMsg( _ arg:String, handler: @escaping (String, Bool)->Void) {
        showTextToast(text: arg, view: currentVC!.view)
    }
    
    @objc func detection( _ arg:String) {
        humanVerifyHandel!(arg)
    }
    
    @objc func dwnPay( _ arg:String, handler: @escaping (String, Bool)->Void) {
        let dict = getDictionaryFromJSONString(jsonString: arg)
        var totalFee = "0"
        if dict["total_fee"] != nil {
            totalFee = dict["total_fee"] as! String
        }
        showLoading(view: self.currentVC!.view)
        BusinessEngine.init().dwnPrise(successResponse: { (baseModel) in
            self.currentVC?.view.hideToastActivity()
            let priceModel = baseModel as! GamePriceModel
            let amount = KeepSomeDecimal(num: calculateAChuyiB(a: totalFee, b: priceModel.data!.cnzPrise!), decimal: 2)
            let payDialog = GamePayDialog.init(amountStr: amount)
            payDialog.show()
            payDialog.gamePaySuccessHandel = {
                showLoading(view: self.currentVC!.view)
                BusinessEngine.init().gamePay(jsonData: arg, appId: self.appId!, successResponse: { (result) in
                    self.currentVC?.view.hideToastActivity()
                    handler(getJSONStringFromDictionary(dictionary: result), true)
                }) { (baseModel) in
                    self.currentVC?.view.hideToastActivity()
                    showTextToast(text: baseModel.message!, view: self.currentVC!.view)
                }
            }
        }) { (baseModel) in
            self.currentVC?.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.currentVC!.view)
        }
    }
    
    @objc func digisnail( _ arg:String, handler: @escaping (String, Bool)->Void) {
        let dict = getDictionaryFromJSONString(jsonString: arg)
        let type = dict["type"] as! String
        if type == "api" {
            var amountStr = "0"
            let dataDcit = dict["data"] as! NSDictionary
            let urlStr = dict["url"] as! String
            if dataDcit["params"] != nil {
                let paramsDict = dataDcit["params"] as! NSDictionary
                if paramsDict["total"] != nil {
                    let total = paramsDict["total"] as! Int
                    amountStr = KeepSomeDecimal(num: calculateAChuyiB(a: String(total), b: TOKEN_RATIO), decimal: 2)
                    let payDialog = GamePayDialog.init(amountStr: amountStr)
                    payDialog.show()
                    payDialog.gamePaySuccessHandel = {
                        showLoading(view: self.currentVC!.view)
                        BusinessEngine.init().redPay(urlStr: urlStr, params: dataDcit, successResponse: { (result) in
                            self.currentVC?.view.hideToastActivity()
                            handler(getJSONStringFromDictionary(dictionary: result), true)
                        }) { (baseModel) in
                            self.currentVC?.view.hideToastActivity()
                            showTextToast(text: baseModel.message!, view: self.currentVC!.view)
                        }
                    }
                }
            }
        } else {
            let dataDcit = dict["data"] as! NSDictionary
            let shareView : NomalShareDialog = NomalShareDialog.init()
            shareView.show()
            shareView.nomalShareHandel = {(platformType:UMSocialPlatformType) in
                self.shareWebPageToPlatformType(platformType: platformType,data: dataDcit)
            }
        }
    }
    
    func shareWebPageToPlatformType(platformType:UMSocialPlatformType,data:NSDictionary) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareWebpageObject()
        shareObject.title = data["title"] as? String
        shareObject.descr = data["text"] as? String
        shareObject.thumbImage = data["img"]
        shareObject.webpageUrl = data["url"] as? String
        messageObject.shareObject = shareObject
        UMSocialManager.default()?.share(to: platformType, messageObject: messageObject, currentViewController: self.currentVC, completion: { (data, error) in
            if (error != nil) {
                print("************Share fail with error " )
            } else {
                showTextToast(text: "分享成功", view: self.currentVC!.view)
            }
        })
    }
    
    
}


