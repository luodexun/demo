//
//  ExchangeSuccessViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ExchangeSuccessViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "兑换", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initViews()
    }
    
    @objc func doneAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initViews() {
        
        let barView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 240*PROSIZE))
        barView.backgroundColor = UIColor.white
        self.view.addSubview(barView)
        
        let icon = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-40*PROSIZE)/2, y: 40*PROSIZE, width: 40*PROSIZE, height: 40*PROSIZE))
        icon.image = UIImage.init(named: "ic_trade_success")
        barView.addSubview(icon)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: icon.frame.origin.y+icon.frame.size.height+25*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 24*PROSIZE))
        titleNameLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        titleNameLbl.textColor = colorWithHex(hex: 0xFF0F59)
        titleNameLbl.text = "兑换成功"
        titleNameLbl.textAlignment = .center
        barView.addSubview(titleNameLbl)
        
        let doneBtn = UIButton.init(type: .roundedRect)
        doneBtn.frame = CGRect.init(x: 40*PROSIZE, y: titleNameLbl.frame.origin.y+titleNameLbl.frame.size.height+34*PROSIZE, width: SCREEN_WIDE-80*PROSIZE, height: 44*PROSIZE)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.setTitleColor(colorWithHex(hex: 0x0077FF), for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
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
