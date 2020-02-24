//
//  HttpRequestEngine.swift
//  SnailGame
//
//  Created by Edison on 2019/9/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import Alamofire

typealias HttpSuccessResponseBlock = (NSDictionary) -> Void

typealias HttpFailedResponseBlock = (DataResponse<Any>) -> Void

let BusinessResponseSuccess = 1000 //成功

let BusinessResponseDistanceLogin = 2003 //异地登陆

let BusinessResponseSessionExpire = 2002 //登录过期

class HttpRequestEngine: NSObject {

    func snailGetRequest(url:String,paramters:NSDictionary,needTime:String,successResponse: @escaping HttpSuccessResponseBlock,failedResponse: @escaping HttpFailedResponseBlock) {
        
        let mdict = NSMutableDictionary.init(dictionary: paramters)
        if needTime == "1" {
            let time = Int(NSDate.init().timeIntervalSince1970)
            mdict.setValue(String(time), forKey: "time")
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "text/plain",
            "Accept": "application/json",
            "app_id":"89dtd90a",
            "Version": getAppVersion(),
            "device-code" : getPhoneUdid(),
            "User-Agent" : getUserAgent()
        ]
        
        Alamofire.request(url as URLConvertible, method: HTTPMethod.get, parameters: (mdict as! Parameters), encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                let jsonStr = String(data: response.data!, encoding: String.Encoding.utf8)
                let result = getDictionaryFromJSONString(jsonString: jsonStr!)
                if result.isKind(of: NSDictionary.self) && jsonStr?.count != 0 {
                    successResponse(result)
                }else{
                    failedResponse(response)
                }
        }
    }
    
    func snailPostRequest(url:String,paramters:NSDictionary,successResponse: @escaping HttpSuccessResponseBlock,failedResponse: @escaping HttpFailedResponseBlock) {
        
        let mdict = NSMutableDictionary.init(dictionary: paramters)
        let time = Int(NSDate.init().timeIntervalSince1970)
        mdict.setValue(String(time), forKey: "time")
        
        let urlStr = BASE_HOST+"/"+url
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
            "app_id":"89dtd90a",
            "Version": getAppVersion(),
            "device-code" : getPhoneUdid(),
            "User-Agent" : getUserAgent()
        ]
        
