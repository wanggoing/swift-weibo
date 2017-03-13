//
//  VisitorView.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    // 背景
    let backgroundView = UIImageView()
    // 注册按钮
    let registerButton = UIButton()
    // 登录按钮
    let loginButton = UIButton()
    // 转盘
    let rotationImageView = UIImageView()
    // 图标
    let iconImageView = UIImageView()
    // 文本标签
    let titleLabel = UILabel()
    
    class func visitorView() -> VisitorView {
        
        return self.init()
    }
    
    func setupVisitorInfo(_ imageName: String?, title: String)
    {
        rotationImageView.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        self.addSubview(rotationImageView)
        
        backgroundView.image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        self.addSubview(backgroundView)
        
        iconImageView.image = UIImage.init(named: "visitordiscover_feed_image_house")
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        
        self.addSubview(initButton(button: registerButton, btnTitle: "注册"))
        self.addSubview(initButton(button: loginButton, btnTitle: "登陆"))
        
        // 1.设置标题
        titleLabel.text = title
        titleLabel.textColor = UIColor.lightGray
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        
        // 布局
        maskLayout()
        
        // 2.判断是否是首页
        guard let name = imageName else
        {
            // 没有设置图标, 首页
            // 执行转盘动画
            startAniamtion()
            return
        }
        
        // 3.设置其他数据
        // 不是首页
        rotationImageView.isHidden = true
        iconImageView.image = UIImage(named: name)
    }
    
    private func initButton(button : UIButton, btnTitle : String) -> UIButton {
        
        let color = (button == loginButton) ? UIColor.orange : UIColor.black
        
        button.setTitle(btnTitle, for: UIControlState.normal)
        button.setTitleColor(color, for: UIControlState.normal)
        button.layer.borderColor = color.cgColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return button;
    }
    
    private func maskLayout() {
        
        rotationImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        backgroundView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.equalTo(iconImageView).offset(-500)
            make.bottom.equalTo(self).offset(0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(iconImageView).offset(150)
            make.width.lessThanOrEqualTo(self).offset(-100)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(rotationImageView)
            make.top.equalTo(titleLabel).offset(50)
            make.width.equalTo(45)
        }
        
        loginButton.snp.makeConstraints { (make
            ) in
            make.right.equalTo(rotationImageView)
            make.top.equalTo(titleLabel).offset(50)
            make.width.equalTo(45)
        }
    }
    /// 转盘旋转动画
    fileprivate func startAniamtion()
    {
        // 1.创建动画
        let anim =  CABasicAnimation(keyPath: "transform.rotation")
        
        // 2.设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        // 注意: 默认情况下只要视图消失, 系统就会自动移除动画
        // 只要设置removedOnCompletion为false, 系统就不会移除动画
        anim.isRemovedOnCompletion = false
        
        // 3.将动画添加到图层上
        rotationImageView.layer.add(anim, forKey: nil)
    }
}
