//
//  OpenVipViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class OpenVipViewController: BaseViewController {

    var openVipTV : OpenVipTableView?
    
    var openVipHV : OpenVipHeadView?
    
    var openVipFV : OpenVipFootView?
    
    var infoModel : VipInfoDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "蜗牛VIP", titleColor: colorWithHex(hex: 0x333333))
        initOpenVipTableView()
        getVipValues()
    }
    
    func initOpenVipTableView() {
        
        openVipTV = OpenVipTableView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44), style: UITableView.Style.plain)
        self.view.addSubview(openVipTV!)
        
        openVipHV = OpenVipHeadView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 277*PROSIZE))
        self.openVipTV?.tableHeaderView = openVipHV
        
        openVipFV = OpenVipFootView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 275*PROSIZE))
        self.openVipTV?.tableFooterView = openVipFV
        
        openVipFV?.payBtn?.addTarget(self, action: #selector(payAction), for: UIControl.Event.touchUpInside)
        
        openVipFV?.connectBtn?.addTarget(self, action: #selector(connectAction), for: .touchUpInside)
        
    }
    
    func getVipValues() {
        let priceStr = KeepSomeDecimal(num: calculateAChuyiB(a: infoModel!.price!, b: TOKEN_RATIO), decimal: 2)
        let priceShowStr = priceStr + " DWN/年"
        let priceSize = NSString.calStrSize(textStr: priceShowStr as NSString, height: 23*PROSIZE, fontSize: 24*PROSIZE)
        openVipHV?.vipPriceLbl?.frame.size.width = priceSize.width
        let priceAttrStr = NSMutableAttributedString.init(string: priceShowStr)
        priceAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xFF0F59), range:NSRange.init(location:0, length: priceStr.count))
        openVipHV?.vipPriceLbl?.attributedText = priceAttrStr
        openVipHV?.offersLbl?.frame.origin.x = (openVipHV?.vipPriceLbl!.frame.origin.x)!+(openVipHV?.vipPriceLbl!.frame.size.width)!+7*PROSIZE
    
        let originalPriceStr = KeepSomeDecimal(num: calculateAChuyiB(a: infoModel!.price_old!, b: TOKEN_RATIO), decimal: 2) + " DWN/年"
        let originalAttrStr = NSMutableAttributedString.init(string: originalPriceStr)
        originalAttrStr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber.init(value: 1), range:NSRange.init(location:0, length: originalAttrStr.length))
        openVipHV?.originalPriceLbl?.attributedText = originalAttrStr
        
        let communityDwn = KeepSomeDecimal(num: calculateAChuyiB(a: BusinessEngine.init().getLoginUserModel().token!, b: TOKEN_RATIO), decimal: 2)
        openVipHV?.communityDwnLbl?.text = "可用：" + communityDwn
        if calculateADayuB(a: priceStr, b: communityDwn) {
            openVipHV?.communityImageView?.image = UIImage.init(named: "ic_open_vip_nol")
            openVipHV?.communityTitleName?.textColor = colorWithHex(hex: 0x999999)
            openVipFV?.payBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
            openVipFV?.payBtn?.isUserInteractionEnabled = false
        } else {
            openVipHV?.communityImageView?.image = UIImage.init(named: "ic_open_vip_sel")
            openVipHV?.communityTitleName?.textColor = colorWithHex(hex: 0x333333)
            openVipFV?.payBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
            openVipFV?.payBtn?.isUserInteractionEnabled = true
        }
        openVipTV?.priceDwn = priceStr
        openVipTV?.communityDwn = communityDwn
        openVipTV?.reloadData()
    }
    
    @objc func payAction(sender:UIButton) {
        let payDialog : VipPayDialog = VipPayDialog.init()
        payDialog.show()
        payDialog.vipPayHandel = {
            self.getUserInfo()
        }
    }
    
    @objc func connectAction(sender:UIButton) {
        let customerServiceVC = CustomerServiceViewController.init()
        self.navigationController?.pushViewController(customerServiceVC, animated: true)
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            let vipDetailVC = VipDetailViewController.init()
            self.navigationController?.pushViewController(vipDetailVC, animated: true)
            self.removeToRootVeiw()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func removeToRootVeiw() {
        
        let array = NSMutableArray.init()
        for (index,item) in self.navigationController!.viewControllers.enumerated() {
            if index == 0 {
                array.add(item)
            }
            else if index == self.navigationController!.viewControllers.count-1 {
                array.add(item)
            }
        }
        self.navigationController?.viewControllers = array as! [UIViewController]
    }
    
    override func naviBackAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
