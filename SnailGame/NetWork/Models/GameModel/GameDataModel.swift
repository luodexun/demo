//
//  GameDataModel.swift
//  SnailGame
//
//  Created by Edison on 2019/10/9.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GameDataModel: BaseModel {
    var desc : String?
    var address : String?
    var id : String?
    var details : String?
    var app_id : String?
    var across : Int? //1.横屏 0.竖屏
    var cover : String?
    var cate : Int?
    var name : String?
    var icon : String?
    var cover_size : GameCoverModel?
}
