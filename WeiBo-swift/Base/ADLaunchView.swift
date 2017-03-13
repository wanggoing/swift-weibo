//
//  ADLaunchView.swift
//  WeiBo-swift
//
//  Created by UTOUU on 16/12/14.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

@objc protocol AdLaunchViewDelegate: NSObjectProtocol {
    func adLaunchView(_ launchView: ADLaunchView, bannerImageDidClick imageURL:String)
}

private var width = UIScreen.main.bounds.width
private var height = UIScreen.main.bounds.height

private var adTime: Int = 4
private var sloganHeight : CGFloat = 128

private let hiddenTime : Float = 0.3

final class ADLaunchView: UIView {
    
    weak var delegate: AdLaunchViewDelegate?
    
    // 启动广告背景
    fileprivate lazy var adBackground: UIView = {
        
        var slogan: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
        slogan.frame = UIScreen.main.bounds
        
        var view : UIView = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        view.addSubview(slogan)
        return view
    }()
    
    // 图片链接
    fileprivate var imageURL : String = "http://img.kaiyanapp.com/2af09bd064376353aaadd33d81f99b3a.jpeg?imageMogr2/quality/60/format/jpg"
    
    // 启动页广告
    fileprivate var adImageView : UIImageView?
    
    // 环形进度
    fileprivate var progressView : DACircularProgressView?
    
    // 跳过广告按钮
    fileprivate var progressButtonView: UIButton?
    
    // 定时器
    fileprivate var timer : Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(adBackground)
        
        // 启动广告
        displayCachedAd()
        requestBanner()
        showProgressView()
        
        let delayTime = DispatchTime.now()+Double((Double(adTime)*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.removeFromSuperview()
        }
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: TimeInterval(hiddenTime), animations: {
            self.alpha = 0
        }, completion: { (finished: Bool) in
            super.removeFromSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// private
private extension ADLaunchView {
    
    func displayCachedAd() {
        let manager: SDWebImageManager = SDWebImageManager()
        
        if (manager.imageCache?.imageFromCache(forKey: imageURL)) == nil {
            self.isHidden = true
            return
        }
        showImage()
        stareTimer()
    }
    
    func requestBanner() {
        
        SDWebImageManager.shared().loadImage(with: URL(string: self.imageURL), options: SDWebImageOptions.avoidAutoSetImage, progress: { (receivedSize, expectedSize, targetURL) in
            
            print(receivedSize, expectedSize)
        }) { (image, data, error, cacheType, finished, imageURL) in
            
        }
    }
    
    func showImage() {
        adImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height - sloganHeight))
        
        if let adImageView = adImageView {
            adImageView.sd_setImage(with: URL(string: imageURL))
            adImageView.isUserInteractionEnabled = true
            addSubview(adImageView)
            
            let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ADLaunchView.singTapAction))
            adImageView.addGestureRecognizer(singleTap)
        }
    }
    
    func showProgressView() {
        progressButtonView = UIButton(frame: CGRect(x: width - 60, y: 20, width: 40, height: 40))
        
        if let progressButtonView = progressButtonView {
            progressButtonView.setTitle(String(adTime), for: UIControlState.normal)
            progressButtonView.titleLabel?.textAlignment = .center
            progressButtonView.backgroundColor = UIColor.clear
            progressButtonView.setTitleColor(UIColor.white, for: .normal)
            progressButtonView.addTarget(self, action: #selector(toHiddenState), for: .touchUpInside)
            addSubview(progressButtonView)
        }
        
        progressView = DACircularProgressView(frame: CGRect(x: width - 60, y: 20, width: 40, height: 40))
        progressView?.trackTintColor = UIColor.orange
        
        if let progressView = progressView {
            progressView.isUserInteractionEnabled = false
            progressView.progress = 0
            addSubview(progressView)
            progressView.setProgress(1, animated: true, initialDelay: 0, withDuration: 4)
        }
    }
    
    private func stareTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onProgressButtonTimer), userInfo: nil, repeats: true)
    }
    
    @objc func onProgressButtonTimer() {
        adTime -= 1
        progressButtonView?.setTitle(String(adTime), for: .normal)
        if adTime == 0 {
            timer?.invalidate()
        }
    }
    
    @objc func singTapAction() {
        self.delegate?.adLaunchView(self, bannerImageDidClick: imageURL)
        toHiddenState()
    }
    
    @objc func toHiddenState() {
        UIView.animate(withDuration: TimeInterval(hiddenTime), animations: {
            self.alpha = 0
        }, completion: { (finished: Bool) in
            self.isHidden = true
        })
    }
}


