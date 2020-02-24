//
//  LuckyDropViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class LuckyDropViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var luckyScrollView : LuckyDropScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorWithHex(hex: 0xFFAF39)
        setUpViews()
        initNaviView(bgColor: UIColor.clear)
        initNaviBackBtn(imageStr: "ic_back_info")
        getAirDrop()
    }
    
    func setUpViews() {
        let barImageView = UIImageView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT, width: SCREEN_WIDE, height: 395*PROSIZE))
        barImageView.image = UIImage.init(named: "ic_lucky_drop_bar")
        self.view.addSubview(barImageView)
        luckyScrollView = LuckyDropScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT))
        self.view.addSubview(luckyScrollView!)
        luckyScrollView?.getLuckyBtn?.addTarget(self, action: #selector(getLuckyAction), for: .touchUpInside)
    }
    
    @objc func getLuckyAction(sender:UIButton) {
        BusinessEngine.init().airDropDraw(successResponse: { (baseModel) in
            let drawDialog = LuckyDrawDialog.init(amountStr: (self.luckyScrollView?.lessDwnLbl!.text)!)
            drawDialog.show()
            self.getAirDrop()
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getAirDrop() {
        BusinessEngine.init().airDrop(successResponse: { (baseModel) in
            let luckyModel = baseModel as! LuckyDropModel
            self.luckyScrollView?.lessDwnLbl?.text = KeepSomeDecimal(num: calculateAChuyiB(a: luckyModel.data!.num!, b: TOKEN_RATIO), decimal: 2)
            self.luckyScrollView?.totalDwnLbl?.text = "剩余可领取：" + KeepSomeDecimal(num: calculateAChuyiB(a: luckyModel.data!.surplus!, b: TOKEN_RATIO), decimal: 2) + " DWN"
            if luckyModel.data?.draw != 0 {
                self.luckyScrollView?.getLuckyBtn?.isUserInteractionEnabled = true
                self.luckyScrollView?.getLuckyBtn?.backgroundColor = colorWithHex(hex: 0xFF7700)
                self.luckyScrollView?.titleNameLbl!.text = "今日可领取(DWN)"
                self.luckyScrollView?.getLuckyBtn?.setTitle("领取今日幸运", for: .normal)
            } else {
                self.luckyScrollView?.getLuckyBtn?.isUserInteractionEnabled = false
                self.luckyScrollView?.getLuckyBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
                self.luckyScrollView?.titleNameLbl!.text = "明日预计可领(DWN)"
                self.luckyScrollView?.getLuckyBtn?.setTitle("今日已领取，幸运收到", for: .normal)
            }
            self.luckyScrollView?.getNumLbl?.text = "我已领取：" + KeepSomeDecimal(num: calculateAChuyiB(a: luckyModel.data!.total!, b: TOKEN_RATIO), decimal: 2) + " DWN"
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
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
