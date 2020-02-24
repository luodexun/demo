//
//  NoticePushModel.swift
//  SnailGame
//
//  Created by Edison on 2019/12/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class NoticePushModel: BaseModel {
    var data : NoticePushDataModel?
}

class NoticePushDataModel: BaseModel {
    var id : Int?
    var title : String?
}
