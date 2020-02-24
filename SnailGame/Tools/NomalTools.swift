//
//  NomalTools.swift
//  SnailGame
//
//  Created by Edison on 2019/9/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import Toast_Swift

let C1_Encrypt_Key = "15b96cf16e3a38ed"
let C1_Encrypt_Iv = "4a15460b2af0e3d4"
let C1_Decrypt_Key = "4a15460b2af0e3d4"
let C1_Decrypt_Iv = "15b96cf16e3a38ed"
let C2_Encrypt_Key = "3e1c84ac14e3a568"
let C2_Encrypt_Iv = "aad2a7dea16e161d"
let C2_Decrypt_Key = "aad2a7dea16e161d"
let C2_Decrypt_Iv = "3e1c84ac14e3a568"
let Game_Encrypt_Key = "9a0361b55eb5cd31"
let Game_Encrypt_Iv = "a43fd9deb37f8437"
let Game_Decrypt_Key = "a43fd9deb37f8437"
let Game_Decrypt_Iv = "9a0361b55eb5cd31"
let secret_Encrypt_Key = "b966d6bbc3ac62dc"
let secret_Encrypt_Iv = "cd7b3c3c96b277c1"
let secret_Decrypt_Key = "b966d6bbc3ac62dc"
let secret_Decrypt_Iv = "cd7b3c3c96b277c1"

let FAMERUSER = "famer_user"
let GAMECONFIG = "gameConfig"
let NetWorkPort = "NetWorkPort"
let USERDATA = "user_data"
let BALANCE = "link_balance"
let SESSION = "session"
let PASS = "is_pass"
let AUTHORY_DATE = "authory_date"

/// 判断是否登录
///
/// - Returns: 结果
func isLogin() -> Bool {
    let userModel = BusinessEngine.init().getLoginUserModel()
    if userModel.mobile != nil {
        return true
    }
    return false
}

/// 判断是否登录并跳转登录
///
/// - Returns: 登录结果
func judgeLoginAndPush() -> Bool {
    if isLogin() {
        return true
    } else {
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let currentNavi:BaseNavigationController = delegate.mainVC?.viewControllers?[(delegate.mainVC?.selectedIndex)!] as! BaseNavigationController
        let currentViewControll:BaseViewController = currentNavi.visibleViewController as! BaseViewController
        let loginVC = LoginViewController.init()
        let loginNavi = BaseNavigationController.init(rootViewController: loginVC)
        loginNavi.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        currentViewControll.present(loginNavi, animated: true, completion: nil)
        return false
    }
}

/// 账号异常退出登录
/// - Parameter msg: 消息
func abnormalAccount(msg:String) {
    let viewControllerNow = currentViewController()
    showTextToast(text: msg, view: viewControllerNow.view)
    if viewControllerNow is LoginViewController {
        return
    }
    BusinessEngine.init().clearLocalUserInfoModel()
    let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let currentNavi:BaseNavigationController = delegate.mainVC?.viewControllers?[(delegate.mainVC?.selectedIndex)!] as! BaseNavigationController
    let currentViewControll:BaseViewController = currentNavi.visibleViewController as! BaseViewController
    let loginVC = LoginViewController.init()
    let loginNavi = BaseNavigationController.init(rootViewController: loginVC)
    loginNavi.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    currentViewControll.present(loginNavi, animated: true, completion: nil)
}

/// 获取当前界面
func currentViewController() -> UIViewController {
    let viewController = UIApplication.shared.keyWindow?.rootViewController
    return atPersentViewController(vc: viewController!)
}

func atPersentViewController(vc:UIViewController) -> UIViewController {
    if (vc.presentedViewController != nil) {
        return atPersentViewController(vc: vc.presentedViewController!)
    } else if vc is BaseNavigationController {
        let svc:BaseNavigationController = vc as! BaseNavigationController
        if svc.viewControllers.count > 0 {
            return atPersentViewController(vc: svc.topViewController!)
        } else {
            return vc
        }
    } else if vc is BaseTabBarController {
        let svc:BaseTabBarController = vc as! BaseTabBarController
        if svc.viewControllers!.count > 0 {
            return atPersentViewController(vc: svc.selectedViewController!)
        } else {
            return vc
        }
    } else {
        return vc
    } 
}

