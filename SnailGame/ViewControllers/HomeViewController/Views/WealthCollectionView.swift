//
//  WealthCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/24.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias WealthCenterBlock = (_ opera:Int) -> Void

class WealthCollectionView: BaseCollectionView ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource , WealthCandyDelegate , WealthDwnDelegate , WealthEthDelegate , WealthWalletDelegate {
    
    var wealthCandyHandel : WealthCenterBlock?
    var wealthDwnHandel : WealthCenterBlock?
    var wealthEthHandel : WealthCenterBlock?
    var wealthWalletHandel : WealthCenterBlock?
    
    var totalRmb = "0"
    var totalDwn = "0"
    var candyNum = "0"
    var communityDwn = "0"
    var monthDwn = "0"
    var ethNum = "0"
    var walletDwn = "0"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.clear
        
        self.delegate = self
        self.dataSource = self
        
        self.register(WealthTotalCell.self, forCellWithReuseIdentifier: "WealthTotalId")
        
        self.register(WealthCandyCell.self, forCellWithReuseIdentifier: "WealthCandyId")
        
        self.register(WealthDwnCell.self, forCellWithReuseIdentifier: "WealthDwnId")
        
        self.register(WealthEthCell.self, forCellWithReuseIdentifier: "WealthEthId")
        
        self.register(WealthWalletCell.self, forCellWithReuseIdentifier: "WealthWalletId")
        
        self.register(WealthBannerCell.self, forCellWithReuseIdentifier: "WealthBannerId")
        
        setRefreshEnable()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell:WealthTotalCell = self.dequeueReusableCell(withReuseIdentifier: "WealthTotalId", for: indexPath) as! WealthTotalCell
            cell.setWealthTotalCell(totalDwn: totalDwn, totalRmb: totalRmb)
            return cell
        } else if indexPath.item == 1 {
            let cell:WealthCandyCell = self.dequeueReusableCell(withReuseIdentifier: "WealthCandyId", for: indexPath) as! WealthCandyCell
            cell.candyNumLbl?.text = candyNum
            cell.candyDelegate = self
            return cell
        } else if indexPath.item == 2 {
            let cell:WealthDwnCell = self.dequeueReusableCell(withReuseIdentifier: "WealthDwnId", for: indexPath) as! WealthDwnCell
            cell.dwnNumLbl?.text = communityDwn
            cell.monthNumLbl?.text = "+"+monthDwn
            cell.dwnDelegate = self
            return cell
        } else if indexPath.item == 3 {
            let cell:WealthEthCell = self.dequeueReusableCell(withReuseIdentifier: "WealthEthId", for: indexPath) as! WealthEthCell
            cell.ethNumLbl?.text = ethNum
            cell.ethDelegate = self
            return cell
        } else if indexPath.item == 4 {
            let cell:WealthWalletCell = self.dequeueReusableCell(withReuseIdentifier: "WealthWalletId", for: indexPath) as! WealthWalletCell
            cell.dwnNumLbl?.text = walletDwn
            cell.walletDelegate = self
            return cell
        } else {
            let cell:WealthBannerCell = self.dequeueReusableCell(withReuseIdentifier: "WealthBannerId", for: indexPath) as! WealthBannerCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: SCREEN_WIDE, height: 155*PROSIZE+STABAR_HEIGHT)
        } else if indexPath.item == 1 {
            return CGSize.init(width: SCREEN_WIDE, height: 169*PROSIZE)
        } else if indexPath.item == 2 {
            return CGSize.init(width: SCREEN_WIDE, height: 126*PROSIZE)
        } else if indexPath.item == 3 {
            return CGSize.init(width: SCREEN_WIDE, height: 134*PROSIZE)
        } else if indexPath.item == 4 {
            return CGSize.init(width: SCREEN_WIDE, height: 123*PROSIZE)
        } else {
            return CGSize.init(width: SCREEN_WIDE, height: 70*PROSIZE)
        }
    }
    
    func wealthCandyAction(opera: Int) {
        wealthCandyHandel!(opera)
    }
    
    func wealthDwnAction(opera: Int) {
        wealthDwnHandel!(opera)
    }
    
    func wealthEthAction(opera: Int) {
        wealthEthHandel!(opera)
    }
    
    func wealthWalletAction() {
        wealthWalletHandel!(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
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
