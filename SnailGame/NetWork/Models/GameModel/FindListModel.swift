//
//  FindListModel.swift
//  SnailGame
//
//  Created by Edison on 2020/1/3.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

class FindListModel: BaseModel {
    var data : FindListDataModel?
}

class FindListDataModel: BaseModel {
    var head : FindListHeadModel?
    var list : [FindListSectionModel]?
}

class FindListHeadModel: BaseModel {
    var banner : [FindListBannerModel]?
    var record : [FindListDetailModel]?
}
