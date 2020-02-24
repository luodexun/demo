//
//  VipInfoDataModel.swift
//  SnailGame
//
//  Created by Edison on 2019/10/15.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class VipInfoDataModel: BaseModel {
    var information : [VipInfoDetailModel]?
    var price_old : String?
    var type : Int?
    var price : String?
    var effective_days : Int?
    var sum_days : Int?
}
