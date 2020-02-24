//
//  RegionChooseViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegionChooseViewController: BaseViewController {

    var regionChooseView : RegionChooseView?
    
    var regionCode = "86"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "注册", titleColor: colorWithHex(hex: 0x333333))
        initRegionChooseView()
    }
    
    func initRegionChooseView() {
        regionChooseView = RegionChooseView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-SAFE_BOTTOM-44))
        self.view.addSubview(regionChooseView!)
        
        regionChooseView?.chooseRegionBtn?.addTarget(self, action: #selector(regionChooseAction), for: UIControl.Event.touchUpInside)
        
        regionChooseView?.nextBtn?.addTarget(self, action: #selector(nextStepAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func regionChooseAction(sender:UIButton) {
        let regionView : RegionSelectView = RegionSelectView.init()
        regionView.show()
        regionView.regionSelectHandel = {(name,code) in
            self.regionChooseView?.regionNameLbl?.text = name
            self.regionCode = code
        }
    }
    
    @objc func nextStepAction(sender:UIButton) {
        let registerVC = RegisterPhoneViewController.init()
        registerVC.regionCode = regionCode
        self.navigationController?.pushViewController(registerVC, animated: true)
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
