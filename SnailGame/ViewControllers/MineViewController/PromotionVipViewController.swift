//
//  PromotionVipViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class PromotionVipViewController: BaseViewController {

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
    
    var promotionVipCV : PromotionVipCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x0077FF))
        initNaviBackBtn(imageStr: "ic_back_white")
        initNaviTitle(titleStr: "蜗牛VIP", titleColor: UIColor.white)
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initPromotionVipCollectionView()
        promotionVipCV?.userModel = BusinessEngine.init().getLoginUserModel()
        getVipInfo()
    }
    
    func initPromotionVipCollectionView() {
        let barView = UIView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 140*PROSIZE))
        barView.backgroundColor = colorWithHex(hex: 0x0077FF)
        self.view.addSubview(barView)
        
        let layout = UICollectionViewFlowLayout.init()
        promotionVipCV = PromotionVipCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44), collectionViewLayout: layout)
        self.view.addSubview(promotionVipCV!)
        
        promotionVipCV!.promotionVipPushHandel = {(opera) in
            if opera == 1 {
                let openVipVC = OpenVipViewController.init()
                openVipVC.infoModel = self.promotionVipCV?.infoModel
                self.navigationController?.pushViewController(openVipVC, animated: true)
            } else {
                let rightDetailVC = RightDetailViewController.init()
                rightDetailVC.pushType = 1
                self.navigationController?.pushViewController(rightDetailVC, animated: true)
            }
        }
        
        promotionVipCV!.promotionVipRightHandel = {(detailModel) in
            let rightDialog : VipRightDialog = VipRightDialog.init(detailModel: detailModel)
            rightDialog.show()
        }
        
        promotionVipCV!.promotionRightDetailHandel = {(opera) in
            let rightDetailVC = RightDetailViewController.init()
            rightDetailVC.pushType = 2
            self.navigationController?.pushViewController(rightDetailVC, animated: true)
        }
    }
    
    func getVipInfo() {
        BusinessEngine.init().getVipInfo(successResponse: { (BaseModel) in
            let vipModel:VipInfoModel = BaseModel as! VipInfoModel
            self.promotionVipCV!.infoModel = vipModel.data
            self.promotionVipCV?.reloadData()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
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