/// 文字提示框
///
/// - Parameters:
///   - text: 文字
///   - view: 界面
func showTextToast(text:Any,view:UIView) {
    ToastManager.shared.isTapToDismissEnabled = true
    ToastManager.shared.duration = 1
    ToastManager.shared.position = .center
    if text == nil {
        view.makeToast("网络有问题")
    } else {
        view.makeToast(text as! String)
    }
}

/// 加载框
///
/// - Parameter view: 界面
func showLoading(view:UIView) {
    ToastManager.shared.style.activitySize = CGSize.init(width: SCREEN_WIDE, height: SCREEN_HEIGHT)
    ToastManager.shared.style.activityBackgroundColor = UIColor.clear
    ToastManager.shared.style.activityIndicatorColor = UIColor.black
    view.makeToastActivity(.center)
}

/// 判断字符串是浮点型
func isPureFloat(string:String) -> Bool {
    let scan = Scanner.init(string: string)
    var val : Float = 0.0
    return scan.scanFloat(&val) && scan.isAtEnd
}

/// 判断字符串是整形
func isPureInt(string:String) -> Bool {
    let scan = Scanner.init(string: string)
    var val : Int = 0
    return scan.scanInt(&val) && scan.isAtEnd
}

///判断字符串是两位小数浮点型
func isTwoDecimalPlaces(string:String) -> Bool {
    let phoneRegex = "^[0-9]+(\\.[0-9]{1,2})?$"
    let phoneTest = NSPredicate.init(format: "SELF MATCHES %@",phoneRegex)
    return phoneTest.evaluate(with: string)
}

/// 判断是否是正确手机号
///
/// - Parameters:
///   - regionCode: 区号
///   - phoneStr: 手机号
/// - Returns: 判断结果
func isMobilePhone(regionCode:String,phoneStr:String) -> Bool {
    if phoneStr.count == 0 {
        return false
    } else if regionCode == "86" && phoneStr.count == 11 {
        return true
    } else if regionCode == "852" && phoneStr.count == 8 {
        return true
    } else if regionCode == "886" && phoneStr.count == 9 {
        return true
    } else if regionCode == "1" && phoneStr.count == 10 {
        return true
    } else {
        return false
    }
}

/// 判断是浮点型
/// - Parameter inputStr: 输入
@available(iOS 13.0, *)
func isPureFloat(inputStr:String) -> Bool {
    let scan = Scanner.init(string: inputStr)
    return (scan.scanFloat() != nil) && scan.isAtEnd
}

/// json字符串转字典
///
/// - Parameter jsonString: json
/// - Returns: 字典
func getDictionaryFromJSONString(jsonString : String) ->NSDictionary {
    let jsonData : Data = jsonString.data(using: .utf8)!
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}


/// 字典转json字符串
///
/// - Parameter dictionary: 字典
/// - Returns: json字符串
func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

/// 获取系统版本号
///
/// - Returns: 版本号
func getAppVersion() -> String {
    let infoDictionary = Bundle.main.infoDictionary!
    let majorVersion = infoDictionary["CFBundleShortVersionString"]
    return majorVersion as! String
}

/// 获取User-Agent
func getUserAgent() -> String {
    let operaVersion = ProcessInfo.processInfo.operatingSystemVersion
    let osName = "HK-Swift " + "\(operaVersion.majorVersion).\(operaVersion.minorVersion).\(operaVersion.patchVersion)"
    let userAgent = "snailFun/" + getAppVersion() + " (iPhone; " + osName + ";" + " Scale/2.00)"
    return userAgent
}

/// 获取手机udid
///
/// - Returns: udid
func getPhoneUdid() -> String {
    let identifierNumber = UIDevice.current.identifierForVendor?.uuidString
    return identifierNumber!
}

/// 获取颜色
///
/// - Parameter hex: 色值
/// - Returns: 颜色
func colorWithHex(hex:NSInteger) -> UIColor {
    let red:CGFloat = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)(0xFF));
    let green:CGFloat = ((CGFloat)((hex >> 8) & 0xFF)) / ((CGFloat)(0xFF));
    let blue:CGFloat = ((CGFloat)((hex >> 0) & 0xFF)) / ((CGFloat)(0xFF));
    let alpha:CGFloat = hex > 0xFFFFFF ? ((CGFloat)((hex >> 24) & 0xFF)) / ((CGFloat)(0xFF)) : 1;
    return UIColor.init(red: red, green: green, blue: blue, alpha: alpha);
}

