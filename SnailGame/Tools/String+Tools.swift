//
//  String+Tools.swift
//  SnailGame
//
//  Created by Edison on 2019/9/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit
import Foundation

extension NSString {
    
    static func calStrSize(textStr:NSString,width:CGFloat,fontSize:CGFloat) -> CGSize {
        let size = textStr.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize)], context: nil).size
        return size
    }
    
    static func calStrSize(textStr:NSString,height:CGFloat,fontSize:CGFloat) -> CGSize {
        let size = textStr.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize)], context: nil).size
        return size
    }
}
