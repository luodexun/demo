//
//  UIImage+Tools.swift
//  SnailGame
//
//  Created by Edison on 2019/9/26.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import Foundation

extension UIImage {
    
    func compressImageMid(maxLength: Int) -> UIImage? {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: 1) else { return nil }
        if data.count < maxLength {
            return self
        }
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        let resultImage: UIImage = UIImage(data: data)!
        return resultImage
    }
}
