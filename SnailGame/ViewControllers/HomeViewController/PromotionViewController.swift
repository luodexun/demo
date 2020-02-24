//
//  PromotionViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "推广奖励", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "推广记录", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0x8B49B1)
        initViews()
    }
    
    func initViews() {
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 450*PROSIZE))
        bg.image = UIImage.init(named: "ic_recommend_bg")
        self.view.addSubview(bg)
        
        let barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: SCREEN_HEIGHT-265*PROSIZE-SAFE_BOTTOM, width: SCREEN_WIDE-40*PROSIZE, height: 245*PROSIZE))
        barView.backgroundColor = UIColor.init(white: 255/255.0, alpha: 0.7)
        barView.layer.cornerRadius = 10
        barView.layer.masksToBounds = true
        self.view.addSubview(barView)
        
        let promotionBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        promotionBtn.frame = CGRect.init(x: 20*PROSIZE, y: 20*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 50*PROSIZE)
        promotionBtn.setTitle("马上邀请", for: UIControl.State.normal)
        promotionBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        promotionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24*PROSIZE)
        promotionBtn.backgroundColor = colorWithHex(hex: 0x0077FF)
        promotionBtn.layer.cornerRadius = 5
        promotionBtn.layer.masksToBounds = true
        promotionBtn.addTarget(self, action: #selector(promotionAction), for: UIControl.Event.touchUpInside)
        barView.addSubview(promotionBtn)
        
        let ruleTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 101*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 14*PROSIZE))
        ruleTitleLbl.text = "规则说明"
        ruleTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        ruleTitleLbl.textColor = colorWithHex(hex: 0x333333)
        barView.addSubview(ruleTitleLbl)
        
        let ruleNoteLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: ruleTitleLbl.frame.origin.y+ruleTitleLbl.frame.size.height+3*PROSIZE, width: barView.frame.size.width-40*PROSIZE, height: 100*PROSIZE))
        ruleNoteLbl.text = "1. 邀请用户有三级收益；\n2. 一级每用户奖励3DWN，二级1DWN，三级1DWN；\n3. 被邀请用户必须通过实名认证才算邀请成功；\n4. 大蜗牛社区平台随时有权停止或修改此规则。\n大蜗牛社区对以上规则有最终解释权"
        ruleNoteLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        ruleNoteLbl.textColor = colorWithHex(hex: 0x333333)
        ruleNoteLbl.numberOfLines = 0
        barView.addSubview(ruleNoteLbl)
        
    }
    
    @objc func promotionAction(sender:UIButton) {
        let promotionShareVC = PromotionShareViewController.init()
        promotionShareVC.modalPresentationStyle = .fullScreen
        self.present(promotionShareVC, animated: true, completion: nil)
    }
    
    override func rightImageAction(sender: UIButton) {
        let promotionRecordVC = PromotionRecordViewController.init()
        self.navigationController?.pushViewController(promotionRecordVC, animated: true)
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
