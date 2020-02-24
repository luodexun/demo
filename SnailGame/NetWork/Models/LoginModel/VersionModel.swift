//
//  VersionModel.swift
//  SnailGame
//
//  Created by Edison on 2019/12/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class VersionModel: BaseModel {
    var data : VersionDataModel?
}

class VersionDataModel: BaseModel {
    var address : String?
    var prompt : Int?
    var versions : String?
    var force : Int?
    var is_update : Int?
    var is_pass : Int? //1.真实 0.其他
}
