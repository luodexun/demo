//
//  GTextView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GTextView: UITextView {

    //存储属性，存放placeHolder内容
    var placeHolder: String? = "" {
        //属性观察者
        didSet {
            if self.text == "" {
                self.text = placeHolder
                self.textColor = .lightGray
            }
        }
    }
    
    
    override func becomeFirstResponder() -> Bool {
        if self.text == placeHolder || self.text == "" {
            self.text = ""
            self.textColor = .black
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        text = self.text.replacingOccurrences(of: " ", with: "")
        if text == "" {
            self.text = placeHolder
            self.textColor = .lightGray
        }
        return super.resignFirstResponder()
    }
}
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

