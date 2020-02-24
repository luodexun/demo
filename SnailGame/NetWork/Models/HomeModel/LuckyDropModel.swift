//
//  LuckyDropModel.swift
//  SnailGame
//
//  Created by Edison on 2019/12/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class LuckyDropModel: BaseModel {
    var data : LuckyDropDataModel?
}

class LuckyDropDataModel: BaseModel {
    var amount : String?
    var uid : String?
    var id : String?
    var day : Int?
    var surplus : String?
    var start_time : Int?
    var total : String?
    var end_time : Int?
    var draw : Int?
    var num : String?
}
