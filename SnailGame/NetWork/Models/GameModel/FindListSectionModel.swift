//
//  FindListSectionModel.swift
//  SnailGame
//
//  Created by Edison on 2020/1/3.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class FindListSectionModel: BaseModel {
    var status : Int?
    var banner : [FindListDetailModel]?
    var id : String?
    var app_list : [FindListDetailModel]?
    var display_num : Int?
    var hot : Int?
    var name : String?
    var isSelect : Bool?
    var isFirst : Bool?
    var currentCount : Int?
}
