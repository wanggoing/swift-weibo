//
//  AppDelegate.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var adLaunch: ADLaunchView?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 创建window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        // 设置根VC
        window?.rootViewController = BaseTabBarController()
        // 显示window
        window?.makeKeyAndVisible()
        
        // 一般情况下设置全局性的属性, 最好放在AppDelegate中设置, 这样可以保证后续所有的操作都是设置之后的操作
        UINavigationBar.appearance().tintColor = UIColor.orange
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.makeKeyAndVisible()
        
        adLaunch = ADLaunchView(frame: UIScreen.main.bounds)
        adLaunch?.delegate = self
        window?.addSubview(adLaunch!)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}
extension AppDelegate: AdLaunchViewDelegate {
    func adLaunchView(_ launchView: ADLaunchView, bannerImageDidClick imageURL: String) {
        let urls = "http://www.baidu.com/"
        if let url: URL = URL(string: urls) {
            UIApplication.shared.openURL(url)
        }
        
    }
}
