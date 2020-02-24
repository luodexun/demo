//
//  FindBannerCell.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

protocol FindGameDelegate {
    func findGameAction(detailModel:FindListDetailModel)
}

class FindBannerCell: UICollectionViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var barView : UIView?

    var itemCV : UICollectionView?
    
    var banner : NSArray?
    
    var gameDelegate : FindGameDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 21*PROSIZE))
        titleNameLbl.textColor = colorWithHex(hex: 0x333333)
        titleNameLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        titleNameLbl.text = "最近打开"
        self.addSubview(titleNameLbl)
        
        barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 47*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 82*PROSIZE))
        barView?.isHidden = true
        self.addSubview(barView!)
        
        let noneTitleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 15*PROSIZE, width: barView!.frame.size.width, height: 24*PROSIZE))
        noneTitleLbl.textColor = colorWithHex(hex: 0x333333)
        noneTitleLbl.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        noneTitleLbl.text = "暂无游戏最近打开记录"
        noneTitleLbl.textAlignment = .center
        barView!.addSubview(noneTitleLbl)
        
        let noneDescLbl = UILabel.init(frame: CGRect.init(x: 0, y: 48*PROSIZE, width: barView!.frame.size.width, height: 21*PROSIZE))
        noneDescLbl.textColor = colorWithHex(hex: 0x999999)
        noneDescLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        noneDescLbl.text = "只有玩游戏才有记录，赶快去玩吧！"
        noneDescLbl.textAlignment = .center
        barView!.addSubview(noneDescLbl)
               
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        
        itemCV = UICollectionView.init(frame: CGRect.init(x: 0, y: 47*PROSIZE, width: SCREEN_WIDE, height: 82*PROSIZE), collectionViewLayout: layout)
        itemCV?.delegate = self
        itemCV?.dataSource = self
        itemCV?.backgroundColor = UIColor.white
        itemCV?.showsHorizontalScrollIndicator = false
        self.addSubview(itemCV!)
        
        itemCV?.register(FindBannerItemCell.self, forCellWithReuseIdentifier: "FindBannerItemId")
    
    }
    
    func setFindBannerCell(list:NSArray) {
        if list.count != 0 {
            barView?.isHidden = true
            itemCV?.isHidden = false
        } else {
            barView?.isHidden = false
            itemCV?.isHidden = true
        }
        itemCV?.reloadData()
        banner = list
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banner!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FindBannerItemCell = itemCV?.dequeueReusableCell(withReuseIdentifier: "FindBannerItemId", for: indexPath) as! FindBannerItemCell
        let detailModel:FindListDetailModel = banner![indexPath.item] as! FindListDetailModel
        cell.iconView?.dwn_setImageView(urlStr: detailModel.icon!, imageName: "")
        cell.titleNameLbl?.text = detailModel.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 56*PROSIZE, height: 82*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailModel:FindListDetailModel = banner![indexPath.item] as! FindListDetailModel
        gameDelegate?.findGameAction(detailModel: detailModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 20*PROSIZE, bottom: 0, right: 15*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
