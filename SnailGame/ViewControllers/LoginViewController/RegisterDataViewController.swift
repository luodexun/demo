//
//  RegisterDataViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/9/23.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

class RegisterDataViewController: BaseViewController , TZImagePickerControllerDelegate {

    var registerDataView : RegisterDataView?
    
    var imageUrl : String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviView(bgColor: UIColor.white)
        initNaviTitle(titleStr: "个人资料", titleColor: colorWithHex(hex: 0x333333))
        self.view.backgroundColor = colorWithHex(hex: 0xf4f4f4)
        initRegisterDataView()
    }
    
    func initRegisterDataView() {
        registerDataView = RegisterDataView.init(frame: CGRect.init(x: 0, y: STABAR_HEIGHT+44+10*PROSIZE, width: SCREEN_WIDE, height: 393*PROSIZE))
        self.view.addSubview(registerDataView!)
        
        registerDataView?.addPortaritBtn?.addTarget(self, action: #selector(addPortaritAction), for: UIControl.Event.touchUpInside)
        
        registerDataView?.nickNameTxtF?.addTarget(self, action: #selector(registerTextChange), for: UIControl.Event.editingChanged)
        
        registerDataView?.nextStepBtn?.addTarget(self, action: #selector(nextStepAction), for: UIControl.Event.touchUpInside)
        
        registerDataView?.waitSubmitBtn?.addTarget(self, action: #selector(waitSubmitAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func addPortaritAction(sender:UIButton) {
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        imagePickerVC?.allowCrop = true
        imagePickerVC?.allowTakePicture = true
        imagePickerVC?.allowTakeVideo = false
        imagePickerVC?.modalPresentationStyle = .fullScreen
        self.present(imagePickerVC!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        if photos.count != 0 {
            uploadImage(image: photos[0])
        }
    }
    
    func uploadImage(image:UIImage) {
        let jpegImage : Data = image.jpegData(compressionQuality: 0.5)!
        BusinessEngine.init().uploadImage(data: jpegImage, type: "avatar", successResponse: { (BaseModel) in
            let imageModel : UploadImageModel = BaseModel as! UploadImageModel
            self.updateUserPortrait(avatar: (imageModel.data?.url!)!)
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    func updateUserPortrait(avatar:String) {
        let param = NSMutableDictionary.init()
        param.setValue(avatar, forKey: "avatar")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
            self.registerDataView?.portraitbarView?.isHidden = true
            self.registerDataView?.portraitImageView?.isHidden = false
            self.registerDataView?.portraitImageView?.dwn_setImageView(urlStr: avatar, imageName: "")
            self.imageUrl = avatar
        }) { (BaseModel) in
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func nextStepAction(sender:UIButton) {
        if imageUrl?.count == 0 {
            showTextToast(text: "请选择头像", view: self.view)
            return
        }
        showLoading(view: self.view)
        let param = NSMutableDictionary.init()
        param.setValue(registerDataView?.nickNameTxtF?.text, forKey: "nickname")
        BusinessEngine.init().updateUserData(params: param, successResponse: { (BaseModel) in
            let registerPayVC = RegisterPayViewController.init()
            self.navigationController?.pushViewController(registerPayVC, animated: true)
        }) { (BaseModel) in
            self.view.hideToastActivity()
            showTextToast(text: BaseModel.message!, view: self.view)
        }
    }
    
    @objc func waitSubmitAction(sender:UIButton) {
        let registerPayVC = RegisterPayViewController.init()
        self.navigationController?.pushViewController(registerPayVC, animated: true)
    }
    
    @objc func registerTextChange(sender:UIButton) {
        if registerDataView?.nickNameTxtF?.text?.count != 0 {
            registerDataView?.nextStepBtn?.isUserInteractionEnabled = true
            registerDataView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0x0077FF)
        }else {
            registerDataView?.nextStepBtn?.isUserInteractionEnabled = false
            registerDataView?.nextStepBtn?.backgroundColor = colorWithHex(hex: 0xcccccc)
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
