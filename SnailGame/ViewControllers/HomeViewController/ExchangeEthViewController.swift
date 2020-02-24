//
//  ExchangeEthViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ExchangeEthViewController: BaseViewController {

    var exchangeEthSV : ExchangeEthScrollView?
    
    var ratio : String?
    
    var eth : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "兑换", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initExchangeEthViewController()
        
        let userModel = BusinessEngine.init().getLoginUserModel()
        var eth = "0"
        if userModel.currency?.count != 0 {
            eth = KeepSomeDecimal(num: calculateAChuyiB(a: (userModel.currency![0].balance)!, b: ETH_RATIO), decimal: 8)
        }
        self.eth = eth;
        exchangeEthSV!.totalNumLbl!.text = "可提数量"+eth+"ETH"
        showLoading(view: self.view)
        ethToDwn()
    }
    
    func initExchangeEthViewController() {
        exchangeEthSV = ExchangeEthScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(exchangeEthSV!)
        
        exchangeEthSV?.ethNumTxtF?.addTarget(self, action: #selector(exchangeTextChange), for: .editingChanged)
        
        exchangeEthSV?.dwnNumTxtF?.addTarget(self, action: #selector(exchangeTextChange), for: .editingChanged)
        
        exchangeEthSV?.payTxtF?.addTarget(self, action: #selector(exchangeTextChange), for: .editingChanged)
        
        exchangeEthSV?.submitBtn?.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
    }
    
    @objc func submitAction(sender:UIButton) {
        
        if calculateADayuB(a: (exchangeEthSV?.ethNumTxtF!.text)!, b: eth!)  {
            showTextToast(text: "ETH余额不足", view: self.view)
            return
        }
        showLoading(view: self.view)
        BusinessEngine.init().exchangeEth(num: calculateAChengyiB(a: (exchangeEthSV?.ethNumTxtF!.text)!, b: ETH_RATIO), payPassword: (exchangeEthSV?.payTxtF!.text)!, successResponse: { (baseModel) in
            self.getUserInfo()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let exchangeSuccessVC = ExchangeSuccessViewController.init()
            self.navigationController?.pushViewController(exchangeSuccessVC, animated: true)
            self.removeCurrentVeiw()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func removeCurrentVeiw() {
        let array = NSMutableArray.init()
        for (_,item) in self.navigationController!.viewControllers.enumerated() {
            if !(item is ExchangeEthViewController) {
                array.add(item)
            }
        }
        self.navigationController?.viewControllers = array as! [UIViewController]
    }
    
    func ethToDwn() {
        BusinessEngine.init().ethToDwn(successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let ratioModel = baseModel as! EthRatioModel
            self.ratio = ratioModel.data?.ratio
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }

    @objc func exchangeTextChange(txtF:UITextField) {
        
        if txtF == exchangeEthSV?.ethNumTxtF {
            if exchangeEthSV?.ethNumTxtF?.text?.count == 0 {
                exchangeEthSV?.dwnNumTxtF?.text = ""
            } else if isPureFloat(string: (exchangeEthSV?.ethNumTxtF!.text)!) {
                exchangeEthSV?.dwnNumTxtF?.text = calculateAChengyiB(a: (exchangeEthSV?.ethNumTxtF!.text)!, b: ratio!)
            } else {
                exchangeEthSV?.dwnNumTxtF?.text = ""
            }
        }
        
        if txtF == exchangeEthSV?.dwnNumTxtF {
            if exchangeEthSV?.dwnNumTxtF?.text?.count == 0 {
                exchangeEthSV?.ethNumTxtF?.text = ""
            } else if isPureFloat(string: (exchangeEthSV?.dwnNumTxtF!.text)!) {
                let eth = calculateAChuyiB(a: (exchangeEthSV?.dwnNumTxtF!.text)!, b: ratio!)
                exchangeEthSV?.ethNumTxtF?.text = KeepSomeDecimal(num: eth, decimal: 8)
            } else {
                exchangeEthSV?.ethNumTxtF?.text = ""
            }
        }
        
        if exchangeEthSV?.ethNumTxtF?.text?.count != 0 && exchangeEthSV?.ethNumTxtF?.text?.count != 0 && (exchangeEthSV?.payTxtF?.text!.count)! > 5 {
            exchangeEthSV?.submitBtn?.isUserInteractionEnabled = true
            exchangeEthSV?.submitBtn?.backgroundColor = colorWithHex(hex: 0xff7700)
        } else {
            exchangeEthSV?.submitBtn?.isUserInteractionEnabled = false
            exchangeEthSV?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
