//
//  AllPortModel.swift
//  SnailGame
//
//  Created by Edison on 2019/9/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class AllPortModel: BaseModel {
    
    var minimumVersion : NSString?
    
    var minimumNetworkReach : Int?
    
    var globalTimeout : Int?
    
    var coldStart : Int?
    
    var list : [IPPortModel]?
}
