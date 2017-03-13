//
//  QRCodeViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/5.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //相机显示视图
    let cameraView = ScannerView(frame: UIScreen.main.bounds)
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 在Swift中一般情况下不用写self, 也不推荐我们写self
        // 一般情况下只有需要区分两个变量, 或者在闭包中访问外界属性才需要加上self
        // 优点可以提醒程序员主动思考当前self会不会形成循环引用
        title = "扫一扫"
        view.backgroundColor = UIColor.white
        setupNavigationItem()
        
        view.addSubview(cameraView)
        // 初始化相机
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let input :AVCaptureDeviceInput
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        do
        {
            // 创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice)
            //把输入流添加到会话
            captureSession.addInput(input)
            //把输出流添加到会话
            captureSession.addOutput(output)
        }
        catch
        {
            // 错误
        }
        // 创建穿行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]) as [AnyObject]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //设置预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        //设置预览图层的frame
        videoPreviewLayer?.frame = cameraView.bounds
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        scannerStart()
    }
    func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
    
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count > 0
        {
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
            {
                print(resultObj.stringValue)
                
                DispatchQueue.main.async(execute: {
                    
                    let result = WebViewController()
                    
                    result.url = resultObj.stringValue
                    
                    self.navigationController?.pushViewController(result, animated: true)
                })
            }
            captureSession.stopRunning()
        }
    }
    // 相册选取代理方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage]
        
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        
        let ciImage = CIImage(data: imageData!)
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        let array = detector?.features(in: ciImage!)
        
        let result : CIQRCodeFeature = array!.first as! CIQRCodeFeature
        
        let resultView = WebViewController()
        resultView.url = result.messageString
        
        self.navigationController?.pushViewController(resultView, animated: true)
        picker.dismiss(animated: true, completion: nil)
        print(result.messageString)
        
        let vc = TitleViewController()
        vc .confirm(title: "扫描结果：", message: result.messageString, controller: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(QRCodeViewController.leftBtnClick(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(QRCodeViewController.photoBtnClick(_:)))
    }
    @objc fileprivate func leftBtnClick(_ btn: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func photoBtnClick(_ btn : UIButton)
    {
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
    }
}
