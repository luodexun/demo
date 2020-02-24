//
//  GameListHeadView.swift
//  SnailGame
//
//  Created by Edison on 2020/1/2.
//  Copyright © 2020 DigitalSnail. All rights reserved.
//

import UIKit

typealias GameListHeadBlock = (_ indexPath: IndexPath) ->Void

class GameListHeadView: UIView , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var gameTabCV : UICollectionView?
    
    var selectLine : UIView?
    
    var sections = NSArray.init()
    
    var gameListHeadHandel : GameListHeadBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height-1*PROSIZE, width: self.frame.size.width, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        self.addSubview(line)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        gameTabCV = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: self.frame.size.height), collectionViewLayout: layout)
        gameTabCV?.delegate = self
        gameTabCV?.dataSource = self
        gameTabCV?.showsHorizontalScrollIndicator = false
        gameTabCV?.backgroundColor = UIColor.clear
        self.addSubview(gameTabCV!)
        
        selectLine = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: self.frame.size.height-2*PROSIZE, width: 47*PROSIZE, height: 2*PROSIZE))
        selectLine?.backgroundColor = colorWithHex(hex: 0x2E78FD)
        gameTabCV!.addSubview(selectLine!)

        gameTabCV?.register(GameListHeadCell.self, forCellWithReuseIdentifier: "GameListHeadId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GameListHeadCell = gameTabCV?.dequeueReusableCell(withReuseIdentifier: "GameListHeadId", for: indexPath) as! GameListHeadCell
        let sectionModel = sections[indexPath.item] as! FindListSectionModel
        cell.setGameListHeadCell(sectionModel: sectionModel)
        if sectionModel.isSelect! {
            UIView.animate(withDuration: 0.3) {
                self.selectLine?.center.x = cell.center.x
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionModel = sections[indexPath.item] as! FindListSectionModel
        let size = NSString.calStrSize(textStr: sectionModel.name! as NSString, height: 21*PROSIZE, fontSize: 15*PROSIZE)
        return CGSize.init(width: size.width, height: 30*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameTabCV?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        gameListHeadHandel!(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 20*PROSIZE, bottom: 0, right: 20*PROSIZE)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20*PROSIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20*PROSIZE
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
