//
//  BaseViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/12.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var naviView : UIView?;
    
    var slideLine : UIView?
    
    var searchTxtF : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
    }
    
    func initNaviView(bgColor:UIColor) {
        naviView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDE, height: 44+STABAR_HEIGHT))
        naviView?.backgroundColor = bgColor
        self.view.addSubview(naviView!)
    }
    
    func initNaviTitle(titleStr:String,titleColor:UIColor) {
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 60, y: STABAR_HEIGHT, width: SCREEN_WIDE-120, height: 44));
        titleNameLbl.textColor = titleColor;
        titleNameLbl.font = UIFont.systemFont(ofSize: 17);
        titleNameLbl.text = titleStr;
        titleNameLbl.textAlignment = NSTextAlignment.center;
        naviView?.addSubview(titleNameLbl);
    }
    
    func initNaviSearch(hint:String,borderColor:UIColor,delegate:UITextFieldDelegate) {
        let searchBarView = UIView.init(frame: CGRect.init(x: 20*PROSIZE, y: STABAR_HEIGHT+7, width: SCREEN_WIDE-90*PROSIZE, height: 30*PROSIZE))
        searchBarView.layer.borderWidth = 1
        searchBarView.layer.borderColor = borderColor.cgColor
        searchBarView.layer.cornerRadius = 15*PROSIZE
        searchBarView.layer.masksToBounds = true
        naviView?.addSubview(searchBarView)
        
        searchTxtF = UITextField.init(frame: CGRect.init(x: 10*PROSIZE, y: 0, width: searchBarView.frame.size.width-20*PROSIZE, height: 30*PROSIZE))
        searchTxtF?.placeholder = hint
        searchTxtF?.textColor = colorWithHex(hex: 0x333333)
        searchTxtF?.font = UIFont.systemFont(ofSize: 15)
        searchTxtF?.delegate = delegate
        searchBarView.addSubview(searchTxtF!)
    }
    
    func initLeftTitle(titleStr:String) {
        let titleNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: STABAR_HEIGHT, width: 160*PROSIZE, height: 44));
        titleNameLbl.textColor = colorWithHex(hex: 0x333333);
        titleNameLbl.font = UIFont.systemFont(ofSize: 22);
        titleNameLbl.text = titleStr;
        naviView?.addSubview(titleNameLbl);
    }
    
    func initNaviBackBtn(imageStr:String) -> Void {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT, width: 44, height: 44));
        backBtn.setImage(UIImage.init(named: imageStr), for: UIControl.State.normal);
        backBtn.addTarget(self, action: #selector(naviBackAction), for: UIControl.Event.touchUpInside);
        naviView?.addSubview(backBtn);
    }
    
    func initRightImageButton(imageStr:String) {
        let rightImageBtn = UIButton.init(type: UIButton.ButtonType.custom)
        rightImageBtn.frame = CGRect.init(x: SCREEN_WIDE-52*PROSIZE, y: STABAR_HEIGHT, width: 52*PROSIZE, height: 44)
        rightImageBtn.setImage(UIImage.init(named: imageStr), for: UIControl.State.normal)
        rightImageBtn.tag = 50000
        rightImageBtn.addTarget(self, action: #selector(rightImageAction), for: UIControl.Event.touchUpInside)
        naviView?.addSubview(rightImageBtn)
    }
    
    func initRightButton(title:String , titleColor:UIColor) {
        let rightBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
        rightBtn.frame = CGRect.init(x: SCREEN_WIDE-100*PROSIZE, y: STABAR_HEIGHT, width: 80*PROSIZE, height: 44)
        rightBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*PROSIZE)
        rightBtn.setTitleColor(titleColor, for: UIControl.State.normal)
        rightBtn.setTitle(title, for: UIControl.State.normal)
        rightBtn.addTarget(self, action: #selector(rightImageAction), for: UIControl.Event.touchUpInside)
        naviView?.addSubview(rightBtn)
    }
    
    func initNaviTabView(titleList:NSArray,currentIndex:Int) {
        
        for (index,item) in titleList.enumerated() {
            let tabBtn = UIButton.init(type: UIButton.ButtonType.roundedRect)
            tabBtn.frame = CGRect.init(x:(SCREEN_WIDE - 100 * PROSIZE * CGFloat(titleList.count)) / 2 + CGFloat(index) * 100 * PROSIZE, y: STABAR_HEIGHT, width: 100*PROSIZE, height: 44)
            tabBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            tabBtn.setTitle(item as? String, for: UIControl.State.normal)
            if index == currentIndex {
                tabBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            }else{
                tabBtn.setTitleColor(UIColor.init(white: 255/255.0, alpha: 0.5), for: UIControl.State.normal)
            }
            tabBtn.tag = 2000+index
            tabBtn.addTarget(self, action: #selector(tabSelectAction), for: UIControl.Event.touchUpInside)
            naviView?.addSubview(tabBtn)
        }
        
        slideLine = UIView.init(frame: CGRect.init(x: (SCREEN_WIDE - 100 * PROSIZE * CGFloat(titleList.count)) / 2 + CGFloat(currentIndex)*100*PROSIZE + 25*PROSIZE, y: STABAR_HEIGHT+42, width: 50*PROSIZE, height: 2))
        slideLine?.backgroundColor = colorWithHex(hex: 0xffffff)
        naviView?.addSubview(slideLine!)
    }
    
    @objc func naviBackAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func tabSelectAction(sender:UIButton) {
        
    }
    
    @objc func rightImageAction(sender:UIButton) {
        
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
