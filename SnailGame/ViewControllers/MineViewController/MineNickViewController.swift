//
//  MineNickViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineNickViewController: BaseViewController {

    var nickName : String?
    
    var nickNameTxtF : UITextField?
    
    var saveBtn : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "设置昵称", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initViews()
        
        if nickName?.count != 0 {
            nickNameTxtF?.text = nickName
        }
    }
    
    func initViews() {
        
        let nickBarView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 54*PROSIZE))
        nickBarView.backgroundColor = UIColor.white
        self.view.addSubview(nickBarView)
        
        nickNameTxtF = UITextField.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: nickBarView.frame.size.width-40*PROSIZE, height: 54*PROSIZE))
        nickNameTxtF?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        nickNameTxtF?.textColor = colorWithHex(hex: 0x333333)
        nickNameTxtF?.placeholder = "请输入昵称"
        nickNameTxtF?.addTarget(self, action: #selector(nickTextChange), for: UIControl.Event.editingChanged)
        nickBarView.addSubview(nickNameTxtF!)
        
        saveBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        saveBtn?.frame = CGRect.init(x: 20*PROSIZE, y: nickBarView.frame.origin.y+nickBarView.frame.size.height+30*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 45*PROSIZE)
        saveBtn?.isUserInteractionEnabled = false
        saveBtn?.setTitle("保存", for: UIControl.State.normal)
        saveBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        saveBtn?.addTarget(self, action: #selector(saveNickAction), for: UIControl.Event.touchUpInside)
        saveBtn?.layer.cornerRadius = 5
        saveBtn?.layer.masksToBounds = true
        self.view.addSubview(saveBtn!)
        
    }
    
    @objc func saveNickAction(sender:UIButton) {
        showLoading(view: self.view)
        let param = NSMutableDictionary.init()
        param.setValue(nickNameTxtF?.text, forKey: "nickname")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
            self.getUserInfo()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            self.navigationController?.popViewController(animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func nickTextChange(txtF:UITextField){
        if  nickNameTxtF?.text?.count != 0 {
            saveBtn?.isUserInteractionEnabled = true
            saveBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            saveBtn?.isUserInteractionEnabled = false
            saveBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        }
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
