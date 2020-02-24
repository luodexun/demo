//
//  CommunityWealthViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/25.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class CommunityWealthViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var communityDetailView : CommunityDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "社区", titleColor: colorWithHex(hex: 0x333333))
        initRightButton(title: "变动记录", titleColor: colorWithHex(hex: 0x333333))
        initCommunityDetailView()
        getImageBanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userModel = BusinessEngine.init().getLoginUserModel()
        let communityDwn = calculateAChuyiB(a: userModel.token!, b: TOKEN_RATIO)
        let freezeDwn = calculateAChuyiB(a: userModel.freeze!, b: TOKEN_RATIO)
        communityDetailView?.currentDwnLbl?.text = KeepSomeDecimal(num: communityDwn, decimal: 2)
        communityDetailView?.releaseDwnLbl?.text = KeepSomeDecimal(num: freezeDwn, decimal: 2)
    }
    
    func initCommunityDetailView() {
        communityDetailView = CommunityDetailView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(communityDetailView!)
        
        communityDetailView?.toCommunityBtn?.addTarget(self, action: #selector(toCommunityAction), for: UIControl.Event.touchUpInside)
        
        communityDetailView?.toWalletBtn?.addTarget(self, action: #selector(toWalletAction), for: .touchUpInside)
    }
    
    func getImageBanner() {
        BusinessEngine.init().appBanner(key: "", value: "", pageNum: "1", type: "3", successResponse: { (BaseModel) in
            let bannerModel : BannerModel = BaseModel as! BannerModel
            if bannerModel.data?.count != 0 {
                let dataModel:BannerDataModel = bannerModel.data!.first!
                self.communityDetailView?.bannerImageView?.dwn_setImageView(urlStr: dataModel.cover!, imageName: "")
            }
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func rightImageAction(sender: UIButton) {
        let changeRecordVC = ChangeRecordViewController.init()
        self.navigationController?.pushViewController(changeRecordVC, animated: true)
    }
    
    @objc func toCommunityAction(sender:UIButton) {
        let depositCommunityVC = DepositCommunityViewController.init()
        self.navigationController?.pushViewController(depositCommunityVC, animated: true)
    }
    
    @objc func toWalletAction(sender:UIButton) {
        let drawWalletVC = DrawWalletViewController.init()
        self.navigationController?.pushViewController(drawWalletVC, animated: true)
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
