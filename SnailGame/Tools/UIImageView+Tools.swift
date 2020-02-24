//
//  UIImageView+Tools.swift
//  SnailGame
//
//  Created by Edison on 2019/10/9.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import Foundation

import AlamofireImage

extension UIImageView {
    func dwn_setImageView(urlStr : String , imageName : String) {
        let url = URL.init(string: urlStr)
        self.sd_setImage(with: url, placeholderImage: UIImage.init(named: imageName))
        //self.af_setImage(withURL: url!, placeholderImage: UIImage.init(named: imageName))
    }
}
