//
//  EthRecordDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class EthRecordDetailViewController: BaseViewController {

    var detailView : EthRecordDetailView?
    
    var detailModel : EthRecordDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "详情", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initEthRecordDetailView()
        getDetailValues()
    }
    
    func initEthRecordDetailView() {
        detailView = EthRecordDetailView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 442*PROSIZE))
        self.view.addSubview(detailView!)
    }
    
    func getDetailValues() {
        if detailModel?.status == 1 {
            detailView?.stateNameLbl!.text = "处理中"
        } else if detailModel?.status == 2 {
            detailView?.stateNameLbl!.text = "成功"
        } else {
            detailView?.stateNameLbl!.text = "失败"
        }
        
        if detailModel?.type == 1 {
            detailView?.kindNameLbl?.text = "存入"
            detailView?.dwnAddressTitleLbl?.text = "存入地址"
            detailView?.dwnAddressLbl?.text = detailModel?.wallet_to
            detailView?.addressTitleLbl?.text = "提出地址"
            detailView?.otherAddressLbl?.text = detailModel?.wallet_from
        } else {
            detailView?.kindNameLbl?.text = "提出"
            detailView?.dwnAddressTitleLbl?.text = "提出地址"
            detailView?.dwnAddressLbl?.text = detailModel?.wallet_from
            detailView?.addressTitleLbl?.text = "存入地址"
            detailView?.otherAddressLbl?.text = detailModel?.wallet_to
        }
        
        let eth = KeepSomeDecimal(num: calculateAChuyiB(a: detailModel!.num!, b: ETH_RATIO), decimal: 8)
        let ethAttrStr = NSMutableAttributedString.init(string: eth + "ETH/0.008ETH")
        ethAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0x333333), range:NSRange.init(location:0, length: eth.count+3))
        detailView?.ethNumLbl?.attributedText = ethAttrStr
        detailView?.createTimeLbl?.text = intervalSinceNow(stamp: detailModel!.start_time!)
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
