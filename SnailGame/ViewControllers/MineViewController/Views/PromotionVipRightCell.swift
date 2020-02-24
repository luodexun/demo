//
//  PromotionVipRightCell.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol PromotionVipRightDelegate {
    func promotionVipRightAction(detailModel:VipInfoDetailModel)
    func promotionVipRightDetailAction()
}

class PromotionVipRightCell: UICollectionViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var barView : UIView?
    
    var rightCV : UICollectionView?
    
    var bottomBarView : UIView?
    
    var infoList = NSArray.init()
    
    var rightDelegate : PromotionVipRightDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        barView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: self.frame.size.width-40*PROSIZE, height: self.frame.size.height))
        barView?.backgroundColor = UIColor.white
        barView?.layer.cornerRadius = 10
        barView?.layer.masksToBounds = true
        self.addSubview(barView!)
        
        let leftLine = UIView.init(frame: CGRect.init(x: 71*PROSIZE, y: 27*PROSIZE, width: 50*PROSIZE, height: 1*PROSIZE))
        leftLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView?.addSubview(leftLine)
        
        let rightTitleLbl = UILabel.init(frame: CGRect.init(x: leftLine.frame.origin.x+leftLine.frame.size.width, y: 20*PROSIZE, width: 95*PROSIZE, height: 17*PROSIZE))
        rightTitleLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        rightTitleLbl.text = "VIP权益"
        rightTitleLbl.textColor = colorWithHex(hex: 0x333333)
        rightTitleLbl.textAlignment = NSTextAlignment.center
        barView?.addSubview(rightTitleLbl)
        
        let rightLine = UIView.init(frame: CGRect.init(x: rightTitleLbl.frame.origin.x+rightTitleLbl.frame.size.width, y: 27*PROSIZE, width: 50*PROSIZE, height: 1*PROSIZE))
        rightLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        barView?.addSubview(rightLine)
        
        let layout = UICollectionViewFlowLayout.init()
        rightCV = UICollectionView.init(frame: CGRect.init(x: 0, y: 59*PROSIZE, width: barView!.frame.size.width, height: 422*PROSIZE), collectionViewLayout: layout)
        rightCV?.backgroundColor = UIColor.white
        rightCV?.isScrollEnabled = false
        rightCV?.delegate = self
        rightCV?.dataSource = self
        barView!.addSubview(rightCV!)
        
        rightCV?.register(RightItemCell.self , forCellWithReuseIdentifier: "RightItemId")
        
        bottomBarView = UIView.init(frame: CGRect.init(x: 0, y: rightCV!.frame.origin.y+rightCV!.frame.size.height+20*PROSIZE, width: barView!.frame.size.width, height: 60*PROSIZE))
        barView?.addSubview(bottomBarView!)
        
        let bottomLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: 0, width: bottomBarView!.frame.size.width-40*PROSIZE, height: 1*PROSIZE))
        bottomLine.backgroundColor = colorWithHex(hex: 0xeeeeee)
        bottomBarView?.addSubview(bottomLine)
        
        let rightDetailBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        rightDetailBtn.frame = CGRect.init(x: 20*PROSIZE, y: bottomLine.frame.origin.y+bottomLine.frame.size.height+17*PROSIZE, width: bottomBarView!.frame.size.width-40*PROSIZE, height: 30*PROSIZE)
        rightDetailBtn.setTitle("权益详情", for: UIControl.State.normal)
        rightDetailBtn.setTitleColor(colorWithHex(hex: 0x0077FF), for: UIControl.State.normal)
        rightDetailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rightDetailBtn.addTarget(self, action: #selector(rightDetailAction), for: UIControl.Event.touchUpInside)
        bottomBarView?.addSubview(rightDetailBtn)
        
        let rightdescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: rightDetailBtn.frame.origin.y+rightDetailBtn.frame.size.height, width: bottomBarView!.frame.size.width-40*PROSIZE, height: 12*PROSIZE))
        rightdescLbl.font = UIFont.systemFont(ofSize: 12*PROSIZE)
        rightdescLbl.text = "权益持续增加，了解每项特权详情"
        rightdescLbl.textColor = colorWithHex(hex: 0x999999)
        rightdescLbl.textAlignment = NSTextAlignment.center
        bottomBarView?.addSubview(rightdescLbl)
    }
    
    @objc func rightDetailAction(sender:UIButton) {
        rightDelegate!.promotionVipRightDetailAction()
    }
    
    func setPromotionVipRightCell(list:NSArray) {
        rightCV?.reloadData()
        infoList = list
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RightItemCell = rightCV?.dequeueReusableCell(withReuseIdentifier: "RightItemId", for: indexPath) as! RightItemCell
        let detailModel:VipInfoDetailModel = infoList[indexPath.item] as! VipInfoDetailModel
        cell.rightImageView?.dwn_setImageView(urlStr: detailModel.icon_active!, imageName: "")
        cell.rightNameLbl?.text = detailModel.title
        cell.rightDescLbl?.text = detailModel.synopsis
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (SCREEN_WIDE-40*PROSIZE)/3, height: 122*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rightDelegate?.promotionVipRightAction(detailModel: infoList[indexPath.item] as! VipInfoDetailModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 20*PROSIZE, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
