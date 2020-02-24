//
//  GamePriceModel.swift
//  SnailGame
//
//  Created by Edison on 2020/1/7.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class GamePriceModel: BaseModel {
    var data : GamePriceDataModel?
}

class GamePriceDataModel: BaseModel {
    var cnzPrise : String?
    var usdtPrise : String?
}
