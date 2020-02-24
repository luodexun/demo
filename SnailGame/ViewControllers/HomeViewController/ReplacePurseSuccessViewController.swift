//
//  ReplacePurseSuccessViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ReplacePurseSuccessViewController: BaseViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "设置钱包", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        setUpViews()
    }
    
    @objc func doneAction(sender:UIButton) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUpViews() {
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44-10*PROSIZE))
        barView.backgroundColor = UIColor.white
        self.view.addSubview(barView)
        
        let icon = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-40*PROSIZE)/2, y: 40*PROSIZE, width: 40*PROSIZE, height: 40*PROSIZE))
        icon.image = UIImage.init(named: "ic_trade_success")
        barView.addSubview(icon)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: icon.frame.origin.y+icon.frame.size.height+25*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 24*PROSIZE))
        titleNameLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        titleNameLbl.textColor = colorWithHex(hex: 0xFF0F59)
        titleNameLbl.text = "钱包创建成功"
        titleNameLbl.textAlignment = .center
        barView.addSubview(titleNameLbl)
        
        let doneBtn = UIButton.init(type: .roundedRect)
        doneBtn.frame = CGRect.init(x: 20*PROSIZE, y: titleNameLbl.frame.origin.y+titleNameLbl.frame.size.height+55*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 46*PROSIZE)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.setTitleColor(UIColor.white, for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        doneBtn.backgroundColor = colorWithHex(hex: 0x0077FF)
        doneBtn.layer.cornerRadius = 5
        doneBtn.layer.masksToBounds = true
        doneBtn.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        barView.addSubview(doneBtn)
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
