//
//  LuckyDrawDialog.swift
//  SnailGame
//
//  Created by Edison on 2019/12/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class LuckyDrawDialog: UIView {
    
    var coverView : UIView?
    
    var barImageView , giftImageView : UIImageView?
   
    var amountNumLbl : UILabel?
    
    var giftStartFrame : CGRect = CGRect.init(x: (SCREEN_WIDE - 245*PROSIZE/10)/2, y: (SCREEN_HEIGHT - 234*PROSIZE/10)/2, width: 245*PROSIZE/10, height: 234*PROSIZE/10)
    
    var giftEndFrame : CGRect = CGRect.init(x: (SCREEN_WIDE - 245*PROSIZE)/2, y: (SCREEN_HEIGHT - 234*PROSIZE)/2, width: 245*PROSIZE, height: 234*PROSIZE)
    
    var barStartFrame : CGRect = CGRect.init(x: (SCREEN_WIDE - 326*PROSIZE/10)/2, y: (SCREEN_HEIGHT - 335*PROSIZE/10)/2, width: 326*PROSIZE/10, height: 335*PROSIZE/10)
    
    var barEndFrame : CGRect = CGRect.init(x: (SCREEN_WIDE - 326*PROSIZE)/2, y: (SCREEN_HEIGHT - 335*PROSIZE)/2, width: 326*PROSIZE, height: 335*PROSIZE)
    
    var numEndFrame : CGRect = CGRect.init(x: (SCREEN_WIDE - 326*PROSIZE)/2, y: (SCREEN_HEIGHT - 34*PROSIZE)/2-16*PROSIZE, width: 326*PROSIZE, height: 34*PROSIZE)
 
    init(amountStr:String) {
        super.init(frame: UIScreen.main.bounds)
        setupView(amountStr: amountStr)
    }
    
    func setupView(amountStr:String) {
        
        coverView = UIView.init(frame: self.bounds)
        coverView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        addSubview(coverView!)
        
        let coverTap = UITapGestureRecognizer.init(target: self, action: #selector(coverClose))
        coverView?.addGestureRecognizer(coverTap)
        
        barImageView = UIImageView.init(frame: barStartFrame)
        barImageView?.image = UIImage.init(named: "ic_lucky_drop_light")
        self.addSubview(barImageView!)
        
        giftImageView = UIImageView.init(frame: giftStartFrame)
        giftImageView?.image = UIImage.init(named: "ic_lucky_drop_gift")
        self.addSubview(giftImageView!)
        
        amountNumLbl = UILabel.init(frame: numEndFrame)
        amountNumLbl?.isHidden = true
        amountNumLbl?.textAlignment = .center
        amountNumLbl?.textColor = colorWithHex(hex: 0xFF7700)
        amountNumLbl?.font = UIFont.boldSystemFont(ofSize: 30*PROSIZE)
        amountNumLbl?.text = amountStr
        self.addSubview(amountNumLbl!)
        
    }
    
    @objc func coverClose(tap:UIGestureRecognizer) {
        close()
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.5, animations: {
            self.barImageView?.frame = self.barEndFrame
            self.giftImageView?.frame = self.giftEndFrame
        }) { (complate) in
            self.amountNumLbl?.isHidden = false
        }
        let emitterLayer = createEmitterLayer(view: self, window: giftImageView!)
        startAnimate(emitterLayer: emitterLayer)
    }
    
    func startAnimate(emitterLayer:CAEmitterLayer) {
        
        let redBurst = CABasicAnimation.init(keyPath: "emitterCells.red.birthRate")
        redBurst.fromValue = NSNumber.init(value: 30)
        redBurst.toValue = NSNumber.init(value: 0.0)
        redBurst.duration = 0.5
        redBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        
        let yellowBurst = CABasicAnimation.init(keyPath: "emitterCells.yellow.birthRate")
        yellowBurst.fromValue = NSNumber.init(value: 30)
        yellowBurst.toValue = NSNumber.init(value: 0.0)
        yellowBurst.duration = 0.5
        yellowBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
          
        let blueBurst = CABasicAnimation.init(keyPath: "emitterCells.blue.birthRate")
        blueBurst.fromValue = NSNumber.init(value: 30)
        blueBurst.toValue = NSNumber.init(value: 0.0)
        blueBurst.duration = 0.5
        blueBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        
        let starBurst = CABasicAnimation.init(keyPath: "emitterCells.star.birthRate")
        starBurst.fromValue = NSNumber.init(value: 30)
        starBurst.toValue = NSNumber.init(value: 0.0)
        starBurst.duration = 0.5
        starBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        
        let group = CAAnimationGroup.init()
        group.animations = [redBurst,yellowBurst,blueBurst,starBurst]
        emitterLayer.add(group, forKey: "heartsBurst")
    }
    
    func createEmitterLayer(view:UIView,window:UIImageView) -> CAEmitterLayer {
        let subCell1 = subCell(image: imageWithColor(color: colorWithHex(hex: 0xF80D67)))
        subCell1.name = "red"
        let subCell2 = subCell(image: imageWithColor(color: colorWithHex(hex: 0xFED51F)))
        subCell2.name = "yellow"
        let subCell3 = subCell(image: imageWithColor(color: colorWithHex(hex: 0x78F23D)))
        subCell3.name = "green"
        let subCell4 = subCell(image: UIImage.init(named: "ic_lucky_drop_star")!)
        subCell4.name = "star"
        
        let emitterLayer = CAEmitterLayer.init()
        emitterLayer.position = window.center
        emitterLayer.emitterPosition = window.center
        emitterLayer.emitterSize = window.bounds.size
        emitterLayer.emitterMode = CAEmitterLayerEmitterMode.outline
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.rectangle
        emitterLayer.renderMode = CAEmitterLayerRenderMode.oldestFirst
        emitterLayer.emitterCells = [subCell1,subCell2,subCell3,subCell4]
        view.layer.addSublayer(emitterLayer)
        return emitterLayer
    }
    
    func subCell(image:UIImage) -> CAEmitterCell {
        let cell = CAEmitterCell.init()
        cell.name = "heart"
        cell.contents = image.cgImage
        cell.scale = 0.6
        cell.scaleRange = 0.6
        cell.lifetime = 20
        cell.velocity = 200
        cell.velocityRange = 200
        cell.yAcceleration = 9.8
        cell.xAcceleration = 0
        cell.emissionRange  = .pi
        cell.scaleSpeed = -0.05
        cell.spin = 2 * .pi
        cell.spinRange = 2 * .pi
        return cell
    }
    
    func imageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 13, height: 17)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func close() {
        self.amountNumLbl?.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.barImageView?.frame = self.barStartFrame
            self.giftImageView?.frame = self.giftStartFrame
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
