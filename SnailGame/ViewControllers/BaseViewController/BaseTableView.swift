//
//  BaseTableView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol TableViewRefreshDelegate {
    func tableViewRefreshAction(tableView:UITableView)
}

protocol TableViewLoadMoreDelegate {
    func tableViewLoadMoreAction(tableView:UITableView)
}

class BaseTableView: UITableView {

    var refreshDelegate : TableViewRefreshDelegate?
    
    var loadMoreDelegate : TableViewLoadMoreDelegate?
    
    var pullImages = [UIImage.init(named: "ic_pull_01"),UIImage.init(named: "ic_pull_02"),UIImage.init(named: "ic_pull_03"),UIImage.init(named: "ic_pull_04"),UIImage.init(named: "ic_pull_05"),UIImage.init(named: "ic_pull_06"),UIImage.init(named: "ic_pull_07"),UIImage.init(named: "ic_pull_08"),UIImage.init(named: "ic_pull_09"),UIImage.init(named: "ic_pull_10")]
    
    var refreshImages = [UIImage.init(named: "ic_refresh_01"),UIImage.init(named: "ic_refresh_02"),UIImage.init(named: "ic_refresh_03")]
    
    var nomalImages = [UIImage.init(named: "ic_pull_01")]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        
        if #available(iOS 11.0, *){
            self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        
    }
    
    func setRefreshEnable() {
        let header = MJRefreshGifHeader.init {
            self.refreshDelegate?.tableViewRefreshAction(tableView: self)
        }
        header.lastUpdatedTimeLabel!.isHidden = true
        header.stateLabel!.isHidden = true
        header.setImages(pullImages as [Any], duration: 1, for: .pulling)
        header.setImages(refreshImages as [Any], duration: 0.3, for: .refreshing)
        header.setImages(nomalImages as [Any],  for: .idle)
        self.mj_header = header
    }
    
    func setLoadMoreEnable() {
        self.mj_footer = MJRefreshAutoNormalFooter.init {
            self.loadMoreDelegate?.tableViewLoadMoreAction(tableView: self)
        }
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
