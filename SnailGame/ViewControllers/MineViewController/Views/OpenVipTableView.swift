//
//  OpenVipTableView.swift
//  SnailGame
//
//  Created by Edison on 2019/9/29.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class OpenVipTableView: BaseTableView , UITableViewDelegate , UITableViewDataSource {

    var communityDwn , priceDwn : String?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.delegate = self
        self.dataSource = self;
        
        self.register(OpenVipCell.self, forCellReuseIdentifier: "OpenVipId")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : OpenVipCell = self.dequeueReusableCell(withIdentifier: "OpenVipId", for: indexPath) as! OpenVipCell
        if calculateADayuB(a: priceDwn!, b: communityDwn!) {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if calculateADayuB(a: priceDwn!, b: communityDwn!) {
            return 30*PROSIZE
        }
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
