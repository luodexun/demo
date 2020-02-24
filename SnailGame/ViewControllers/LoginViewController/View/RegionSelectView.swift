//
//  RegionSelectView.swift
//  SnailGame
//
//  Created by Edison on 2019/10/10.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

typealias RegionSelectBlock = (_ name:String,_ code:String) -> Void

class RegionSelectView: UIView , UITableViewDelegate , UITableViewDataSource {

    var coverView , contentView : UIView?
    
    var regionTV : UITableView?
    
    var regionList : NSArray?
    
    var regionSelectHandel : RegionSelectBlock?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    func setupView() {
        coverView = UIView.init(frame: self.bounds)
        coverView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        addSubview(coverView!)
        
        let coverTap = UITapGestureRecognizer.init(target: self, action: #selector(coverClose))
        coverView?.addGestureRecognizer(coverTap)
        
        contentView = UIView.init(frame: CGRect.init(x: 0, y: frame.height, width: frame.width, height: 250*PROSIZE))
        contentView?.backgroundColor = UIColor.white
        addSubview(contentView!)
        
        let nameTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 15*PROSIZE, width: 160*PROSIZE, height: 20*PROSIZE))
        nameTitleLbl.text = "国家和地区"
        nameTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        nameTitleLbl.textColor = colorWithHex(hex: 0x999999)
        contentView?.addSubview(nameTitleLbl)
        
        let codeTitleLbl = UILabel.init(frame: CGRect.init(x: (contentView?.frame.size.width)!-180*PROSIZE, y: 15*PROSIZE, width: 160*PROSIZE, height: 20*PROSIZE))
        codeTitleLbl.text = "电话区号"
        codeTitleLbl.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        codeTitleLbl.textColor = colorWithHex(hex: 0x999999)
        codeTitleLbl.textAlignment = NSTextAlignment.right
        contentView?.addSubview(codeTitleLbl)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 49*PROSIZE, width: (contentView?.frame.size.width)!, height: 1*PROSIZE))
        line.backgroundColor = colorWithHex(hex: 0xeeeeee)
        contentView?.addSubview(line)
        
        regionTV = UITableView.init(frame: CGRect.init(x: 0, y: 50*PROSIZE, width: (contentView?.frame.size.width)!, height: 200*PROSIZE), style: UITableView.Style.plain)
        regionTV?.separatorStyle = UITableViewCell.SeparatorStyle.none
        regionTV?.backgroundColor = UIColor.white
        regionTV?.delegate = self
        regionTV?.dataSource = self
        contentView?.addSubview(regionTV!)
        
        regionTV?.register(RegionSelectCell.self, forCellReuseIdentifier: "RegionSelectId")
        
        let str = UserDefaults.standard.string(forKey: GAMECONFIG)
        let configModel = ConfigModel.deserialize(from: str)
        regionList = configModel?.region as NSArray?

    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView?.alpha = 1.0
            self.contentView?.transform = CGAffineTransform.init(translationX: 0, y: -(self.contentView?.bounds.height)!)
        }, completion: nil)
    }
    
    func close() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView?.alpha = 0.0
            self.contentView?.transform = CGAffineTransform.identity
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc func coverClose(tap:UIGestureRecognizer) {
        close()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RegionSelectCell = tableView.dequeueReusableCell(withIdentifier: "RegionSelectId", for: indexPath) as! RegionSelectCell
        let regionModel:ConfigRegionModel = regionList![indexPath.row] as! ConfigRegionModel
        cell.regionNameLbl?.text = regionModel.name
        cell.regionCodeLbl?.text = "+" + String(regionModel.code!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*PROSIZE
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let regionModel:ConfigRegionModel = regionList![indexPath.row] as! ConfigRegionModel
        regionSelectHandel!(regionModel.name!,String(regionModel.code!))
        close()
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
