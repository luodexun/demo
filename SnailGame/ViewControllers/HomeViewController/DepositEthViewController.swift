//
//  DepositEthViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/22.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class DepositEthViewController: BaseViewController {

    var depositSV : DepositEthScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "存入", titleColor: colorWithHex(hex: 0x333333))
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initDepositEthScrollView()
        ethDeposit()
    }
    
    func initDepositEthScrollView() {
        depositSV = DepositEthScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(depositSV!)
        
        depositSV?.savePhotoBtn?.addTarget(self, action: #selector(savePhotoAction), for: .touchUpInside)
        
        depositSV?.coppyAddressBtn?.addTarget(self, action: #selector(coppyAddressAction), for: .touchUpInside)
        
    }
    
    @objc func savePhotoAction(sender:UIButton) {
        UIImageWriteToSavedPhotosAlbum( tailorViewToImage(view: depositSV!.barView!), self, #selector(save(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func coppyAddressAction(sender:UIButton) {
        showTextToast(text: "复制成功", view: self.view)
        UIPasteboard.general.string = depositSV?.addressNameLbl?.text
    }
    
    func ethDeposit() {
        BusinessEngine.init().ethDeposit(currency: "ETH", successResponse: { (baseModel) in
            let depositModel:DepositEthModel = baseModel as! DepositEthModel
            self.createQrcodeImg(address: depositModel.data!.public_address!)
        }) { (baseModel) in
            showTextToast(text: baseModel.message!, view: self.view)
        }
    }
    
    func createQrcodeImg(address:String) {
        let image = setupQRCodeImage(text: address)
        depositSV?.qrCodeImageView?.image = image
        depositSV?.addressNameLbl?.text = address
    }
    
    @objc func save(image:UIImage, didFinishSavingWithError:NSError?,contextInfo:AnyObject) {
        if didFinishSavingWithError != nil {
            showTextToast(text: "保存失败", view: self.view)
        } else {
            showTextToast(text: "保存成功", view: self.view)
        }
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