        Alamofire.request(urlStr, method: .post, parameters: (mdict as! Parameters), encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let loadStr = String(data: response.data!, encoding: String.Encoding.utf8)
            let result = getDictionaryFromJSONString(jsonString: loadStr!)
            if result["code"] != nil {
                successResponse(result)
            }else{
                failedResponse(response)
            }
        }
    }
    
    func snailPostC1Request(url:String,paramters:NSDictionary,successResponse: @escaping HttpSuccessResponseBlock,failedResponse: @escaping HttpFailedResponseBlock) {
        
        let mdict = NSMutableDictionary.init(dictionary: paramters)
        let time = Int(NSDate.init().timeIntervalSince1970)
        mdict.setValue(String(time), forKey: "time")
        let param_before = getJSONStringFromDictionary(dictionary: mdict)
        let param_after = upC1_aci_encrypt(jsonStr: param_before)
        let jsonParameter = NSMutableDictionary.init()
        jsonParameter.setValue(param_after, forKey: "jsonParameter")
        
        let urlStr = BASE_HOST+"/c1/"+url
        
        var sessionStr = ""
        if UserDefaults.standard.object(forKey:SESSION) != nil {
            sessionStr = "PHPSESSID=" + (UserDefaults.standard.object(forKey:SESSION) as! String)
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "text/plain",
            "Accept": "application/json",
            "app_id":"89dtd90a",
            "Version": getAppVersion(),
            "device-code" : getPhoneUdid(),
            "User-Agent" : getUserAgent(),
            "cookie" : sessionStr
        ]
        
        Alamofire.request(urlStr, method: .post, parameters: (jsonParameter as! Parameters), encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let loadStr = String(data: response.data!, encoding: String.Encoding.utf8)
            let jsonStr = downC1_aci_decrypt(encodStr: loadStr!)
            let result = getDictionaryFromJSONString(jsonString: jsonStr)
            if result["code"] != nil {
                let code = result["code"] as! Int
                if code == BusinessResponseDistanceLogin {
                    abnormalAccount(msg:"账号异地登录，请重新登录")
                } else if code == BusinessResponseSessionExpire {
                    abnormalAccount(msg:"登录失效，请重新登录")
                } else {
                    successResponse(result)
                }
            }else{
                failedResponse(response)
            }
        }
    }
    
    func snailPostC2Request(url:String,paramters:NSDictionary,successResponse: @escaping HttpSuccessResponseBlock,failedResponse: @escaping HttpFailedResponseBlock) {
        
        let mdict = NSMutableDictionary.init(dictionary: paramters)
        let time = Int(NSDate.init().timeIntervalSince1970)
        mdict.setValue(String(time), forKey: "time")
        let param_before = getJSONStringFromDictionary(dictionary: mdict)
        let param_after = upC2_aci_encrypt(jsonStr: param_before)
        let jsonParameter = NSMutableDictionary.init()
        jsonParameter.setValue(param_after, forKey: "jsonParameter")
        
        let urlStr = BASE_HOST+"/c2/"+url
        
        var sessionStr = ""
        if UserDefaults.standard.object(forKey:SESSION) != nil {
            sessionStr = "PHPSESSID=" + (UserDefaults.standard.object(forKey:SESSION) as! String)
        }
    
        let headers: HTTPHeaders = [
            "Content-Type": "text/plain",
            "Accept": "application/json",
            "app_id":"89dtd90a",
            "Version": getAppVersion(),
            "device-code" : getPhoneUdid(),
            "User-Agent" : getUserAgent(),
            "cookie" : sessionStr
        ]
 
        Alamofire.request(urlStr, method: .post, parameters: (jsonParameter as! Parameters), encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let loadStr = String(data: response.data!, encoding: String.Encoding.utf8)
            let jsonStr = downC2_aci_decrypt(encodStr: loadStr!)
            let result = getDictionaryFromJSONString(jsonString: jsonStr)
            if result["code"] != nil {
                let code = result["code"] as! Int
                if code == BusinessResponseDistanceLogin {
                    abnormalAccount(msg:"账号异地登录，请重新登录")
                } else if code == BusinessResponseSessionExpire {
                    abnormalAccount(msg:"登录失效，请重新登录")
                } else {
                    successResponse(result)
                }
            }else{
                failedResponse(response)
            }
        }
    }
    
    func snailPostGameRequest(url:String,paramters:NSDictionary,successResponse: @escaping HttpSuccessResponseBlock,failedResponse: @escaping HttpFailedResponseBlock) {
        
        let mdict = NSMutableDictionary.init(dictionary: paramters)
        let time = Int(NSDate.init().timeIntervalSince1970)
        mdict.setValue(String(time), forKey: "time")
        let param_before = getJSONStringFromDictionary(dictionary: mdict)
        let param_after = upGame_aci_encrypt(jsonStr: param_before)
        let jsonParameter = NSMutableDictionary.init()
        jsonParameter.setValue(param_after, forKey: "jsonParameter")
        
        let urlStr = url
        
        var sessionStr = ""
        if UserDefaults.standard.object(forKey:SESSION) != nil {
            sessionStr = "PHPSESSID=" + (UserDefaults.standard.object(forKey:SESSION) as! String)
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "text/plain",
            "Accept": "application/json",
            "app_id":"89dtd90a",
            "Version": getAppVersion(),
            "device-code" : getPhoneUdid(),
            "User-Agent" : getUserAgent(),
            "cookie" : sessionStr
        ]
        
        Alamofire.request(urlStr, method: .post, parameters: (jsonParameter as! Parameters), encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let loadStr = String(data: response.data!, encoding: String.Encoding.utf8)
            let jsonStr = downGame_aci_decrypt(encodStr: loadStr!)
            let result = getDictionaryFromJSONString(jsonString: jsonStr)
            if result["code"] != nil {
                let model = BaseModel.deserialize(from: result)
                if model?.code == BusinessResponseDistanceLogin {
                    abnormalAccount(msg:"账号异地登录，请重新登录")
                } else if model?.code == BusinessResponseSessionExpire {
                    abnormalAccount(msg:"登录失效，请重新登录")
                } else {
                    successResponse(result)
                }
            }else{
                failedResponse(response)
            }
        }
    }
    
    func snailUploadRequest(data:Data,paramters:NSDictionary,successResponse: @escaping HttpSuccessResponseBlock,failedResponse: @escaping HttpFailedResponseBlock) {
        let urlStr = BASE_HOST+"/image"
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: "img", fileName: "file.png", mimeType: "image/png")
            for (key, value) in paramters {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key as! String)
            }
        }, to: urlStr) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let data = response.data {
                        let loadStr = String(data: data, encoding: String.Encoding.utf8)
                        let result = getDictionaryFromJSONString(jsonString: loadStr!)
                        successResponse(result)
                    } else {
                        failedResponse(response)
                    }
                }
                break
            case .failure(let encodingError):
                failedResponse(encodingError as! DataResponse<Any>)
                break
                
            }
        }
    }
    
}



