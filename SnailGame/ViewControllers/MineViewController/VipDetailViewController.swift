//
//  VipDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class VipDetailViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var vipDetailCV : VipDetailCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x0077FF))
        initNaviBackBtn(imageStr: "ic_back_white")
        initNaviTitle(titleStr: "蜗牛VIP", titleColor: UIColor.white)
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initVipDetailCollectionView()
        showLoading(view: self.view)
        getVipDetail()
    }
    
    func initVipDetailCollectionView() {
        let barView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 140*PROSIZE))
        barView.backgroundColor = colorWithHex(hex: 0x0077FF)
        self.view.addSubview(barView)
        
        let layout = UICollectionViewFlowLayout.init()
        vipDetailCV = VipDetailCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44), collectionViewLayout: layout)
        self.view.addSubview(vipDetailCV!)
        vipDetailCV!.vipDetailRightHandel = {(detailModel) in
            let rightDialog : VipRightDialog = VipRightDialog.init(detailModel: detailModel)
            rightDialog.show()
        }
        
        vipDetailCV!.vipRightDetailHandel = {
            let rightDetailVC = RightDetailViewController.init()
            rightDetailVC.pushType = 1
            self.navigationController?.pushViewController(rightDetailVC, animated: true)
        }
        
        vipDetailCV!.vipRightRenewalHandel = {
            let openVipVC = OpenVipViewController.init()
            openVipVC.infoModel = self.vipDetailCV?.infoModel
            self.navigationController?.pushViewController(openVipVC, animated: true)
        }
        
        vipDetailCV!.vipRightRuleHandel = {
            let rightDetailVC = RightDetailViewController.init()
            rightDetailVC.pushType = 2
            self.navigationController?.pushViewController(rightDetailVC, animated: true)
        }
    }
    
    func getVipDetail() {
        BusinessEngine.init().getVipInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let vipModel:VipInfoModel = BaseModel as! VipInfoModel
            self.vipDetailCV?.infoModel = vipModel.data
            self.vipDetailCV?.userModel = BusinessEngine.init().getLoginUserModel()
            self.vipDetailCV?.reloadData()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
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
