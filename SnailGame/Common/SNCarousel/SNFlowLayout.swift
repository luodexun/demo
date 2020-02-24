//
//  SNFlowLayout.swift
//  SnailGame
//
//  Created by Edison on 2019/12/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class SNFlowLayout: UICollectionViewFlowLayout {
    
    var itemSpace_H : CGFloat? //横向滚动时,每张轮播图之间的间距
    
    var itemWidth : CGFloat? = 330*PROSIZE //横向滚动时,每张轮播图的宽度

    override init() {
        super.init()
        initial()
    }
    
    func initial() {
        itemSpace_H = 10*PROSIZE
    }
    
    override func prepare() {
        self.itemSize = CGSize.init(width: itemWidth!, height: (self.collectionView?.frame.size.height)!)
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = itemSpace_H!
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let arrList = NSArray.init(array: super.layoutAttributesForElements(in: rect)!)
        let centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width * 0.5
        var maxScale:CGFloat = 0.0
        var attri:UICollectionViewLayoutAttributes? = nil
        arrList.enumerateObjects { (att, idx, stop) in
            let obj = att as! UICollectionViewLayoutAttributes
            let space = abs(obj.center.x - centerX)
            if space >= 0 {
                let scale:CGFloat = 1
                obj.transform = CGAffineTransform.init(scaleX: scale, y: scale)
                if maxScale < scale {
                    maxScale = scale
                    attri = obj
                }
            }
            obj.zIndex = 0
        }
        if attri != nil {
            attri?.zIndex = 1
        }
        return arrList as? [UICollectionViewLayoutAttributes]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
