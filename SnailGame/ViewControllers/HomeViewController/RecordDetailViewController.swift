//
//  RecordDetailViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/10.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RecordDetailViewController: BaseViewController {

    var dataModel : TradeRecordDataModel?
    
    var detailView : RecordDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "交易详情", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initRecordDetailView()
        setRecoedValues()
    }
    
    func initRecordDetailView() {
        detailView = RecordDetailView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(detailView!)
        detailView?.coppyBtn?.addTarget(self, action: #selector(coppyAction), for: .touchUpInside)
    }
    
    func setRecoedValues() {
        let userModel = BusinessEngine.init().getLoginUserModel()
        
        if dataModel?.sender == userModel.wallet_address {
            detailView?.tradIcon?.image = UIImage.init(named: "ic_wallet_detail_out")
            detailView?.tradNameLbl?.text = "转出"
            let amountStr = "-" + KeepSomeDecimal(num: calculateAChuyiB(a: String(dataModel!.amount! + dataModel!.fee!), b: TOKEN_RATIO), decimal: 2)
            let attributedStr = NSMutableAttributedString.init(string: amountStr+"DWN")
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 30*PROSIZE), range: NSRange.init(location: 0, length: amountStr.count))
            attributedStr.addAttribute(.foregroundColor, value: colorWithHex(hex: 0x333333), range: NSRange.init(location: 0, length: amountStr.count))
            detailView?.tradDwnLbl?.attributedText = attributedStr
            detailView?.walletAddressLbl?.text = dataModel?.recipient
        } else {
            detailView?.tradIcon?.image = UIImage.init(named: "ic_wallet_detail_in")
            detailView?.tradNameLbl?.text = "收入"
            let amountStr = "+" + KeepSomeDecimal(num: calculateAChuyiB(a: String(dataModel!.amount!), b: TOKEN_RATIO), decimal: 2)
            let attributedStr = NSMutableAttributedString.init(string: amountStr+"DWN")
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 30*PROSIZE), range: NSRange.init(location: 0, length: amountStr.count))
            attributedStr.addAttribute(.foregroundColor, value: colorWithHex(hex: 0xff7700), range: NSRange.init(location: 0, length: amountStr.count))
            detailView?.tradDwnLbl?.attributedText = attributedStr
            detailView?.walletAddressLbl?.text = dataModel?.recipient
        }
        detailView?.createTimeLbl?.text = changeDateToTime(dateStr: (dataModel?.timestamp!.human)!)
        detailView?.noteContentLbl?.text = (dataModel?.vendorField == nil) ? "--" : dataModel?.vendorField
        detailView?.tradIdLbl?.text = dataModel?.id
    }
    
    @objc func coppyAction(sender:UIButton) {
        showTextToast(text: "复制成功", view: self.view)
        UIPasteboard.general.string = detailView?.walletAddressLbl?.text
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
