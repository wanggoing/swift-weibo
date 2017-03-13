//
//  MainViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(composeButton)
        
        // 保存按钮尺寸
        let rect = composeButton.frame
        // 计算宽度
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        // 设置按钮的位置
        composeButton.frame = CGRect(x: 2 * width, y: 0, width: width, height: rect.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iOS7以后只需要设置tintColor, 那么图片和文字都会按照tintColor渲染
        tabBar.tintColor = UIColor.orange
        // 添加子控制器
        addChildViewControllers()
    }
    
    /// 添加所有子控制器
    func addChildViewControllers ()
    {
        addChildViewController(childController: HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(childController: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childController: PublishViewController(), title: "", imageName: "")
        addChildViewController(childController: DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childController: ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    /// 添加一个子控制器
    func addChildViewController(childController: UIViewController, title: String, imageName: String)
    {
        // 设置自控制的相关属性
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 包装一个导航控制器
        let nav = UINavigationController(rootViewController: childController)
        // 将子控制器添加到UITabBarController中
        addChildViewController(nav)
    }
    
    func addChildViewControllerNamed(_ childControllerName: String, title : String, imageName : String)
    {
        // guard 条件表达式 需要执行的语句 else 只有条件未假才会执行{}中内容
        // return
        // guard 可以有效的解决可选绑定容易形成{}嵌套问题
        
        // 动态命名空间
        guard let name =  Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else
        {
            NSLog("获取命名空间失败")
            return
        }
        
        /*
         Swift中新增了一个叫做命名空间的概念
         作用: 避免重复
         不用项目中的命名空间是不一样的, 默认情况下命名空间的名称就是当前项目的名称
         正是因为Swift可以通过命名空间来解决重名的问题, 所以在做Swift开发时尽量使用cocoapods来集成三方框架, 这样可以有效的避免类名重复
         正是因为Swift中有命名空间, 所以通过一个字符串来创建一个类和OC中也不太一样了, OC中可以直接通过类名创建一个类, 而Swift中如果想通过类名来创建一个类必须加上命名空间
         */
        
        // 由于字典/数组中只能存储对象, 所以通过一个key从字典中获取值取出来是一个AnyObject类型, 并且如果key写错或者没有对应的值, 那么就取不到值, 所以返回值可能有值也可能没值, 所以最终的类型是AnyObject?
        
        let cls : AnyClass? = NSClassFromString(name + "." + childControllerName)
        
        guard let typeCls = cls as? UITableViewController.Type else {
            // cls不能当做UITableViewController
            return
        }
        let childController = typeCls.init()
        
        // 设置自控制的相关属性
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 包装一个导航控制器
        let nav = UINavigationController(rootViewController: childController)
        // 将子控制器添加到UITabBarController中
        addChildViewController(nav)
    }
    
    fileprivate lazy var composeButton : UIButton_Extension = {
        () -> UIButton_Extension
        in
        
        let btn = UIButton_Extension.init(imageName: "", backgroundImageName: "")
        btn.addTarget(self, action: #selector(BaseTabBarController.compseBtnClick(_:)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    /// 监听加号按钮点击
    @objc fileprivate func compseBtnClick(_ btn: UIButton)
    {
        self.present(PublishViewController(), animated: true, completion: nil);
    }
}
