//
//  RankListDataModel.swift
//  SnailGame
//
//  Created by Edison on 2019/10/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RankListDataModel: BaseModel {
    var nowrank : RankListNowModel?
    var remaining_time : String?
    var list : [RankListPageModel]?
}