/// 生成二维码图片
///
/// - Parameter text: 字符串
/// - Returns: 二维码图片
func setupQRCodeImage(text:String) -> UIImage {
    //创建滤镜
    let filter = CIFilter.init(name: "CIQRCodeGenerator")
    filter?.setDefaults()
    //将url加入二维码
    filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
    //取出生成的二维码（不清晰）
    if let outputImage = filter?.outputImage {
        //生成清晰度更好的二维码
        let qrCodeImage = setupHighDefinitionUIImage(outputImage, size: 300)
        return qrCodeImage
    }
    return UIImage.init()
}

/// 生成高清的UIImage
///
/// - Parameters:
///   - image: 图片
///   - size: 尺寸
/// - Returns: 高清的UIImage
func setupHighDefinitionUIImage(_ image: CIImage, size: CGFloat) -> UIImage {
    let integral: CGRect = image.extent.integral
    let proportion: CGFloat = min(size/integral.width, size/integral.height)
    
    let width = integral.width * proportion
    let height = integral.height * proportion
    let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
    let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
    
    let context = CIContext(options: nil)
    let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
    
    bitmapRef.interpolationQuality = CGInterpolationQuality.none
    bitmapRef.scaleBy(x: proportion, y: proportion);
    bitmapRef.draw(bitmapImage, in: integral);
    let image: CGImage = bitmapRef.makeImage()!
    return UIImage(cgImage: image)
}

/// 把view裁剪成图片
///
/// - Parameter view: view
/// - Returns: image
func tailorViewToImage(view:UIView) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
    let ctx = UIGraphicsGetCurrentContext()
    view.layer.render(in: ctx!)
    let tImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return tImage!
}

/// 把日期格式转为日期字符串
///
/// - Parameter dateStr: 日期字符串
func changeDateToTime(dateStr:String) -> String {
    var utcDate = dateStr.replacingOccurrences(of: "Z", with: "0")
    utcDate = utcDate.replacingOccurrences(of: ".", with: "+")
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let localTimeZone = NSTimeZone.local
    dateFormatter.timeZone = localTimeZone
    let dateFormatted = dateFormatter.date(from: utcDate)
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.string(from: dateFormatted!)
}

/// 时间戳转日期格式
///
/// - Parameter stamp: 时间戳
/// - Returns: 时间字符串
func intervalSinceNow(stamp:String) -> String {
    let theTamp = Int(stamp)
    let nowTamp = Int(NSDate().timeIntervalSince1970)
    let diffTamp = nowTamp - theTamp!
    if diffTamp / 3600 / 24 > 0 {
        let date = Date.init(timeIntervalSince1970: (TimeInterval(stamp))!)
        let dformatter = DateFormatter.init()
        dformatter.dateFormat = "yyyy年MM月dd日"
        return dformatter.string(from: date)
    } else if diffTamp / 3600 > 0 {
        let hour = diffTamp / 3600
        return String(hour)+"小时前"
    } else if diffTamp / 60 > 0 {
        let minute = diffTamp / 60
        return String(minute)+"分钟前"
    } else if diffTamp > 0 {
        return String(diffTamp)+"秒前"
    } else {
        return "现在"
    }
}

/// 时间戳转日期格式
///
/// - Parameter stamp: 时间戳
/// - Returns: 时间字符串
func timeStampToDate(stamp:Int) -> String {
    let date = Date.init(timeIntervalSince1970: (TimeInterval(stamp)))
    let dformatter = DateFormatter.init()
    dformatter.dateFormat = "yyyy年MM月dd日"
    return dformatter.string(from: date)
}

/// 时间戳转时分格式
///
/// - Parameter stamp: 时间戳
/// - Returns: 时分
func getTimeFromStamp(stamp:String) -> String {
    let date = Date.init(timeIntervalSince1970: (TimeInterval(stamp))!)
    let dformatter = DateFormatter.init()
    dformatter.dateFormat = "HH:mm"
    return dformatter.string(from: date)
}

