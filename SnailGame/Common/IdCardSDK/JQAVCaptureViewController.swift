//
//  JQAVCaptureViewController.swift
//  SnailGame
//
//  Created by Edison on 2019/11/20.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol JQAVCaptureDelegate {
    func JQAVCaptureScanBack(info:IDInfo,subImage:UIImage)
}

class JQAVCaptureViewController: BaseViewController , AVCaptureVideoDataOutputSampleBufferDelegate , AVCaptureMetadataOutputObjectsDelegate {

    var jqDelegate : JQAVCaptureDelegate?
    
    // 摄像头设备
    lazy var device : AVCaptureDevice = {
        
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        try! device!.lockForConfiguration()
        
        // 平滑对焦
        if device!.isSmoothAutoFocusSupported {
            device?.isSmoothAutoFocusEnabled = true
        }
        // 自动持续对焦
        if (device?.isFocusModeSupported(AVCaptureDevice.FocusMode.continuousAutoFocus))! {
            device?.focusMode = AVCaptureDevice.FocusMode.continuousAutoFocus
        }
        //自动持续曝光
        if (device?.isExposureModeSupported(AVCaptureDevice.ExposureMode.continuousAutoExposure))! {
            device?.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
        }
        
        // 自动持续白平衡
        if (device?.isWhiteBalanceModeSupported(AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance))! {
            device?.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance
        }
        device?.unlockForConfiguration()
        
        return device!
    }()
    
    // 队列
    lazy var queue : DispatchQueue = {
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        return queue
    }()

     // 输出格式
    lazy var outPutSetting : NSNumber = {
        let outPutSetting = kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
        return NSNumber(value: outPutSetting)
    }()
    
    // 元数据（用于人脸识别）
    lazy var metadataOutput : AVCaptureMetadataOutput = {
        let metadataOutput = AVCaptureMetadataOutput.init()
        metadataOutput.setMetadataObjectsDelegate(self, queue: queue)
        return metadataOutput
    }()
    
    
    // 出流对象
    lazy var videoDataOutput : AVCaptureVideoDataOutput = {
        let videoDataOutput = AVCaptureVideoDataOutput.init()
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String:outPutSetting]
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        return videoDataOutput
    }()
    
    // AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
    lazy var session : AVCaptureSession = {
        let session = AVCaptureSession.init()
        session.sessionPreset = AVCaptureSession.Preset.high
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            showTextToast(text: "没有摄像头", view: self.view)
            return session
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.face]
        }
        return session
    }()
    
    // 预览图层
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
        previewLayer.frame = self.view.frame
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return previewLayer
    }()
    
    // session开始，即输入设备和输出设备开始数据传递
    func runSession() {
        if !session.isRunning {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.session.startRunning()
            }
        }
    }
    
    // session停止，即输入设备和输出设备结束数据传递
    func stopSession() {
        if session.isRunning {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.session.stopRunning()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAuthorizationStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        
        let ret = ArkDwnWallet.initializeIdCard()
        if ret != 0 {
            print("初始化失败")
        }
        // 添加预览图层
        self.view.layer.addSublayer(previewLayer)
        
        // 添加自定义的扫描界面（中间有一个镂空窗口和来回移动的扫描线）
        let scaningView = JQIDCardScaningView.init(frame: self.view.frame)
        self.view.addSubview(scaningView)
        
        metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scaningView.facePathRect!)
        
        addCloseButton()
        
    }
    
    func addCloseButton() {
        let closeBtn = UIButton.init(type: UIButton.ButtonType.custom)
        closeBtn.frame = CGRect.init(x: SCREEN_WIDE-60*PROSIZE, y: SCREEN_HEIGHT-60*PROSIZE-SAFE_BOTTOM, width: 40*PROSIZE, height: 40*PROSIZE)
        closeBtn.setImage(UIImage.init(named: "icon_idcard_back"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.view.addSubview(closeBtn)
    }
    
    @objc func closeAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkAuthorizationStatus() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizationStatus {
        case .notDetermined:
            showAuthorizationNotDetermined()
            break
        case .authorized:
            runSession()
            break
        case .denied:
            showAuthorizationDenied()
            break
        case .restricted:
            showTextToast(text: "无法访问相机设备", view: self.view)
            break
        default:
            break
        }
    }
    
    func showAuthorizationNotDetermined() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            if granted {
                self.runSession()
            } else {
                self.showAuthorizationDenied()
            }
        }
    }
    
    func showAuthorizationDenied() {
        showAlert(currentVC: self, title: "相机未授权", meg: "请到系统的“设置-隐私-相机”中授权此应用使用您的相机", cancel: "取消", sure: "去设置", cancelHandler: { (action) in
        }) { (action) in
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options:[:], completionHandler: nil)
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if outPutSetting.isEqual(to: NSNumber.init(value: kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)) || outPutSetting.isEqual(to: NSNumber.init(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)) {
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            if output.isEqual(videoDataOutput) {
                let dict = ArkDwnWallet.idCardBackRecognit(imageBuffer! , with: session)
                if dict != nil {
                    let width = CVPixelBufferGetWidth(imageBuffer!)
                    let height = CVPixelBufferGetHeight(imageBuffer!)
                    let effectRect = getEffectImageRect(size: CGSize.init(width: width, height: height))
                    let rect = getGuideFrame(rect: effectRect)
                    let image = getImageStream(imageBuffer: imageBuffer!)
                    let subImage = getSubImage(rect: rect, image: image)
                    let infoDic:NSDictionary = dict! as NSDictionary
                    let info = IDInfo.deserialize(from: infoDic)
                    DispatchQueue.main.async {
                        self.jqDelegate?.JQAVCaptureScanBack(info: info!, subImage: subImage)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            print("输出格式不支持")
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
