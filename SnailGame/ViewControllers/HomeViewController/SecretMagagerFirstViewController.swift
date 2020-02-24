//
//  SecretMagagerFirstViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SecretMagagerFirstViewController: BaseViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviTitle(titleStr: "助记词管理", titleColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_white")
        setUpViews()
    }
    
    @objc func saveAction(sender:UIButton) {
        let magagerSecondVC = SecretMagagerSecondViewController.init()
        self.navigationController?.pushViewController(magagerSecondVC, animated: true)
    }
    
    func setUpViews() {
        let noneIcon = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-181*PROSIZE)/2, y: STABAR_HEIGHT+44+81*PROSIZE, width: 181*PROSIZE, height: 134*PROSIZE))
        noneIcon.image = UIImage.init(named: "ic_secret_manager_none")
        self.view.addSubview(noneIcon)
        
        let secretTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: noneIcon.frame.origin.y+noneIcon.frame.size.height+31*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 24*PROSIZE))
        secretTitleLbl.font = UIFont.boldSystemFont(ofSize: 17*PROSIZE)
        secretTitleLbl.textColor = colorWithHex(hex: 0x333333)
        secretTitleLbl.text = "您未保存助记词在本地"
        secretTitleLbl.textAlignment = .center
        self.view.addSubview(secretTitleLbl)
        
        let secretdescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: secretTitleLbl.frame.origin.y+secretTitleLbl.frame.size.height+5*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 24*PROSIZE))
        secretdescLbl.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        secretdescLbl.textColor = colorWithHex(hex: 0x333333)
        secretdescLbl.text = "请保存您的助记词"
        secretdescLbl.textAlignment = .center
        self.view.addSubview(secretdescLbl)
        
        let saveBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        saveBtn.frame = CGRect.init(x: 20*PROSIZE, y: secretdescLbl.frame.origin.y+secretdescLbl.frame.size.height+80*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 45*PROSIZE)
        saveBtn.setTitle("保存助记词", for: UIControl.State.normal)
        saveBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        saveBtn.backgroundColor = colorWithHex(hex: 0x333333)
        saveBtn.layer.cornerRadius = 5
        saveBtn.layer.masksToBounds = true
        self.view.addSubview(saveBtn)
    
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