/// 两个按钮弹出框
///
/// - Parameters:
///   - currentVC: 控制器
///   - title: 标题
///   - meg: 内容
///   - cancel: 取消按钮
///   - sure: 确定按钮
///   - cancelHandler: 取消回调
///   - sureHandler: 确定回调
func showAlert(currentVC:UIViewController,title:String,meg:String,cancel:String,sure:String,cancelHandler:@escaping ((UIAlertAction) -> Void), sureHandler:@escaping ((UIAlertAction) -> Void)) {
    let alertController = UIAlertController.init(title: title, message: meg, preferredStyle: .alert)
    if cancel.count != 0 {
        let cancelAction = UIAlertAction.init(title: cancel, style: .cancel) { (action) in
            cancelHandler(action)
        }
        alertController.addAction(cancelAction)
    }
    let sureAction = UIAlertAction.init(title: sure, style: .default) { (action) in
        sureHandler(action)
    }
    alertController.addAction(sureAction)
    currentVC.present(alertController, animated: true, completion: nil)
}

/// 强制弹出框
///
/// - Parameters:
///   - currentVC: 控制器
///   - title: 标题
///   - meg: 内容
///   - sure: 确定按钮
///   - sureHandler: 确定回调
func showAlert(currentVC:UIViewController,title:String,meg:String,sure:String, sureHandler:@escaping ((UIAlertAction) -> Void)) {
    let alertController = UIAlertController.init(title: title, message: meg, preferredStyle: .alert)
    let sureAction = UIAlertAction.init(title: sure, style: .default) { (action) in
        sureHandler(action)
    }
    alertController.addAction(sureAction)
    currentVC.present(alertController, animated: false, completion: nil)
}

/// 原生底部弹框
/// - Parameter currentVC: 控制器
/// - Parameter title: 标题
/// - Parameter meg: 内容
/// - Parameter cancel: 取消按钮
/// - Parameter operas: 操作标题
/// - Parameter cancelHandler: 取消回调
/// - Parameter sureHandler: 确定回调
func showAlertSheet(currentVC:UIViewController,title:String,meg:String,cancel:String,operas:NSArray,cancelHandler:@escaping ((UIAlertAction) -> Void), sureHandler:@escaping ((UIAlertAction) -> Void)) {
    let alertController = UIAlertController.init(title: title, message: meg, preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction.init(title: cancel, style: .cancel) { (action) in
        cancelHandler(action)
    }
    alertController.addAction(cancelAction)
    for (_,item) in operas.enumerated() {
        let sureAction = UIAlertAction.init(title: item as? String, style: .default) { (action) in
            sureHandler(action)
        }
        alertController.addAction(sureAction)
    }
    currentVC.present(alertController, animated: true, completion: nil)
}

/// 原生底部弹框
/// - Parameter currentVC: 控制器
/// - Parameter cancel: 取消按钮
/// - Parameter operas: 操作标题
/// - Parameter cancelHandler: 取消回调
/// - Parameter sureHandler: 确定回调
func showAlertSheet(currentVC:UIViewController,cancel:String,operas:NSArray,cancelHandler:@escaping ((UIAlertAction) -> Void), sureHandler:@escaping ((UIAlertAction) -> Void)) {
    let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction.init(title: cancel, style: .cancel) { (action) in
        cancelHandler(action)
    }
    alertController.addAction(cancelAction)
    for (_,item) in operas.enumerated() {
        let sureAction = UIAlertAction.init(title: item as? String, style: .default) { (action) in
            sureHandler(action)
        }
        alertController.addAction(sureAction)
    }
    currentVC.present(alertController, animated: true, completion: nil)
}

func upC2_aci_encrypt(jsonStr:String) -> String {
    let nomalData = jsonStr.data(using: String.Encoding.utf8)
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCEncrypt), C2_Encrypt_Key.data(using: String.Encoding.utf8)!, C2_Encrypt_Iv.data(using: String.Encoding.utf8)!)
    return (aesData?.base64EncodedString())!
}

func downC2_aci_decrypt(encodStr:String) -> String {
    let nomalData = Data.init(base64Encoded: encodStr, options: [])
    if nomalData == nil {
        return ""
    }
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCDecrypt), C2_Decrypt_Key.data(using: String.Encoding.utf8)!, C2_Decrypt_Iv.data(using: String.Encoding.utf8)!)
    if aesData != nil {
        return String.init(data: aesData!, encoding: String.Encoding.utf8)!
    }
    return ""
}

