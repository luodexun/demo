//
//  TaskRewardViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TaskRewardViewController: BaseViewController {

    var taskHeadView : TaskRewardHeadView?
    
    var taskRewardCV : TaskRewardCollectionView?
    
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
        initNaviTitle(titleStr: "任务奖励", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xFF4342)
        initViews()
        showLoading(view: self.view)
        getQuestRewards()
    }
    
    func initViews() {
        taskHeadView = TaskRewardHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 100*PROSIZE))
        self.view.addSubview(taskHeadView!)
        let layout = UICollectionViewFlowLayout.init()
        taskRewardCV = TaskRewardCollectionView.init(frame: CGRect.init(x: 0, y: taskHeadView!.frame.origin.y+taskHeadView!.frame.size.height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-taskHeadView!.frame.origin.y-taskHeadView!.frame.size.height), collectionViewLayout: layout)
        self.view.addSubview(taskRewardCV!)
        
        taskRewardCV!.taskRewardHandel = {(listModel) in
            if listModel.draw == 2 {
                self.choosePush(listModel: listModel)
            } else if listModel.draw == 0 {
                self.drawReward(questId: String(listModel.id!))
            }
        }
    }
    
    func getQuestRewards() {
        BusinessEngine.init().getQuestRewards(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let taskModel : QuestRewardsModel = BaseModel as! QuestRewardsModel
            let dateList = NSMutableArray.init()
            let singleList = NSMutableArray.init()
            for (_,item) in (taskModel.data?.enumerated())! {
                if item.repetition != 0 {
                    dateList.add(item)
                } else {
                    singleList.add(item)
                }
            }
            self.taskRewardCV?.dateList = dateList
            self.taskRewardCV?.singleList = singleList
            self.taskRewardCV?.reloadData()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func drawReward(questId:String) {
        showLoading(view: self.view)
        BusinessEngine.init().drawReward(taskId: questId, successResponse: { (BaseModel) in
            self.getQuestRewards()
            self.getUserInfo()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: "领取成功", view: self.view)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func choosePush(listModel : QuestRewardsListModel) {
        switch listModel.target {
        case 0:
            break
        case 1:
            let authentyVC = IdentityAuthentyViewController.init()
            self.navigationController?.pushViewController(authentyVC, animated: true)
            break
        case 2:
            let drawWalletVC = DrawWalletViewController.init()
            self.navigationController?.pushViewController(drawWalletVC, animated: true)
            break
        case 3:
            let promotionShareVC = PromotionShareViewController.init()
            promotionShareVC.modalPresentationStyle = .fullScreen
            self.present(promotionShareVC, animated: true, completion: nil)
            break
        case 4:
            let promotionShareVC = PromotionShareViewController.init()
            promotionShareVC.modalPresentationStyle = .fullScreen
            self.present(promotionShareVC, animated: true, completion: nil)
            break
        case 5:
            self.tabBarController?.selectedIndex = 1
            self.navigationController?.popToRootViewController(animated: true)
            break
        case 6:
            self.tabBarController?.selectedIndex = 3
            self.navigationController?.popToRootViewController(animated: true)
            break
        default:
            break
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
