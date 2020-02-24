//
//  BusinessEngine.swift
//  SnailGame
//
//  Created by Edison on 2019/9/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias BusinessSuccessResponseBlock = (BaseModel) -> Void

typealias BusinessGameSuccessResponseBlock = (NSDictionary) -> Void

typealias BusinessFailedResponseBlock = (BaseModel) -> Void

class BusinessEngine: HttpRequestEngine {
    
    /// 获取本地用户信息
    ///
    /// - Returns: 用户信息
    func getLoginUserModel() -> UserLoginDataModel {
        let str = UserDefaults.standard.string(forKey: USERDATA)
        if str != nil  {
            let userModel = UserLoginDataModel.deserialize(from: str)
            return userModel!
        }
        return UserLoginDataModel.init()
    }
    
    /// 清空本地用户信息
    func clearLocalUserInfoModel() {
        UserDefaults.standard.removeObject(forKey: SESSION)
        UserDefaults.standard.removeObject(forKey: USERDATA)
    }
    
    /// 获取本地链上钱包余额
    func getLinkWalletBalance() -> String {
        return UserDefaults.standard.string(forKey: BALANCE)!
    }
    
    /// 获取配置文件
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func getNetWorkConfig(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSDictionary.init()
        snailGetRequest(url: BASE_CONFIG, paramters: dict, needTime: "1", successResponse: { (result) in
            let text:String = result.object(forKey: "text") as! String
            let text_decrypt = downC2_aci_decrypt(encodStr: text)
            let dic_config = getDictionaryFromJSONString(jsonString: text_decrypt)
            let configModel = ConfigModel.deserialize(from: dic_config)
            let userDefault = UserDefaults.standard
            userDefault.set(configModel?.toJSONString(), forKey: GAMECONFIG)
            successResponse(configModel!)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取所有网络节点
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func getNetworkPeers(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSDictionary.init()
        snailGetRequest(url: BASE_PEERS, paramters: dict, needTime: "1", successResponse: { (result) in
            let allPort = AllPortModel.deserialize(from: result)
            successResponse(allPort!)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取网络节点
    ///
    /// - Parameters:
    ///   - ip: ip
    ///   - port: 端口号
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getNetWorkPort(ip:String,port:NSInteger,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock)  {
        let dict = NSDictionary.init()
        let urlStr = "http://" + ip +  ":4103/api/v2/transactions/fees"
        snailGetRequest(url: urlStr, paramters: dict, needTime: "1", successResponse: { (result) in
            let model = SnailDynamicModel.deserialize(from: result)
            model?.data?.ip = ip
            model?.data?.port = port
            let userDefault = UserDefaults.standard
            userDefault.set(model?.data?.toJSONString(), forKey: NetWorkPort)
            successResponse(model!)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取更新信息
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func update(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(getAppVersion(), forKey: "versions")
        dict.setValue(params, forKey: "params")

        snailPostRequest(url: "update", paramters: dict, successResponse: { (result) in
            let model = VersionModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                UserDefaults.standard.set(model!.data!.is_pass, forKey: PASS)
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
//
//        let params = ["params":["versions":getAppVersion()]]
//
//        let urlStr = BASE_HOST+"/update"
//
//        let session = URLSession.shared
//
//        var request = URLRequest.init(url: URL.init(string: urlStr)!)
//
//        request.httpMethod = "POST"
//
//        request.timeoutInterval = 60
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        request.setValue(getUserAgent(), forHTTPHeaderField: "User-Agent")
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: params, options: [])
//
//        request.httpBody = jsonData
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if (data != nil)
//            {
//                do {
//                    let dict : NSDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
//                    if dict["code"] != nil {
//                        let model = VersionModel.deserialize(from: dict)
//                        if model?.code == BusinessResponseSuccess {
//                            successResponse(model!)
//                        } else {
//                            failedResponse(model!);
//                        }
//                    }else{
//                        let failModel = BaseModel.init()
//                        failModel.code = 10005
//                        failModel.message = "服务器错误"
//                        failedResponse(failModel);
//                    }
//                } catch {
//                    let failModel = BaseModel.init()
//                    failModel.code = 10005
//                    failModel.message = "服务器错误"
//                    failedResponse(failModel);
//                }
//            }
//        }
//        task.resume()
    }
    
    /// 人机验证
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - sign: 参数
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func humanVerify(type:String,sign:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dic = getDictionaryFromJSONString(jsonString: sign)
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init(dictionary: dic)
        params.setValue(type, forKey: "type")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Member/afsVerify", paramters: dict, successResponse: { (result) in
            let model = HumanVerifyModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                let userDefault = UserDefaults.standard
                userDefault.set(model?.data?.session, forKey: SESSION)
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取验证码
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - type: 类型
    ///   - region: 区号
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func sendCode(mobile:String,type:String,region:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(mobile, forKey: "mobile")
        params.setValue(type, forKey: "type")
        params.setValue(region, forKey: "region")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Member/sendCode", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 检查验证码
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - verifyCode: 验证码
    ///   - mobile: 手机号
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func checkCode(type:String,verifyCode:String,mobile:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(mobile, forKey: "mobile")
        params.setValue(type, forKey: "type")
        params.setValue(verifyCode, forKey: "code")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Member/checkCode", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 验证码登录
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - code: 验证码
    ///   - region: 区号
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func sendCodeLogin(mobile:String,code:String,region:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(mobile, forKey: "mobile")
        params.setValue(code, forKey: "code")
        params.setValue(region, forKey: "region")
        dict.setValue(params, forKey: "params")
        
        snailPostC1Request(url: "v1.Member/login", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取用户信息
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getUserInfo(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/userInfo", paramters: dict, successResponse: { (result) in
            let model = UserLoginModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                if model?.data?.status == 4 || model?.data?.status == 5 || model?.data?.status == 6  {
                    let userDefault = UserDefaults.standard
                    userDefault.set(model?.data?.toJSONString(), forKey: USERDATA)
                }
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取链上钱包余额
    ///
    /// - Parameters:
    ///   - walletAddress: 钱包地址
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func updateLinkWallet(walletAddress:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let str = UserDefaults.standard.string(forKey: NetWorkPort)
        let portModel = SnailDynamicFeesModel.deserialize(from: str)
        let urlStr = "http://" + portModel!.ip! + ":4103/api/wallets/" + walletAddress
        snailGetRequest(url: urlStr, paramters: dict, needTime: "", successResponse: { (result) in
            
            let model = WalletModel.deserialize(from: result)
            var balance = "0"
            if model?.data != nil {
                balance = (model?.data!.balance)!
            }
            let userDefault = UserDefaults.standard
            userDefault.set(balance, forKey: BALANCE)
            
            if result["statusCode"] != nil {
                let failModel = BaseModel.init()
                failModel.code = 404
                failModel.message = "Wallet not found"
                failedResponse(failModel);
            } else {
                successResponse(model!)
            }
            
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取链上钱包交易记录
    /// - Parameter pageNum: 页码
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func getWalletRecord(walletAddress:String,pageNum:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let str = UserDefaults.standard.string(forKey: NetWorkPort)
        let portModel = SnailDynamicFeesModel.deserialize(from: str)
        let urlStr = "http://" + portModel!.ip! + ":4103/api/wallets/" + walletAddress + "/transactions?page=" + pageNum + "&limit=50"
        snailGetRequest(url: urlStr, paramters: dict, needTime: "", successResponse: { (result) in
            let model = TradeRecordModel.deserialize(from: result)
            successResponse(model!)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 开屏广告
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func welcomeAdvert(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let urlStr = BASE_HOST+"/advertising"
        snailGetRequest(url: urlStr, paramters: dict, needTime: "1", successResponse: { (result) in
            let model = WelcomeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 快讯
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func mornNews(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.App/mornNews", paramters: dict, successResponse: { (result) in
            let model = MornNewsModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 消息推送
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func noticePush(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v2.Member/noticePush", paramters: dict, successResponse: { (result) in
            let model = NoticePushModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - code: 验证码
    ///   - referrer: 推广码
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func register(mobile:String,code:String,referrer:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(mobile, forKey: "mobile")
        params.setValue(code, forKey: "code")
        if referrer.count != 0 {
            params.setValue(referrer, forKey: "referrer")
        }
        dict.setValue(params, forKey: "params")
        
        snailPostC1Request(url: "v1.Member/register", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 上传图片
    ///
    /// - Parameters:
    ///   - data: 图片
    ///   - type: 类型
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func uploadImage(data:Data,type:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        dict.setValue(type, forKey: "dir")
        snailUploadRequest(data: data, paramters: dict, successResponse: { (result) in
            let model = UploadImageModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 修改用户信息
    ///
    /// - Parameters:
    ///   - params: 参数
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func updateUserData(params:NSDictionary,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Member/userEdit", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 徽章墙
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func trinketWallList(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/badgeList", paramters: dict, successResponse: { (result) in
            let model = TrinketWallModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取vip信息
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getVipInfo(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/vipInfo", paramters: dict, successResponse: { (result) in
            let model = VipInfoModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess || model?.code == 1001 {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 购买vip
    ///
    /// - Parameters:
    ///   - psw: 支付密码
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func vipBuy(psw:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(psw, forKey: "pay_password")
        dict.setValue(params, forKey: "params")
        snailPostC1Request(url: "v1.Verify/vipBuy", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 支付密码验证
    ///
    /// - Parameters:
    ///   - code: 支付密码
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func payVerify(code:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        param.setValue(code, forKey: "pay_password")
        dict.setValue(param, forKey: "params")
        snailPostC2Request(url: "v1.Member/payVerify", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// ETH兑换DWN兑换比列
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func ethToDwn(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSDictionary.init()
        let urlStr = BASE_HOST + "/ethToDwn"
        snailGetRequest(url: urlStr, paramters: dict, needTime: "1", successResponse: { (result) in
            let model = EthRatioModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取以太记录
    /// - Parameter pageNum: 页码
    /// - Parameter currency: 类型
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func getCurrencyList(pageNum:String,currency:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        order.setValue("id", forKey: "desc")
        dict.setValue(order, forKey: "order")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("10", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        param.setValue(currency, forKey: "currency")
        dict.setValue(param, forKey: "params")
        snailPostC2Request(url: "v1.Currency/getList", paramters: dict, successResponse: { (result) in
            let model = EthRecordModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 货币充值(获取货币公共地址)
    /// - Parameter currency: 货币
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func ethDeposit(currency:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        param.setValue(currency, forKey: "currency")
        dict.setValue(param, forKey: "params")
        
        snailPostC2Request(url: "v1.Currency/in", paramters: dict, successResponse: { (result) in
            let model = DepositEthModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// ETH兑换dwn
    /// - Parameter num: 数量
    /// - Parameter payPassword: 密码
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func exchangeEth(num:String,payPassword:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        param.setValue(num, forKey: "num")
        param.setValue(payPassword, forKey: "pay_password")
        dict.setValue(param, forKey: "params")
        
        snailPostC2Request(url: "v1.Currency/exchangeEth", paramters: dict, successResponse: { (result) in
            let model = DepositEthModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 从社区提币到个人蜗牛钱包
    ///
    /// - Parameters:
    ///   - num: 数量
    ///   - address: 地址
    ///   - remark: 备注
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func mentionMoney(num:String,address:String,remark:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let numStr = calculateAChengyiB(a: num, b: TOKEN_RATIO)
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        param.setValue(remark, forKey: "vendor_field")
        param.setValue(address, forKey: "wallet_address")
        param.setValue(numStr, forKey: "num")
        dict.setValue(param, forKey: "params")
        
        snailPostC1Request(url: "v1.Account/exchange", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 提存记录
    /// - Parameter pageNum: 页码
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func depositRecordList(pageNum:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        order.setValue("id", forKey: "desc")
        dict.setValue(order, forKey: "order")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        
        snailPostC2Request(url: "v1.Account/getList", paramters: dict, successResponse: { (result) in
            let model = EscrowRecordModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 生成转入社区ID
    ///
    /// - Parameters:
    ///   - num: 数量
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func recharge(num:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let numStr = calculateAChengyiB(a: num, b: TOKEN_RATIO)
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        param.setValue(BusinessEngine.init().getLoginUserModel().wallet_address, forKey: "wallet_address")
        param.setValue(numStr, forKey: "num")
        dict.setValue(param, forKey: "params")
        snailPostC2Request(url: "v1.Account/recharge", paramters: dict, successResponse: { (result) in
            let model = RechargeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 刷新社区钱包
    ///
    /// - Parameters:
    ///   - r_id: r_id
    ///   - t_id: t_id
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func rechargeUpdate(r_id:String,t_id:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let param = NSMutableDictionary.init()
        param.setValue(r_id, forKey: "id")
        param.setValue(t_id, forKey: "transaction_id")
        dict.setValue(param, forKey: "params")
        snailPostC2Request(url: "v1.Account/rechargeUpdate", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取DWN变动记录
    /// - Parameter pageNum: y页码
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func getWealthChangeList(pageNum:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        snailPostC2Request(url: "v2.Transaction/getList", paramters: dict, successResponse: { (result) in
            let model = CandyRecordModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取首页轮播广告
    ///
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    ///   - pageNum: 页码
    ///   - type: 类型
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func appBanner(key:String,value:String,pageNum:String,type:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        
        if key.count != 0 && value.count != 0 {
            order.setValue(value, forKey: key)
            dict.setValue(order, forKey: "order")
        }
        params.setValue(type, forKey: "type")
        dict.setValue(params, forKey: "params")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        
        snailPostC2Request(url: "v1.App/banner", paramters: dict, successResponse: { (result) in
            let model = BannerModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
        
    }
    
    /// 个人推广码
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func promotionCode(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/qrCode", paramters: dict, successResponse: { (result) in
            let model = PromotionCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 推广记录列表
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getPromotionRecords(pageNum:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        
        snailPostC2Request(url: "v1.Member/popularizeList", paramters: dict, successResponse: { (result) in
            let model = PromotionRecordModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 任务奖励列表
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getQuestRewards(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v2.Activity/getList", paramters: dict, successResponse: { (result) in
            let model = QuestRewardsModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 领取奖励
    ///
    /// - Parameters:
    ///   - taskId: 任务id
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func drawReward(taskId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(taskId, forKey: "id")
        dict.setValue(params, forKey: "params")
        
        snailPostC1Request(url: "v1.Activity/draw", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取消息列表
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getNoticeList(pageNum:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        snailPostC2Request(url: "v1.Member/noticeList", paramters: dict, successResponse: { (result) in
            let model = NoticeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 读取消息
    ///
    /// - Parameters:
    ///   - noitceId: 消息id
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func readNotice(noitceId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(noitceId, forKey: "notice_id")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Member/noticeRead", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 提交留言
    ///
    /// - Parameters:
    ///   - msg: 留言
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func submitMsg(msg:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(msg, forKey: "content")
        params.setValue("2", forKey: "type")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Feedback/submitMsg", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取资讯列表
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - sort: 排行
    ///   - linkId: linkId
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getInfoList(pageNum:String,sort:String,linkId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        
        order.setValue(sort, forKey: "desc")
        dict.setValue(order, forKey: "order")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        if linkId.count != 0 {
            params.setValue(linkId, forKey: "id")
            dict.setValue(params, forKey: "params")
        }
        
        snailPostC2Request(url: "v1.Information/getList", paramters: dict, successResponse: { (result) in
            let model = InfoListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 点赞信息详情
    /// - Parameter infoId: 信息id
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func giveLikeInfo(infoId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(infoId, forKey: "id")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Information/star", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 推荐游戏
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func recommentGame(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.App/recommendation", paramters: dict, successResponse: { (result) in
            let model = RecommentGameModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 评论资讯
    /// - Parameter content: 评论内容
    /// - Parameter infoId: infoId
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func commentInfo(content:String,infoId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(infoId, forKey: "info_id")
        params.setValue(content, forKey: "content")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Information/comment", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 蜗牛百科
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getWikipeList(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        
        order.setValue("id", forKey: "asc")
        dict.setValue(order, forKey: "order")
        params.setValue("12", forKey: "cate")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Information/getList", paramters: dict, successResponse: { (result) in
            let model = InfoListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取签到列表
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func signToday(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/signToday", paramters: dict, successResponse: { (result) in
            let model = DailyClockModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess || model?.code == 1001 {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 签到
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func sign(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/sign", paramters: dict, successResponse: { (result) in
            let model = DailySignModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess || model?.code == 1001 {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取快讯列表数据
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - sort: 排行
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getAlertsList(pageNum:String,sort:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        order.setValue(sort, forKey: "desc")
        dict.setValue(order, forKey: "order")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        
        snailPostC2Request(url: "v1.Newsflash/getList", paramters: dict, successResponse: { (result) in
            let model = AlertsListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取牛说列表数据
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - sort: 排行
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getCowSayList(pageNum:String,sort:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        order.setValue(sort, forKey: "desc")
        dict.setValue(order, forKey: "order")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        
        snailPostC2Request(url: "v1.Message/getList", paramters: dict, successResponse: { (result) in
            let model = CowSayModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 发表牛说
    ///
    /// - Parameters:
    ///   - speak: 内容
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func updateSpeak(speak:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(speak, forKey: "content")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.Message/comment", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取行情列表
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - key: 升序或降序  asc 升序。 dsc 降序
    ///   - value: 根据哪个字段排序  市值，价格，涨跌幅
    ///   - range: 范围 own自选 all所有
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getMarketList(pageNum:String,key:String,value:String,range:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        
        if key.count != 0 && value.count != 0 {
            order.setValue(value, forKey: key)
            dict.setValue(order, forKey: "order")
        }
        params.setValue(range, forKey: "range")
        dict.setValue(params, forKey: "params")
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        
        snailPostC2Request(url: "v1.Currencymarket/getCurrencyMarket", paramters: dict, successResponse: { (result) in
            let model = MarketListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 行情搜索
    /// - Parameter keyword: 关键字
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func marketSearch(keyword:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(keyword, forKey: "keyword")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Currencymarket/search", paramters: dict, successResponse: { (result) in
            let model = MarketListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 行情收藏信息
    /// - Parameter currencyCode: code
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func favoriteExit(currencyCode:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(currencyCode, forKey: "currency_code")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Currencymarket/favoriteExit", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 取消行情收藏
    /// - Parameter currencyCode: code
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func favoriteCancel(currencyCode:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(currencyCode, forKey: "currency_code")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Currencymarket/favoriteCancel", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 添加行情收藏
    /// - Parameter currencyCode: code
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func favorite(currencyCode:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(currencyCode, forKey: "currency_code")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Currencymarket/Favorite", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取游戏列表
    ///
    /// - Parameters:
    ///   - pageNum: 页码
    ///   - key: key
    ///   - value: value
    ///   - linkId: linkId
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getGameList(pageNum:String,key:String,value:String,type:String,linkId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        
        if key.count != 0 && value.count != 0 {
            order.setValue(value, forKey: key)
            dict.setValue(order, forKey: "order")
        }
        
        pagination.setValue(pageNum, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        if linkId.count != 0 {
            params.setValue(linkId, forKey: "id")
            dict.setValue(params, forKey: "params")
        }
        if type.count != 0 {
            params.setValue(type, forKey: "tag")
            dict.setValue(params, forKey: "params")
        }
        
        snailPostC2Request(url: "v1.App/appList", paramters: dict, successResponse: { (result) in
            let model = GameListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 未pass的游戏列表
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getUnPassGameList(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let order = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        
        order.setValue("id", forKey: "desc")
        dict.setValue(order, forKey: "order")
        
        pagination.setValue("1", forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
     
        snailPostC2Request(url: "v2.App/appList", paramters: dict, successResponse: { (result) in
            let model = GameListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 发现首页
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func getFindList(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.App/home", paramters: dict, successResponse: { (result) in
            let model = FindListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 游戏记录
    /// - Parameters:
    ///   - app_id: appId
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func gameRecord(appId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        if appId.count != 0 {
            let params = NSMutableDictionary.init()
            params.setValue(appId, forKey: "app_id")
            dict.setValue(params, forKey: "params")
        }
        snailPostC2Request(url: "v1.App/record", paramters: dict, successResponse: { (result) in
            let model = FindRecordModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }

    /// 上传游戏结果
    ///
    /// - Parameters:
    ///   - datas: 参数
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func uploadGameResult(datas:String,successResponse:@escaping BusinessGameSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = getDictionaryFromJSONString(jsonString: datas)
        let str : String = dict["Action"] as! String
        if str.count == 0 {
            return
        }
        let loadUrl = GAME_HOST + "/" + str
        
        snailPostGameRequest(url: loadUrl, paramters: dict, successResponse: { (result) in
            successResponse(result)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 分段上传游戏数据
    ///
    /// - Parameters:
    ///   - jsonData: 参数
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func piecewiseUploadData(jsonData:String,successResponse:@escaping BusinessGameSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = getDictionaryFromJSONString(jsonString: jsonData)
        let str : String = dict["Action"] as! String
        if str.count == 0 {
            return
        }
        let loadUrl = GAME_HOST + "/" + str
        
        snailPostGameRequest(url: loadUrl, paramters: dict, successResponse: { (result) in
            successResponse(result)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 游戏支付
    /// - Parameters:
    ///   - jsonData: 参数
    ///   - appId: appId
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func gamePay(jsonData:String,appId:String,successResponse:@escaping BusinessGameSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = getDictionaryFromJSONString(jsonString: jsonData)
        params.setValue(appId, forKey: "app_id")
        dict.setValue(params, forKey: "params")
        
        let loadUrl = GAME_HOST + "/Dwnpay/pay"
        snailPostGameRequest(url: loadUrl, paramters: dict, successResponse: { (result) in
            successResponse(result)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 游戏换算dwn比例
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func dwnPrise(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSDictionary.init()
        let urlStr = BASE_HOST + "/dwnPrise"
        snailGetRequest(url: urlStr, paramters: dict, needTime: "1", successResponse: { (result) in
            let model = GamePriceModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 红包支付接口
    /// - Parameter urlStr: 接口地址
    /// - Parameter params: 参数
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func redPay(urlStr:String,params:NSDictionary,successResponse:@escaping BusinessGameSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init(dictionary: params)
        snailPostC2Request(url: urlStr, paramters: dict, successResponse: { (result) in
            successResponse(result)
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 游戏排行榜
    /// - Parameter range: 类型
    /// - Parameter appId: 游戏id
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func getRankingList(range:String,appId:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        
        let dict = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        pagination.setValue("1", forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        params.setValue(range, forKey: "range")
        params.setValue(appId, forKey: "app_id")
        dict.setValue(params, forKey: "params")
        
        snailPostC2Request(url: "v1.App/getRankingList", paramters: dict, successResponse: { (result) in
            let model = RankListModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 糖果兑换信息
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func CandyChangeInfo(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Candy/ratioChange", paramters: dict, successResponse: { (result) in
            let model = CandyExchangeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 糖果兑换dwn
    /// - Parameter candyNum: 糖果数量
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func candyExchange(candyNum:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(candyNum, forKey: "candy_num")
        dict.setValue(params, forKey: "params")
        snailPostC2Request(url: "v1.Candy/exchange", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 糖果变动记录
    /// - Parameter page: 页码
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func candyRecordList(page:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let pagination = NSMutableDictionary.init()
        pagination.setValue(page, forKey: "page")
        pagination.setValue("20", forKey: "pagesize")
        dict.setValue(pagination, forKey: "pagination")
        snailPostC2Request(url: "v1.Candy/getLIst", paramters: dict, successResponse: { (result) in
            let model = CandyRecordModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 实名认证
    /// - Parameter userName: 姓名
    /// - Parameter id_card: 身份证
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func usernameVerify(userName:String,idCard:String,successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        let params = NSMutableDictionary.init()
        params.setValue(userName, forKey: "username")
        params.setValue(idCard, forKey: "id_card")
        dict.setValue(params, forKey: "params")
        snailPostC1Request(url: "v1.Member/idCardVerify", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 获取空投数据
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func airDrop(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.App/airDrop", paramters: dict, successResponse: { (result) in
            let model = LuckyDropModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 领取空投
    /// - Parameter successResponse: 成功
    /// - Parameter failedResponse: 失败
    func airDropDraw(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.App/airDropDraw", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
    
    /// 退出登录接口
    ///
    /// - Parameters:
    ///   - successResponse: 成功
    ///   - failedResponse: 失败
    func logout(successResponse:@escaping BusinessSuccessResponseBlock,failedResponse:@escaping BusinessFailedResponseBlock) {
        let dict = NSMutableDictionary.init()
        snailPostC2Request(url: "v1.Member/outLogin", paramters: dict, successResponse: { (result) in
            let model = SendCodeModel.deserialize(from: result)
            if model?.code == BusinessResponseSuccess {
                successResponse(model!)
            }else{
                failedResponse(model!);
            }
        }) { (response) in
            let failModel = BaseModel.init()
            failModel.code = 10005
            failModel.message = "服务器错误"
            failedResponse(failModel);
        }
    }
}
