//
//  RectManager.swift
//  SnailGame
//
//  Created by Edison on 2019/11/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import Foundation

func getEffectImageRect(size:CGSize) -> CGRect {
    var size1 = size
    let size2 = UIScreen.main.bounds.size
    var point_x:CGFloat = 0
    var point_y:CGFloat = 0
    
    if size.width/size.height > size2.width/size2.height {
        let oldW = size.width
        size1.width = size2.width / size2.height * size.height
        point_x = (oldW - size1.width)/2
        point_y = 0
    } else {
        let oldH = size.height
        size1.height = size2.height / size2.width * size.width
        point_x = 0
        point_y = (oldH - size1.height)/2
    }
    return CGRect.init(x: point_x, y: point_y, width: size1.width, height: size1.height)
}

func getGuideFrame(rect:CGRect) -> CGRect {
    let previewWidth = rect.size.height
    let previewHeight = rect.size.width
    var cardh , cardw , left , top : CGFloat
    cardw = previewWidth*70/100
    if previewWidth < cardw {
        cardw = previewWidth
    }
    cardh = cardw / 0.63084
    left = (previewWidth-cardw)/2
    top = (previewHeight-cardh)/2
    return CGRect.init(x: top+rect.origin.x, y: left+rect.origin.y, width: cardh, height: cardw)
}

func getImageStream(imageBuffer:CVImageBuffer) -> UIImage {
    let ciImage = CIImage.init(cvImageBuffer: imageBuffer)
    let temporaryContext = CIContext.init(options: nil)
    let videoImage = temporaryContext.createCGImage(ciImage, from: CGRect.init(x: 0, y: 0, width: CVPixelBufferGetWidth(imageBuffer), height: CVPixelBufferGetHeight(imageBuffer)))
    let image = UIImage.init(cgImage: videoImage!)
    return image
}

func getSubImage(rect:CGRect,image:UIImage) -> UIImage {
    let subImageRef:CGImage = image.cgImage!.cropping(to: rect)!
    let smallBounds = CGRect.init(x: 0, y: 0, width: subImageRef.width, height: subImageRef.height)
    UIGraphicsBeginImageContext(smallBounds.size)
    let context = UIGraphicsGetCurrentContext()
    context!.draw(subImageRef, in: smallBounds)
    let smallImage = UIImage.init(cgImage: subImageRef)
    UIGraphicsEndImageContext()
    return smallImage
}
