//
//  TrinketWallViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TrinketWallViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var wallHeadView : TrinketWallHeadView?
    
    var trinketWallCV : TrinketWallCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "徽章墙", titleColor: colorWithHex(hex: 0x333333))
        initTrinketWallHeadView()
        trinketWallList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userModel = BusinessEngine.init().getLoginUserModel()
        wallHeadView?.userImageView?.dwn_setImageView(urlStr: userModel.avatar!, imageName: "")
        wallHeadView?.userNameLbl?.text = userModel.nickname
        wallHeadView?.candyNumLbl?.text = String(userModel.candy!)
    }
    
    func initTrinketWallHeadView() {
        
        wallHeadView = TrinketWallHeadView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: 80*PROSIZE))
        self.view.addSubview(wallHeadView!)
        
        wallHeadView?.pushInfoBtn?.addTarget(self, action: #selector(pushInfoAction), for: UIControl.Event.touchUpInside)
        
        let layout = UICollectionViewFlowLayout.init()
        trinketWallCV = TrinketWallCollectionView.init(frame: CGRect.init(x: 0, y: wallHeadView!.frame.origin.y+wallHeadView!.frame.size.height, width: SCREEN_WIDE, height: SCREEN_HEIGHT-wallHeadView!.frame.origin.y-wallHeadView!.frame.size.height), collectionViewLayout: layout)
        self.view.addSubview(trinketWallCV!)
        
        trinketWallCV!.trinketWallHandel = {(dataModel) in
            let dialog = TrinketDetailDialog.init(dataModel: dataModel)
            dialog.show()
        }
    }
    
    func trinketWallList() {
        BusinessEngine.init().trinketWallList(successResponse: { (BaseModel) in
            let wallModel : TrinketWallModel = BaseModel as! TrinketWallModel
            self.trinketWallCV!.wallList = NSMutableArray.init(array: wallModel.data!)
            self.trinketWallCV?.reloadData()
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func pushInfoAction(sender:UIButton) {
        let mineDataVC = MineDataViewController.init()
        self.navigationController?.pushViewController(mineDataVC, animated: true)
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
