//
//  UserLoginDataModel.swift
//  SnailGame
//
//  Created by Edison on 2019/10/11.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

import HandyJSON

class UserLoginDataModel: HandyJSON {
    var avatar : String?
    var badge : [UserLoginBadgeModel]?
    var candy : String?
    var freeze : String?
    var id_card : String?
    var is_certified : Int?
    var mobile : String?
    var nickname : String?
    var notice_num : Int?
    var pay_method : Int?
    var profit : String?
    var ratio : String?
    var region : String?
    var secret : String?
    var shield : Int?
    var status : Int?
    var token : String?
    var username : String?
    var code : String?
    var vip : Int?
    var vip_privilege : String?
    var wallet_address : String?
    var cacheBalance : String?
    var air_drop : Int?
    var id : String?
    var currency : [UserLoginCurrencyModel]?
    required init(){}
}
