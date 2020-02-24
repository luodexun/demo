//
//  SnailGame.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import Foundation

import UIKit

#if true //正式服务器  false： 测试服务器

let BASE_HOST = "https://apislb.digisnail.cn"

let GAME_HOST = "https://apislb.digisnail.cn/game2"

let BASE_CONFIG = "http://digisnail-config.oss-cn-shanghai.aliyuncs.com/mainconfig.json" //配置信息

let BASE_PEERS = "https://apislb.digisnail.cn/network/mainnet.json" //节点

let kRechareAddress = "DbckuwD8zb2MyWXoWz5EVmDMYwQ8Ly9Sym" // 充币地址

let kTiBiAddress = "DbckuwD8zb2MyWXoWz5EVmDMYwQ8Ly9Sym"  // 提币地址

#else

let BASE_HOST = "http://192.168.0.103"

let GAME_HOST = "http://192.168.0.103/game2"

let BASE_CONFIG = "http://digisnail-config.oss-cn-shanghai.aliyuncs.com/devconfig.json"

let BASE_PEERS = "http://192.168.0.103/network/devnet.json"

let kRechareAddress = "CKi6qrDQrwnnhLcmnYgRBnC5ebXboFkZhU"

let kTiBiAddress = "CKi6qrDQrwnnhLcmnYgRBnC5ebXboFkZhU"

#endif

let BROWSER_HOST = "http://47.103.32.213:4200"

let TOKEN_RATIO = "100000000"

let ETH_RATIO = "1000000000000000000"


let SCREEN_WIDE : CGFloat = UIScreen.main.bounds.width

let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.height

let SUPER_PHONE = ((Int)((SCREEN_HEIGHT/SCREEN_WIDE)*100) == 216) ? true : false

let SAFE_BOTTOM : CGFloat = SUPER_PHONE == true ? 34 : 0

let STABAR_HEIGHT : CGFloat = SUPER_PHONE == true ? 44 : 20

let PROSIZE : CGFloat = SCREEN_WIDE / 375



