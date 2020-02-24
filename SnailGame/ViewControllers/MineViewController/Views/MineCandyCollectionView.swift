//
//  MineCandyCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/8.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias MineCandyBlock = (_ currentIndex:Int) -> Void

class MineCandyCollectionView: BaseCollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource  {
    
    var candy : String?
    
    var activeList = NSArray.init()
    
    var mineCandyHandel : MineCandyBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.register(MineCandyReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MineCandyReusableId")

        self.register(MineCandyCell.self, forCellWithReuseIdentifier: "MineCandyId")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MineCandyCell = self.dequeueReusableCell(withReuseIdentifier: "MineCandyId", for: indexPath) as! MineCandyCell
        cell.setMineCandyCell(candyModel: activeList[indexPath.item] as! ConfigCandyModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (SCREEN_WIDE-75*PROSIZE)/2, height: 160*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader){
            let headView : MineCandyReusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MineCandyReusableId", for: indexPath) as! MineCandyReusableView
            headView.candyNumLbl?.text = candy
            reusableview = headView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDE, height: 231*PROSIZE+STABAR_HEIGHT+44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mineCandyHandel!(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 23*PROSIZE, left: 23*PROSIZE, bottom: 0, right: 23*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 23*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25*PROSIZE
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
