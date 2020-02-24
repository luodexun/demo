//
//  SetNumberViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol SetNumberDelegate {
    func setNumberAction(numStr:String)
}

class SetNumberViewController: BaseViewController {

    var numTxtF : UITextField?
    
    var sureBtn : UIButton?
    
    var numberDelegate : SetNumberDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "设置数量", titleColor: colorWithHex(hex: 0x333333))
        initViews()
    }
    
    func initViews() {
        let numTitleLbl = UILabel.init(frame: CGRect.init(x: 26*PROSIZE, y: STABAR_HEIGHT+44+21*PROSIZE, width: 300*PROSIZE, height: 15*PROSIZE))
        numTitleLbl.textColor = colorWithHex(hex: 0x333333)
        numTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        numTitleLbl.text = "收取数量"
        self.view.addSubview(numTitleLbl)
        
        numTxtF = UITextField.init(frame: CGRect.init(x: 26*PROSIZE, y: numTitleLbl.frame.origin.y+numTitleLbl.frame.size.height, width: SCREEN_WIDE-52*PROSIZE, height: 45*PROSIZE))
        numTxtF?.textColor = colorWithHex(hex: 0x333333)
        numTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        numTxtF?.placeholder = "请输入收取数量"
        numTxtF?.keyboardType = UIKeyboardType.decimalPad
        numTxtF?.addTarget(self, action: #selector(numberTextChange), for: UIControl.Event.editingChanged)
        self.view.addSubview(numTxtF!)
        
        let line = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: numTxtF!.frame.origin.y+numTxtF!.frame.size.height, width: SCREEN_WIDE-40*PROSIZE, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.view.addSubview(line)
        
        sureBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        sureBtn?.frame = CGRect.init(x: 20*PROSIZE, y: line.frame.origin.y+line.frame.size.height+21*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 45*PROSIZE)
        sureBtn?.setTitle("确定", for: UIControl.State.normal)
        sureBtn?.setTitleColor( UIColor.white, for: UIControl.State.normal)
        sureBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        sureBtn?.isUserInteractionEnabled = false
        sureBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        sureBtn?.layer.cornerRadius = 5;
        sureBtn?.layer.masksToBounds = true
        sureBtn?.addTarget(self, action: #selector(sureAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(sureBtn!)
        
    }
    
    @objc func numberTextChange(txtF:UITextField){
        if numTxtF!.text!.count > 0 {
            sureBtn?.isUserInteractionEnabled = true
            sureBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            sureBtn?.isUserInteractionEnabled = false
            sureBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
    }
    
    @objc func sureAction(sender:UIButton) {
        numberDelegate?.setNumberAction(numStr: numTxtF!.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
