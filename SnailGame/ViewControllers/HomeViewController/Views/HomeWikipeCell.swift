//
//  HomeWikipeCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol HomeWikipeDelegate {
    func homeWikipeAction(dataModel:InfoDataModel)
}

class HomeWikipeCell: UICollectionViewCell ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var wikipeCV : UICollectionView?
    
    var wikipeList = NSArray.init()
    
    var wikipeDelegate : HomeWikipeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 10*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let wikipeTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 30*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 17*PROSIZE))
        wikipeTitleLbl.text = "蜗牛百科"
        wikipeTitleLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        wikipeTitleLbl.textColor = colorWithHex(hex: 0x333333)
        self.addSubview(wikipeTitleLbl)
        
        let layout = UICollectionViewFlowLayout.init()
        wikipeCV = UICollectionView.init(frame: CGRect.init(x: 0, y: 59*PROSIZE, width: SCREEN_WIDE, height: 180*PROSIZE), collectionViewLayout: layout)
        wikipeCV?.backgroundColor = UIColor.white
        wikipeCV?.delegate = self
        wikipeCV?.dataSource = self
        wikipeCV?.isScrollEnabled = false
        self.addSubview(wikipeCV!)
        
        wikipeCV?.register(WikipeItemCell.self , forCellWithReuseIdentifier: "WikipeItemId")
        
    }
    
    func setHomeWikipeCell(list:NSArray) {
        wikipeCV?.reloadData()
        wikipeList = list
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wikipeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WikipeItemCell = wikipeCV?.dequeueReusableCell(withReuseIdentifier: "WikipeItemId", for: indexPath) as! WikipeItemCell
        cell.bgImageView?.image = UIImage.init(named: "icon_home_wikipe_0"+String(indexPath.item+1))
        let dataModel : InfoDataModel = wikipeList[indexPath.item] as! InfoDataModel
        if indexPath.row == 1 {
            cell.titleNameLbl?.textColor = colorWithHex(hex: 0x666666)
            cell.subTitleLbl?.textColor = colorWithHex(hex: 0x666666)
        } else {
            cell.titleNameLbl?.textColor = UIColor.white
            cell.subTitleLbl?.textColor = UIColor.white
        }
        cell.titleNameLbl?.text = dataModel.title
        cell.subTitleLbl?.text = dataModel.desc
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (SCREEN_WIDE-50*PROSIZE)/2, height: 80*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        wikipeDelegate?.homeWikipeAction(dataModel: wikipeList[indexPath.item] as! InfoDataModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10*PROSIZE, left: 20*PROSIZE, bottom: 0, right: 20*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
