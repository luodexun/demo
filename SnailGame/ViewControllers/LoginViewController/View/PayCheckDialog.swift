//
//  PayCheckDialog.swift
//  SnailGame
//
//  Created by Edison on 2019/12/10.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias PayCheckSuccessBlock = (_ payStr:String) -> Void

class PayCheckDialog: UIView {

    var coverView , whiteView : UIView?
    var payErrorLbl : UILabel?
    var payTxtF : UITextField?
    var submitBtn : UIButton?
    var whiteViewStartFrame: CGRect = CGRect.init(x: SCREEN_WIDE/2 - 10*PROSIZE, y: SCREEN_HEIGHT/2 - 10*PROSIZE, width: 20*PROSIZE, height: 20*PROSIZE)
    var whiteViewEndFrame: CGRect = CGRect.init(x: 30*PROSIZE, y: (SCREEN_HEIGHT - 275*PROSIZE)/2, width: SCREEN_WIDE - 60*PROSIZE, height: 275*PROSIZE)
    var payCheckSuccessHandel : PayCheckSuccessBlock?

    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    func setupView() {
        coverView = UIView.init(frame: self.bounds)
        coverView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        addSubview(coverView!)
        
        whiteView = UIView.init(frame: whiteViewStartFrame)
        whiteView?.backgroundColor = UIColor.white
        whiteView?.layer.masksToBounds = true
        whiteView?.layer.cornerRadius = 5
        self.addSubview(whiteView!)
        
    }
    
    func setUpSubViews() {
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: 35*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: 17*PROSIZE))
        titleNameLbl.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        titleNameLbl.text = "请输入“支付密码”进行验证。"
        whiteView?.addSubview(titleNameLbl)
        
        let payTitleLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: 81*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: 14*PROSIZE))
        payTitleLbl.textColor = colorWithHex(hex: 0x999999)
        payTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        payTitleLbl.text = "支付密码"
        whiteView?.addSubview(payTitleLbl)
        
        payTxtF = UITextField.init(frame: CGRect.init(x: 30*PROSIZE, y: payTitleLbl.frame.origin.y+payTitleLbl.frame.size.height+10*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: 45*PROSIZE))
        payTxtF?.textColor = colorWithHex(hex: 0x333333)
        payTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        payTxtF?.isSecureTextEntry = true
        payTxtF?.placeholder = "请输入支付密码"
        payTxtF?.addTarget(self, action: #selector(payTextChange), for: UIControl.Event.editingChanged)
        whiteView?.addSubview(payTxtF!)
        
        let fstLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: payTxtF!.frame.origin.y+payTxtF!.frame.size.height, width: (whiteView?.frame.size.width)!-40*PROSIZE, height: 1*PROSIZE))
        fstLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        whiteView?.addSubview(fstLine)
        
        payErrorLbl = UILabel.init(frame: CGRect.init(x: 30*PROSIZE, y: fstLine.frame.origin.y+fstLine.frame.size.height+16*PROSIZE, width: (whiteView?.frame.size.width)!-60*PROSIZE, height: 14*PROSIZE))
        payErrorLbl?.text = "支付密码错误"
        payErrorLbl?.isHidden = true
        payErrorLbl?.textColor = colorWithHex(hex: 0xFF0044)
        payErrorLbl?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        whiteView?.addSubview(payErrorLbl!)
        
        let secLine = UIView.init(frame: CGRect.init(x: 0, y: fstLine.frame.origin.y+fstLine.frame.size.height+70*PROSIZE, width: (whiteView?.frame.size.width)!, height: 1*PROSIZE))
        secLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        whiteView?.addSubview(secLine)
        
        let cancelBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        cancelBtn.frame = CGRect.init(x: 0, y: (whiteView?.frame.size.height)!-54*PROSIZE, width: (whiteView?.frame.size.width)!/2, height: 54*PROSIZE)
        cancelBtn.setTitle("取消", for: UIControl.State.normal)
        cancelBtn.setTitleColor(colorWithHex(hex: 0x999999), for: UIControl.State.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
        whiteView?.addSubview(cancelBtn)
        
        submitBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        submitBtn?.frame = CGRect.init(x: (whiteView?.frame.size.width)!/2, y: (whiteView?.frame.size.height)!-54*PROSIZE, width: (whiteView?.frame.size.width)!/2, height: 54*PROSIZE)
        submitBtn?.setTitle("提交", for: UIControl.State.normal)
        submitBtn?.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        submitBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        submitBtn?.addTarget(self, action: #selector(submitAction), for: UIControl.Event.touchUpInside)
        whiteView?.addSubview(submitBtn!)
        
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteView?.frame = self.whiteViewEndFrame
        }) { (_) in
            self.setUpSubViews()
        }
    }
    
    func close() {
        for view in whiteView!.subviews {
            view.removeFromSuperview()
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.whiteView?.frame = self.whiteViewStartFrame
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelAction(sender:UIButton) {
        close()
    }
    
    @objc func submitAction(sender:UIButton) {
        if payTxtF?.text?.count == 0 {
            showTextToast(text: "请输入支付密码", view: self)
            return
        }
        submitBtn?.isUserInteractionEnabled = false
        BusinessEngine.init().payVerify(code: payTxtF!.text!, successResponse: { (baseModel) in
            self.payCheckSuccessHandel!(self.payTxtF!.text!)
            self.close()
        }) { (baseModel) in
            self.submitBtn?.isUserInteractionEnabled = true
            self.payErrorLbl?.isHidden = false
        }
    }
    
    @objc func payTextChange(txtF:UITextField){
        if payErrorLbl?.isHidden == false {
            payErrorLbl?.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
