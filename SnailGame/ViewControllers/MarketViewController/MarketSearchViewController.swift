//
//  MarketSearchViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/12/4.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MarketSearchViewController: BaseViewController , UITextFieldDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var marketSearchCV : MarketCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviSearch(hint: "输入名称关键字", borderColor: colorWithHex(hex: 0x0077FF), delegate: self)
        initRightButton(title: "取消", titleColor: colorWithHex(hex: 0x666666))
        self.searchTxtF?.addTarget(self, action: #selector(searchTextChange), for: .editingChanged)
        initMarketCollectionView()
    }
    
    func initMarketCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        marketSearchCV = MarketCollectionView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44), collectionViewLayout: layout)
        marketSearchCV?.mj_header!.isHidden = true
        self.view.addSubview(marketSearchCV!)
        marketSearchCV?.marketPushHandel = {(dataModel) in
            let detailVC = InfoDetailViewController.init()
            detailVC.pushType = 2
            detailVC.marketModel = dataModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func searchTextChange(txtF:UITextField) {
        if searchTxtF?.text?.count != 0 {
            marketSearch(wordKey: searchTxtF!.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxtF?.resignFirstResponder()
        return true
    }
    
    func marketSearch(wordKey:String) {
        BusinessEngine.init().marketSearch(keyword: wordKey, successResponse: { (baseModel) in
            let marketModel:MarketListModel = baseModel as! MarketListModel
            if marketModel.data?.count != 0 {
                self.marketSearchCV?.isHidden = false
                self.marketSearchCV?.marketList = NSMutableArray.init(array: marketModel.data!)
                self.marketSearchCV?.reloadData()
            } else {
                self.marketSearchCV?.isHidden = true
            }
        }) { (baseModel) in
        }
    }
    
    override func rightImageAction(sender: UIButton) {
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
