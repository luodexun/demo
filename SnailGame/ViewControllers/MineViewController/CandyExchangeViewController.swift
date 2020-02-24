//
//  CandyExchangeViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/4.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CandyExchangeViewController: BaseViewController {

    var invalidView : CandyExchangeInvalidView?
    
    var exchangeView : CandyExchangeView?
    
    var mineCandy = 0
    
    var totalValus = 0
    
    var ratio = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "兑换", titleColor: colorWithHex(hex: 0x333333))
        initViews()
        showLoading(view: self.view)
        mineCandy = Int(BusinessEngine.init().getLoginUserModel().candy!)!
        invalidView?.amountNumLbl?.text = String(mineCandy)
        exchangeView?.amountNumLbl?.text = String(mineCandy)
        exchangeView?.dwnNumLbl?.text = "0"
        candyExchangeInfo()
    }
    
    func initViews() {
        
        invalidView = CandyExchangeInvalidView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        invalidView?.isHidden = true
        self.view.addSubview(invalidView!)
        
        exchangeView = CandyExchangeView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        exchangeView?.isHidden = true
        self.view.addSubview(exchangeView!)
        
        exchangeView?.numSlider?.addTarget(self, action: #selector(sliderValueDidChanged), for: .valueChanged)
        
        exchangeView?.exchangeNumTxtF?.addTarget(self, action: #selector(exchangeTextChange), for: UIControl.Event.editingChanged)
        
        exchangeView?.submitBtn?.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        
    }
    
    @objc func submitAction(sender:UIButton) {
        showLoading(view: self.view)
        BusinessEngine.init().candyExchange(candyNum: exchangeView!.exchangeNumTxtF!.text!, successResponse: { (baseModel) in
            self.getUserInfo()
            self.view.hideToastActivity()
            let exchangeSuccessVC = ExchangeSuccessViewController.init()
            self.navigationController?.pushViewController(exchangeSuccessVC, animated: true)
            self.removeCurrentVeiw()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
        }) { (BaseModel) in
        }
    }
    
    func removeCurrentVeiw() {
        let array = NSMutableArray.init()
        for (_,item) in self.navigationController!.viewControllers.enumerated() {
            if !(item is CandyExchangeViewController) {
                array.add(item)
            }
        }
        self.navigationController?.viewControllers = array as! [UIViewController]
    }
    
    @objc func sliderValueDidChanged(sender:UISlider) {
        if sender.value != 0 {
            exchangeView?.exchangeNumTxtF?.text = String(Int(sender.value))
            exchangeView?.dwnNumLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: calculateAChengyiB(a: (exchangeView?.exchangeNumTxtF?.text!)!, b: ratio), b: TOKEN_RATIO), decimal: 2)
            exchangeView?.submitBtn?.isUserInteractionEnabled = true
            exchangeView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xFF6000)
        } else {
            exchangeView?.exchangeNumTxtF?.text = ""
            exchangeView?.dwnNumLbl?.text = "0"
            exchangeView?.submitBtn?.isUserInteractionEnabled = false
            exchangeView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    @objc func exchangeTextChange(txtF:UITextField) {
        if exchangeView?.exchangeNumTxtF?.text?.count != 0 {
            if isPureInt(string: txtF.text!)  {
                if Int(txtF.text!)! > 0 {
                    if Int(txtF.text!)! > totalValus {
                        txtF.text = String(totalValus)
                    }
                    exchangeView?.dwnNumLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: calculateAChengyiB(a: (exchangeView?.exchangeNumTxtF?.text!)!, b: ratio), b: TOKEN_RATIO), decimal: 2)
                    exchangeView?.numSlider?.value = Float(txtF.text!)!
                    exchangeView?.submitBtn?.isUserInteractionEnabled = true
                    exchangeView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xFF6000)
                } else {
                    exchangeView?.numSlider?.value = 0
                    exchangeView?.dwnNumLbl?.text = "0"
                    exchangeView?.submitBtn?.isUserInteractionEnabled = false
                    exchangeView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
                }
            } else {
                exchangeView?.numSlider?.value = 0
                exchangeView?.dwnNumLbl?.text = "0"
                exchangeView?.submitBtn?.isUserInteractionEnabled = false
                exchangeView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
            }
        }else {
            exchangeView?.numSlider?.value = 0
            exchangeView?.dwnNumLbl?.text = "0"
            exchangeView?.submitBtn?.isUserInteractionEnabled = false
            exchangeView?.submitBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    func candyExchangeInfo() {
        BusinessEngine.init().CandyChangeInfo(successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let exchangeModel = baseModel as! CandyExchangeModel
            self.ratio = exchangeModel.data!.change_ratio!
            if exchangeModel.data!.limit_candy_day_sum! - exchangeModel.data!.sum! > 0 {
                self.exchangeView?.isHidden = false
                self.invalidView?.isHidden = true
                self.exchangeView?.remainNumLbl?.text = String(exchangeModel.data!.limit_candy_day_total! - exchangeModel.data!.total!)
                let totalStr = "本次兑换糖果总数" +   String(exchangeModel.data!.limit_candy_day_total! / 10000) + "万"
                let totalSize = NSString.calStrSize(textStr: totalStr as NSString, height: 33*PROSIZE, fontSize: 12*PROSIZE)
                self.exchangeView!.totalBarView?.frame.origin.x = (SCREEN_WIDE-totalSize.width-30*PROSIZE)/2
                self.exchangeView!.totalBarView?.frame.size.width = totalSize.width+30*PROSIZE
                self.exchangeView!.totalNumLbl?.frame.origin.x = (SCREEN_WIDE-totalSize.width-30*PROSIZE)/2
                self.exchangeView!.totalNumLbl?.frame.size.width = totalSize.width+30*PROSIZE
                self.exchangeView?.totalNumLbl?.text = totalStr
                if exchangeModel.data!.limit_candy_day_sum! - exchangeModel.data!.sum! > self.mineCandy {
                    self.totalValus = self.mineCandy
                } else {
                    self.totalValus = exchangeModel.data!.limit_candy_day_sum! - exchangeModel.data!.sum!
                }
                self.exchangeView?.numSlider?.maximumValue = Float(self.totalValus)
            } else {
                self.exchangeView?.isHidden = true
                self.invalidView?.isHidden = false
                self.invalidView?.timeBarView?.isHidden = true
                self.invalidView?.useBarView?.isHidden = false
            }
        }) { (baseModel) in
            self.view.hideToastActivity()
            if baseModel.code == 1001 {
                self.exchangeView?.isHidden = true
                self.invalidView?.isHidden = false
                self.invalidView?.timeBarView?.isHidden = false
                self.invalidView?.useBarView?.isHidden = true
            } else {
                showTextToast(text: baseModel.message!, view: self.view)
            }
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
