//
//  TradeRecordDataModel.swift
//  SnailGame
//
//  Created by Edison on 2019/10/15.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class TradeRecordDataModel: BaseModel {
    var id : String?
    var amount : Int?
    var blockId : String?
    var fee : Int?
    var type : Int?
    var signature : String?
    var confirmations : Int?
    var recipient : String?
    var vendorField : String?
    var sender : String?
    var timestamp : TradeRecordTimeModel?
    
}
