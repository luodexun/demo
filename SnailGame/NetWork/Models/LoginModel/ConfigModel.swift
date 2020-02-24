//
//  ConfigModel.swift
//  SnailGame
//
//  Created by Edison on 2019/10/9.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ConfigModel: BaseModel  {
    var public_number_wx : String?
    var exchange_limit_mini : String?
    var service_wx : String?
    var popularize_bg : String?
    var release_introduce : String?
    var sign_rule : String?
    var luck_rule : String?
    var candy_exchange_rule : String?
    var exchange_limit_max : String?
    var region : [ConfigRegionModel]?
    var public_wx : String?
    var service_number_wx : String?
    var web_domain : String?
    var popularize_text : String?
    var popularize_reward : String?
    var candy_active : [ConfigCandyModel]?
    var LuckDraw : luckyModel?
    
}