func upC1_aci_encrypt(jsonStr:String) -> String {
    let nomalData = jsonStr.data(using: String.Encoding.utf8)
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCEncrypt), C1_Encrypt_Key.data(using: String.Encoding.utf8)!, C1_Encrypt_Iv.data(using: String.Encoding.utf8)!)
    return (aesData?.base64EncodedString())!
}

func downC1_aci_decrypt(encodStr:String) -> String {
    let nomalData = Data.init(base64Encoded: encodStr, options: [])
    if nomalData == nil {
        return ""
    }
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCDecrypt), C1_Decrypt_Key.data(using: String.Encoding.utf8)!, C1_Decrypt_Iv.data(using: String.Encoding.utf8)!)
    if aesData != nil {
        return String.init(data: aesData!, encoding: String.Encoding.utf8)!
    }
    return ""
}

func upGame_aci_encrypt(jsonStr:String) -> String {
    let nomalData = jsonStr.data(using: String.Encoding.utf8)
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCEncrypt), Game_Encrypt_Key.data(using: String.Encoding.utf8)!, Game_Encrypt_Iv.data(using: String.Encoding.utf8)!)
    return (aesData?.base64EncodedString())!
}

func downGame_aci_decrypt(encodStr:String) -> String {
    let nomalData = Data.init(base64Encoded: encodStr, options: [])
    if nomalData == nil {
        return ""
    }
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCDecrypt), Game_Decrypt_Key.data(using: String.Encoding.utf8)!, Game_Decrypt_Iv.data(using: String.Encoding.utf8)!)
    if aesData != nil {
        return String.init(data: aesData!, encoding: String.Encoding.utf8)!
    }
    return ""
}

func upSecret_aci_encrypt(jsonStr:String) -> String {
    let nomalData = jsonStr.data(using: String.Encoding.utf8)
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCEncrypt), secret_Encrypt_Key.data(using: String.Encoding.utf8)!, secret_Encrypt_Iv.data(using: String.Encoding.utf8)!)
    return (aesData?.base64EncodedString())!
}

func downSecret_aci_decrypt(encodStr:String) -> String {
    let nomalData = Data.init(base64Encoded: encodStr, options: [])
    if nomalData == nil {
        return ""
    }
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCDecrypt), secret_Decrypt_Key.data(using: String.Encoding.utf8)!, secret_Decrypt_Iv.data(using: String.Encoding.utf8)!)
    if aesData != nil {
        return String.init(data: aesData!, encoding: String.Encoding.utf8)!
    }
    return ""
}

func upUser_mnemonic_encrypt(wordStr:String,keyStr:String) -> String {
    let mdKey = md5(ketStr: keyStr)
    let nomalData = wordStr.data(using: String.Encoding.utf8)
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCEncrypt), mdKey.data(using: String.Encoding.utf8)!, secret_Encrypt_Iv.data(using: String.Encoding.utf8)!)
    return (aesData?.base64EncodedString())!
}

func downUser_mnemonic_decrypt(wordStr:String,keyStr:String) -> String {
    let mdKey = md5(ketStr: keyStr)
    let nomalData = Data.init(base64Encoded: wordStr, options: [])
    if nomalData == nil {
        return ""
    }
    let aesData = try? nomalData!.dataCryptAES128(CCOptions(kCCOptionPKCS7Padding), CCOperation(kCCDecrypt), mdKey.data(using: String.Encoding.utf8)!, secret_Encrypt_Iv.data(using: String.Encoding.utf8)!)
    if aesData != nil {
        return String.init(data: aesData!, encoding: String.Encoding.utf8)!
    }
    return ""
}

func md5(ketStr:String) -> String {
    let str = ketStr.cString(using: .utf8)
    let strLen = CUnsignedInt(ketStr.lengthOfBytes(using: .utf8))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
    CC_MD5(str, strLen, result)
    let hash = NSMutableString()
    for i in 0 ..< digestLen {
        hash.appendFormat("%02x", result[i])
    }
    result.deallocate()
    return String(format: hash as String)
}





