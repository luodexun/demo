//
//  MineShowObject.swift
//  SnailGame
//
//  Created by Edison on 2019/9/16.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineShowObject: NSObject {
    
    func getMineList(isService:Int) -> NSArray {
        
        let arrList = NSMutableArray.init()
        
        let showModel1 = MineShowModel.init()
        showModel1.titleName = ""
        showModel1.cellType = 1
        showModel1.operaType = 0
        showModel1.contentStr = "";
        showModel1.imageStr = "";
        arrList.add(showModel1)
        
        if isService != 0 {
            let showModel2 = MineShowModel.init()
            showModel2.titleName = "推广奖励"
            showModel2.cellType = 2
            showModel2.operaType = 1
            showModel2.contentStr = "";
            showModel2.imageStr = "ic_mine_promote";
            arrList.add(showModel2)
            
            let showModel3 = MineShowModel.init()
            showModel3.titleName = "任务奖励"
            showModel3.cellType = 2
            showModel3.operaType = 2
            showModel3.contentStr = "超多DWN等你赚";
            showModel3.imageStr = "ic_mine_task";
            arrList.add(showModel3)
            
            let showModel4 = MineShowModel.init()
            showModel4.titleName = ""
            showModel4.cellType = 1
            showModel4.operaType = 0
            showModel4.contentStr = "";
            showModel4.imageStr = "";
            arrList.add(showModel4)
        }
        
        let showModel5 = MineShowModel.init()
        showModel5.titleName = "数字资产"
        showModel5.cellType = 2
        showModel5.operaType = 3
        showModel5.contentStr = "";
        showModel5.imageStr = "ic_mine_wealth";
        arrList.add(showModel5)
        
        let showModel6 = MineShowModel.init()
        showModel6.titleName = "我的钱包"
        showModel6.cellType = 2
        showModel6.operaType = 4
        showModel6.contentStr = "";
        showModel6.imageStr = "ic_mine_pause";
        arrList.add(showModel6)
        
        let showModel7 = MineShowModel.init()
        showModel7.titleName = "我的糖果"
        showModel7.cellType = 2
        showModel7.operaType = 5
        showModel7.contentStr = "";
        showModel7.imageStr = "ic_mine_ sugar";
        arrList.add(showModel7)
        
        let showModel8 = MineShowModel.init()
        showModel8.titleName = ""
        showModel8.cellType = 1
        showModel8.operaType = 0
        showModel8.contentStr = "";
        showModel8.imageStr = "";
        arrList.add(showModel8)
        
        let showModel9 = MineShowModel.init()
        showModel9.titleName = "安全设置"
        showModel9.cellType = 2
        showModel9.operaType = 6
        showModel9.contentStr = "";
        showModel9.imageStr = "ic_mine_safe";
        arrList.add(showModel9)
        
        let showModel10 = MineShowModel.init()
        showModel10.titleName = "实名认证"
        showModel10.cellType = 2
        showModel10.operaType = 7
        showModel10.contentStr = "";
        showModel10.imageStr = "ic_mine_auth";
        arrList.add(showModel10)
        
        let showModel11 = MineShowModel.init()
        showModel11.titleName = ""
        showModel11.cellType = 1
        showModel11.operaType = 0
        showModel11.contentStr = "";
        showModel11.imageStr = "";
        arrList.add(showModel11)
        
        let showModel12 = MineShowModel.init()
        showModel12.titleName = "消息通知"
        showModel12.cellType = 2
        showModel12.operaType = 8
        showModel12.contentStr = "";
        showModel12.imageStr = "ic_mine_notice";
        arrList.add(showModel12)
        
        let showModel13 = MineShowModel.init()
        showModel13.titleName = "联系客服"
        showModel13.cellType = 2
        showModel13.operaType = 9
        showModel13.contentStr = "";
        showModel13.imageStr = "ic_mine_connect";
        arrList.add(showModel13)
        
        let showModel14 = MineShowModel.init()
        showModel14.titleName = ""
        showModel14.cellType = 1
        showModel14.operaType = 0
        showModel14.contentStr = "";
        showModel14.imageStr = "";
        arrList.add(showModel14)
        
        let showModel15 = MineShowModel.init()
        showModel15.titleName = "设置"
        showModel15.cellType = 2
        showModel15.operaType = 10
        showModel15.contentStr = "";
        showModel15.imageStr = "ic_mine_set";
        arrList.add(showModel15)
        
        let showModel116 = MineShowModel.init()
        showModel116.titleName = ""
        showModel116.cellType = 1
        showModel116.operaType = 0
        showModel116.contentStr = "";
        showModel116.imageStr = "";
        arrList.add(showModel116)
        
        return arrList
    }
    
    func getCurrentIndex(arrList:NSArray,operaType:Int) -> Int {
        var currentIndex = 0
        for (i,item) in arrList.enumerated() {
            let showModel = item as! MineShowModel
            if showModel.operaType == operaType {
                currentIndex = i
                break
            }
        }
        return currentIndex
    }
    
    
}
