//
//  GameCollectionView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias GameListPushBlock = (_ model:GameDataModel) -> Void

class GameCollectionView: BaseCollectionView ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var gameList : NSMutableArray?
    
    var gameListPushHandel : GameListPushBlock?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        setRefreshEnable()
        self.register(GameCell.self, forCellWithReuseIdentifier: "GameCellId")
        
        gameList = NSMutableArray.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GameCell = self.dequeueReusableCell(withReuseIdentifier: "GameCellId", for: indexPath) as! GameCell
        cell.setGameCell(dataModel: gameList![indexPath.item] as! GameDataModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataModel = gameList![indexPath.item] as! GameDataModel
        let realH = dataModel.cover_size!.height! * (SCREEN_WIDE-40*PROSIZE) / dataModel.cover_size!.width!
        let gameNameSize = NSString.calStrSize(textStr: dataModel.name! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 18*PROSIZE)
        let gameDescSize = NSString.calStrSize(textStr: dataModel.desc! as NSString, width: SCREEN_WIDE-40*PROSIZE, fontSize: 18*PROSIZE)
        return CGSize.init(width: SCREEN_WIDE, height: 66*PROSIZE+realH+gameNameSize.height+gameDescSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataModel = gameList![indexPath.item] as! GameDataModel
        gameListPushHandel!(dataModel)
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
