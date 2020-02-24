//
//  JQIDCardScaningView.swift
//  SnailGame
//
//  Created by Edison on 2019/11/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class JQIDCardScaningView: UIView {

    var facePathRect : CGRect?
    
    var IDCardScanningWindowLayer : CAShapeLayer?
    
    var timer : Timer?
    
    var moveX:CGFloat = 0.0
    
    var distanceX:CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        addScaningWindow()
        addTimer()
    }
    
    func addScaningWindow() {
        // 中间包裹线
        IDCardScanningWindowLayer = CAShapeLayer.init()
        IDCardScanningWindowLayer?.position = self.layer.position
        let width = 270*PROSIZE
        IDCardScanningWindowLayer?.bounds = CGRect.init(origin: .zero, size: CGSize.init(width: width, height: width*1.574))
        IDCardScanningWindowLayer?.cornerRadius = 15
        IDCardScanningWindowLayer?.borderColor = UIColor.white.cgColor
        IDCardScanningWindowLayer?.borderWidth = 1.5
        self.layer.addSublayer(IDCardScanningWindowLayer!)
        // 最里层镂空
        let transparentRoundedRectPath = UIBezierPath.init(roundedRect: IDCardScanningWindowLayer!.frame, cornerRadius: IDCardScanningWindowLayer!.cornerRadius)
        // 最外层背景
        let path = UIBezierPath.init(rect: self.frame)
        path.append(transparentRoundedRectPath)
        path.usesEvenOddFillRule = true
        let fillLayer = CAShapeLayer.init()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.6
        self.layer.addSublayer(fillLayer)
        
        let facePathWidth = 80*PROSIZE
        let facePathHeight = facePathWidth
        let rect = IDCardScanningWindowLayer?.frame
        facePathRect = CGRect.init(x: rect!.maxX-facePathWidth-35*PROSIZE, y: rect!.minY+25*PROSIZE, width: facePathWidth, height: facePathHeight)
        // 国徽
        let headIV = UIImageView.init(frame: facePathRect!)
        headIV.image = UIImage.init(named: "icon_idcard_second_emblem")
        headIV.transform = CGAffineTransform.init(rotationAngle: .pi * 0.5)
        headIV.contentMode = .scaleAspectFill
        self.addSubview(headIV)
    }
    
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    @objc func timerFire(notice:Timer) {
        self.setNeedsDisplay()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let rect = IDCardScanningWindowLayer?.frame
        let facePath = UIBezierPath.init(rect: facePathRect!)
        facePath.lineWidth = 1.5
        UIColor.white.set()
        facePath.stroke()
        // 水平扫描线
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.beginPath()
        context.setLineWidth(2)
        context.setStrokeColor(colorWithHex(hex: 0x0077ff).cgColor)
        var p1:CGPoint
        var p2:CGPoint
        
        moveX += distanceX
        if moveX >= (rect!.width-2) {
            distanceX = -2
        } else if moveX <= 2 {
            distanceX = 2
        }
        
        p1 = CGPoint.init(x: rect!.maxX - moveX, y: rect!.origin.y)
        p2 = CGPoint.init(x: rect!.maxX - moveX, y: rect!.origin.y+rect!.size.height)
        context.move(to: CGPoint.init(x: p1.x, y: p1.y))
        context.addLine(to: CGPoint.init(x: p2.x, y: p2.y))
        context.strokePath()
    }

}
