//
//  DailyClockViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DailyClockViewController: BaseViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var barView : UIView?
    
    var dailyClockCV : DailyClockCollectionView?

    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initNaviView(bgColor: UIColor.clear)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "每日打卡", titleColor: colorWithHex(hex: 0x333333))
        showLoading(view: self.view)
        getSignList()
        
    }
    
    func initViews() {
        let bgImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 230*PROSIZE+STABAR_HEIGHT))
        bgImageView.image = UIImage.init(named: "icon_daily_clock_bg")
        self.view.addSubview(bgImageView)
    }
    
    func getSignList() {
        BusinessEngine.init().signToday(successResponse: { (baseModel) in
            self.view.hideToastActivity()
            let dialyModel = baseModel as! DailyClockModel
            if dialyModel.data!.count > 0 {
                if self.isFirst {
                    self.barView = UIView.init(frame: CGRect.init(x: 12*PROSIZE, y: 152*PROSIZE+STABAR_HEIGHT, width: SCREEN_WIDE-24*PROSIZE, height: 60*PROSIZE*CGFloat(dialyModel.data!.count/7)+60*PROSIZE*CGFloat(dialyModel.data!.count % 7)+30*PROSIZE))
                    self.barView?.backgroundColor = UIColor.white
                    self.barView!.layer.shadowColor = colorWithHex(hex: 0x999999).cgColor
                    self.barView!.layer.shadowOffset = CGSize.init(width: 0, height: 5)
                    self.barView!.layer.shadowOpacity = 0.5
                    self.barView!.layer.shadowRadius = 5
                    self.barView!.layer.cornerRadius = 10
                    self.view.addSubview(self.barView!)
                    
                    let layout = UICollectionViewFlowLayout.init()
                    self.dailyClockCV = DailyClockCollectionView.init(frame: CGRect.init(x: (SCREEN_WIDE-360*PROSIZE)/2, y: 15*PROSIZE, width: 336*PROSIZE, height: (self.barView?.frame.size.height)! - 30*PROSIZE), collectionViewLayout: layout)
                    self.barView?.addSubview(self.dailyClockCV!)
                    
                    self.dailyClockCV!.dailyClockHandel = {
                        showLoading(view: self.view)
                        self.sign()
                    }
            
                    let promptScrolView = UIScrollView.init(frame: CGRect.init(x: 20*PROSIZE, y: (self.barView?.frame.origin.y)!+(self.barView?.frame.size.height)!, width: SCREEN_WIDE-40*PROSIZE, height: SCREEN_HEIGHT-(self.barView?.frame.origin.y)!-(self.barView?.frame.size.height)!))
                    promptScrolView.showsVerticalScrollIndicator = false
                    self.view.addSubview(promptScrolView)
                    
                    let promptTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 30*PROSIZE, width: promptScrolView.frame.size.width, height: 16*PROSIZE))
                    promptTitleLbl.text = "打卡规则"
                    promptTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
                    promptTitleLbl.textAlignment = .center
                    promptTitleLbl.textColor = colorWithHex(hex: 0xFF2357)
                    promptScrolView.addSubview(promptTitleLbl)
                    
                    let str = UserDefaults.standard.string(forKey: GAMECONFIG)
                    let configModel = ConfigModel.deserialize(from: str)
                    
                    let ruleSize = NSString.calStrSize(textStr: configModel!.sign_rule! as NSString, width: promptScrolView.frame.size.width, fontSize: 15*PROSIZE)
                    let ruleLbl = UILabel.init(frame: CGRect.init(x: 0, y: promptTitleLbl.frame.origin.y+promptTitleLbl.frame.size.height+20*PROSIZE, width: promptScrolView.frame.size.width, height: ruleSize.height))
                    ruleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
                    ruleLbl.text = configModel?.sign_rule!
                    ruleLbl.textColor = colorWithHex(hex: 0x999999)
                    ruleLbl.numberOfLines = 0
                    promptScrolView.addSubview(ruleLbl)
                    self.isFirst = false
                    promptScrolView.contentSize = CGSize.init(width: promptScrolView.frame.size.width, height: 86*PROSIZE+ruleSize.height)
                }
                self.dailyClockCV!.dailyList = dialyModel.data! as NSArray
                self.dailyClockCV?.reloadData()
            }
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func sign() {
        BusinessEngine.init().sign(successResponse: { (baseModel) in
            let signModel = baseModel as! DailySignModel
            showAlert(currentVC: self, title: "", meg: "打卡成功，获得 " + signModel.data!.award! + " 个糖果。", cancel: "", sure: "确定", cancelHandler: { (action) in
                
            }) { (action) in
                
            }
            self.getUserInfo()
            self.playSound()
            self.getSignList()
        }) { (baseModel) in
            self.view.hideToastActivity()
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
        }) { (BaseModel) in
        }
    }
    
    func playSound() {
        var soundId:SystemSoundID = 0
        let path = Bundle.main.path(forResource: "golden", ofType: "mp3")
        let soundUrl = URL.init(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
        AudioServicesPlaySystemSound(soundId)
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
