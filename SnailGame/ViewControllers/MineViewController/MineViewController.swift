//
//  MineViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    var mineCV : MineCollectionView?

    var userModel : UserLoginDataModel?
    
    var codeType , certifyType , noticeType : Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let mainVC:BaseTabBarController = self.tabBarController as! BaseTabBarController
        mainVC.showTabBarBudge()
        changeUserValues()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMineCollectionView()
        
        if UserDefaults.standard.object(forKey: PASS) != nil {
            mineCV?.isService = UserDefaults.standard.object(forKey: PASS) as! Int
        }
        
        mineCV?.mineList = MineShowObject.init().getMineList(isService: mineCV!.isService) as! NSMutableArray
        
        codeType = MineShowObject.init().getCurrentIndex(arrList: mineCV!.mineList, operaType: 1)
        
        certifyType = MineShowObject.init().getCurrentIndex(arrList: mineCV!.mineList, operaType: 7)
        
        noticeType = MineShowObject.init().getCurrentIndex(arrList: mineCV!.mineList, operaType: 8)
        
        mineCV?.reloadData()
        
    }
    
    func initMineCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        mineCV = MineCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: SCREEN_HEIGHT-50-SAFE_BOTTOM), collectionViewLayout: layout)
        self.view.addSubview(mineCV!)
        
        mineCV!.mineHeadPushHandel = {(opera) in
            if judgeLoginAndPush() {
                if opera == 1 {
                    if self.mineCV?.isService == 1 {
                        let trinketWallVC = TrinketWallViewController.init()
                        self.navigationController?.pushViewController(trinketWallVC, animated: true)
                    } else {
                        let mineDataVC = MineDataViewController.init()
                        self.navigationController?.pushViewController(mineDataVC, animated: true)
                    }
                } else {
                    if self.userModel?.vip == 0 {
                        let promotionVipVC = PromotionVipViewController.init()
                        self.navigationController?.pushViewController(promotionVipVC, animated: true)
                    } else {
                        let vipDetailVC = VipDetailViewController.init()
                        self.navigationController?.pushViewController(vipDetailVC, animated: true)
                    }   
                }
            }
        }
        
        mineCV?.minePushHandel = {(showModel) in
    
            switch showModel.operaType {
            case 1:
                if judgeLoginAndPush() {
                    let promotionVC = PromotionViewController.init()
                    self.navigationController?.pushViewController(promotionVC, animated: true)
                }
                break
            case 2:
                if judgeLoginAndPush() {
                    let taskRewardVC = TaskRewardViewController.init()
                    self.navigationController?.pushViewController(taskRewardVC, animated: true)
                }
                break
            case 3:
                if judgeLoginAndPush() {
                    let wealthVC = WealthViewController.init()
                    self.navigationController?.pushViewController(wealthVC, animated: true)
                }
                break
            case 4:
                if judgeLoginAndPush() {
                    let walletDetailVC = WalletDetailViewController.init()
                    self.navigationController?.pushViewController(walletDetailVC, animated: true)
                }
                break
            case 5:
                if judgeLoginAndPush() {
                    let mineCandyVC = MineCandyViewController.init()
                    self.navigationController?.pushViewController(mineCandyVC, animated: true)
                }
                break
            case 6:
                if judgeLoginAndPush() {
                    let securitySetVC = SecuritySetViewController.init()
                    self.navigationController?.pushViewController(securitySetVC, animated: true)
                }
                break
            case 7:
                if judgeLoginAndPush() {
                    if self.userModel?.is_certified == 1 || self.userModel?.is_certified == 2 {
                        let successVC = AuthentySuccessViewController.init()
                        self.navigationController?.pushViewController(successVC, animated: true)
                    } else {
                        let realNameVC = RealNameViewController.init()
                        self.navigationController?.pushViewController(realNameVC, animated: true)
                    }
                }
                break
            case 8:
                if judgeLoginAndPush() {
                    let noticeListVC = NoticeListViewController.init()
                    self.navigationController?.pushViewController(noticeListVC, animated: true)
                }
                break
            case 9:
                if judgeLoginAndPush() {
                    let customerServiceVC = CustomerServiceViewController.init()
                    self.navigationController?.pushViewController(customerServiceVC, animated: true)
                }
                break
            case 10:
                let setVC = SetViewController.init()
                self.navigationController!.pushViewController(setVC, animated: true)
                break
            default:
                
                break
        
            }
        }
        
    }
    
    func changeUserValues() {
        if isLogin() {
            userModel = BusinessEngine.init().getLoginUserModel()
            mineCV?.userModel = userModel
            let showModel1 :MineShowModel = mineCV?.mineList[codeType!] as! MineShowModel
            showModel1.contentStr = userModel?.code
            let showModel2 :MineShowModel = mineCV?.mineList[certifyType!] as! MineShowModel
            if userModel?.is_certified == 0 {
                showModel2.contentStr = "未认证"
            } else if userModel?.is_certified == 1 {
                showModel2.contentStr = "已认证"
            } else if userModel?.is_certified == 2 {
                showModel2.contentStr = "认证中"
            } else {
                showModel2.contentStr = "认证失败"
            }
            let showModel3 :MineShowModel = mineCV?.mineList[noticeType!] as! MineShowModel
            if userModel!.notice_num! > 99 {
                showModel3.contentStr = "99+"
            } else if userModel!.notice_num! > 0 {
                showModel3.contentStr = String(userModel!.notice_num!)
            } else {
                showModel3.contentStr = ""
            }
        } else {
            mineCV?.userModel = UserLoginDataModel.init()
            let showModel1 :MineShowModel = mineCV?.mineList[codeType!] as! MineShowModel
            showModel1.contentStr = ""
            let showModel2 :MineShowModel = mineCV?.mineList[certifyType!] as! MineShowModel
            showModel2.contentStr = ""
            let showModel3 :MineShowModel = mineCV?.mineList[noticeType!] as! MineShowModel
            showModel3.contentStr = ""
        }
        mineCV?.reloadData()
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
