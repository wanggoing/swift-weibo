//
//  UIBarButtonItem+Extension.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/4.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class UIBarButtonItem_Extension: UIBarButtonItem
{
    // 1.用于快速创建一个对象
    // 2.依赖于指定构造方法
    convenience init(imageName: String, target: AnyObject?, action: Selector)
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.init(customView: btn)
    }
}
