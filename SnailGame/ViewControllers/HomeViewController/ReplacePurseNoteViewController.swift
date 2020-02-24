//
//  ReplacePurseNoteViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class ReplacePurseNoteViewController: BaseViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var checkBtn , createBtn : UIButton?
    
    var isCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: colorWithHex(hex: 0x333333))
        initNaviTitle(titleStr: "替换钱包", titleColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_white")
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        setUpViews()
    }
    
    @objc func checkAction(sender:UIButton) {
        if isCheck {
            isCheck = false
            checkBtn?.setImage(UIImage.init(named: "ic_register_check_nol"), for: .normal)
            createBtn?.isUserInteractionEnabled = false
            createBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        } else {
            showAlert(currentVC: self, title: "警告", meg: "创建新钱包后，原钱包将不能继续使用，是否继续创建？", cancel: "取消", sure: "确定", cancelHandler: { (action) in
            }) { (action) in
                self.isCheck = true
                self.checkBtn?.setImage(UIImage.init(named: "ic_register_check_sel"), for: .normal)
                self.createBtn?.isUserInteractionEnabled = true
                self.createBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
            }
        }
    }
    
    @objc func createAction(sender:UIButton) {
        let replacePurseVC = ReplacePurseViewController.init()
        self.navigationController?.pushViewController(replacePurseVC, animated: true)
    }
    
    func setUpViews() {
        
        let bottomScrlView = UIScrollView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44-SAFE_BOTTOM-154*PROSIZE))
        self.view.addSubview(bottomScrlView)
    
        let secretTitleLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: 33*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 28*PROSIZE))
        secretTitleLbl.font = UIFont.boldSystemFont(ofSize: 20*PROSIZE)
        secretTitleLbl.textColor = colorWithHex(hex: 0x333333)
        secretTitleLbl.textAlignment = .center
        secretTitleLbl.text = "替换钱包说明"
        bottomScrlView.addSubview(secretTitleLbl)
        
        let descStr = "创建新钱包后，原钱包将不能继续使用，请先将原钱包内资产转出（可存入到大蜗牛社区），创建新钱包后再提出到钱包。\n\n“钱包地址”是您储存数字货币的一串字符，通俗的可以比喻为银行卡的卡号。每个“钱包地址”都对应一个公钥、一个私钥、一组助记词。\n\n公钥和私钥都是一串很长且复杂的字符串（由数字和字母组成），非常不便记忆和操作，所以一般不会显示给用户。（公钥可从区块浏览器公开查看）\n\n助记词是由一组12个单词组成的字符串，相对的它更容易记忆与操作，而且可以唯一匹配钱包地址，所以我们一般就通过助记词来匹配钱包地址，并确认钱包间的交易。获得助记词等于掌控了钱包所有权。所以助记词必须妥善保管，以防被窃或丢失。\n\n当您确认助记词丢失或怀疑有被窃的可能，可重新创建新钱包。"
        
        let secretDescLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: secretTitleLbl.frame.origin.y+secretTitleLbl.frame.size.height+19*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 28*PROSIZE))
        secretDescLbl.font = UIFont.systemFont(ofSize: 16*PROSIZE)
        secretDescLbl.textColor = colorWithHex(hex: 0x333333)
        secretDescLbl.numberOfLines = 0
        secretDescLbl.lineBreakMode = .byWordWrapping
        bottomScrlView.addSubview(secretDescLbl)
        
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: descStr)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:colorWithHex(hex: 0xFF1059), range:NSRange.init(location:0, length: 17))
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, descStr.count))
        secretDescLbl.attributedText = attributedString
        secretDescLbl.sizeToFit()
        
        bottomScrlView.contentSize = CGSize.init(width: SCREEN_WIDE, height: secretDescLbl.frame.origin.y+secretDescLbl.frame.size.height+20*PROSIZE)

        let barView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-154*PROSIZE-SAFE_BOTTOM, width: SCREEN_WIDE, height: 154*PROSIZE+SAFE_BOTTOM))
        barView.backgroundColor = UIColor.white
        self.view.addSubview(barView)
        
        checkBtn = UIButton.init(type: .custom)
        checkBtn?.frame = CGRect.init(x: 20*PROSIZE, y: 32*PROSIZE, width: 24*PROSIZE, height: 24*PROSIZE)
        checkBtn?.setImage(UIImage.init(named: "ic_register_check_nol"), for: .normal)
        checkBtn?.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        barView.addSubview(checkBtn!)
        
        let checkTitleLbl = UILabel.init(frame: CGRect.init(x: 49*PROSIZE, y: 32*PROSIZE, width: 240*PROSIZE, height: 24*PROSIZE))
        checkTitleLbl.font = UIFont.boldSystemFont(ofSize: 14*PROSIZE)
        checkTitleLbl.textColor = colorWithHex(hex: 0x666666)
        checkTitleLbl.text = "确认创建新钱包"
        barView.addSubview(checkTitleLbl)
        
        createBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        createBtn?.frame = CGRect.init(x: 20*PROSIZE, y: 76*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 46*PROSIZE)
        createBtn?.setTitle("创建新钱包", for: UIControl.State.normal)
        createBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        createBtn?.isUserInteractionEnabled = false
        createBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17*PROSIZE)
        createBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
        createBtn?.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        createBtn?.layer.cornerRadius = 5
        createBtn?.layer.masksToBounds = true
        barView.addSubview(createBtn!)
        
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
