//
//  GameAboutViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/17.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class GameAboutViewController: BaseViewController {

    var gameName , gameDesc , gameIcon : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_login")
        initViews()
    }
    
    func initViews() {
        
        let gameImageView = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDE-60*PROSIZE)/2, y: STABAR_HEIGHT+44+10*PROSIZE, width: 60*PROSIZE, height: 60*PROSIZE))
        gameImageView.dwn_setImageView(urlStr: gameIcon!, imageName: "")
        self.view.addSubview(gameImageView)
        
        let gameNameLbl = UILabel.init(frame: CGRect.init(x: 20*PROSIZE, y: gameImageView.frame.origin.y+gameImageView.frame.size.height+10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: 20*PROSIZE))
        gameNameLbl.textColor = colorWithHex(hex: 0x333333)
        gameNameLbl.textAlignment = .center
        gameNameLbl.font = UIFont.systemFont(ofSize: 18*PROSIZE)
        gameNameLbl.text = gameName
        self.view.addSubview(gameNameLbl)
        
        let gameDescView = WKWebView.init(frame: CGRect.init(x: 20*PROSIZE, y: gameNameLbl.frame.origin.y+gameNameLbl.frame.size.height+10*PROSIZE, width: SCREEN_WIDE-40*PROSIZE, height: SCREEN_HEIGHT-gameNameLbl.frame.origin.y-gameNameLbl.frame.size.height-10*PROSIZE))
        gameDescView.sizeToFit()
        gameDescView.loadHTMLString(gameDesc!, baseURL: nil)
        self.view.addSubview(gameDescView)
        
        for (_,subview) in gameDescView.subviews.enumerated() {
            if subview.isKind(of: UIScrollView.self) {
                let view:UIScrollView = subview as! UIScrollView
                view.bounces = false
            }
        }
        
        
    }
    
    override func naviBackAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
