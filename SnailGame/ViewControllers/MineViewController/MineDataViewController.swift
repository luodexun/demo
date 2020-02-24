//
//  MineDataViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/27.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class MineDataViewController: BaseViewController , TZImagePickerControllerDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataView : MineDataView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviBackBtn(imageStr: "ic_back_nomal")
        initNaviTitle(titleStr: "个人资料", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initMineDataView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userModel = BusinessEngine.init().getLoginUserModel()
        dataView?.portraitImageView?.dwn_setImageView(urlStr: userModel.avatar!, imageName: "")
        dataView?.nickNameLbl?.text = userModel.nickname
    }
    
    func initMineDataView() {
        dataView = MineDataView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44, width: SCREEN_WIDE, height: SCREEN_HEIGHT-STABAR_HEIGHT-44))
        self.view.addSubview(dataView!)
        
        dataView?.portraitBtn?.addTarget(self, action: #selector(portraitAction), for: UIControl.Event.touchUpInside)
        
        dataView?.nickBtn?.addTarget(self, action: #selector(nickAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func portraitAction(sender : UIButton) {
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        imagePickerVC?.modalPresentationStyle = .fullScreen
        imagePickerVC?.allowCrop = true
        imagePickerVC?.allowTakePicture = true
        imagePickerVC?.allowTakeVideo = false
        self.present(imagePickerVC!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        if photos.count != 0 {
            showLoading(view: self.view)
            uploadImage(image: photos[0])
        }
    }
    
    func uploadImage(image:UIImage) {
        let jpegImage : Data = image.jpegData(compressionQuality: 0.5)!
        BusinessEngine.init().uploadImage(data: jpegImage, type: "avatar", successResponse: { (BaseModel) in
            let imageModel : UploadImageModel = BaseModel as! UploadImageModel
            self.updateUserPortrait(avatar: (imageModel.data?.url!)!)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func updateUserPortrait(avatar:String) {
        let param = NSMutableDictionary.init()
        param.setValue(avatar, forKey: "avatar")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
         self.getUserInfo()
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func getUserInfo() {
        BusinessEngine.init().getUserInfo(successResponse: { (BaseModel) in
            self.view.hideToastActivity()
            let userModel : UserLoginModel = BaseModel as! UserLoginModel
            self.dataView?.portraitImageView?.dwn_setImageView(urlStr: (userModel.data?.avatar!)!, imageName: "")
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func nickAction(sender : UIButton) {
        let mineNickVC = MineNickViewController.init()
        mineNickVC.nickName = dataView?.nickNameLbl?.text
        self.navigationController?.pushViewController(mineNickVC, animated: true)
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
