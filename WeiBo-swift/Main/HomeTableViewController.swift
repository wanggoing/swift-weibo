//
//  HomeTableViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVisitorView()
        
        // 1.判断用户是否登录
        if !isLogin
        {
            // 设置访客视图
            visitorView?.setupVisitorInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
    }
    
    fileprivate func setUpVisitorView ()
    {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.registerBtnClick(_:)))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.loginBtnClick(_:)))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem_Extension.init(imageName: "navigationbar_friendattention", target: self, action: #selector(HomeTableViewController.leftBtnClick(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem_Extension.init(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightBtnClick(_:)))
    }
    
    /// 监听按钮点击
    @objc fileprivate func leftBtnClick(_ btn: UIButton)
    {
        
    }
    
    @objc fileprivate func rightBtnClick(_ btn: UIButton)
    {
        let nav = UINavigationController(rootViewController : QRCodeViewController())
        present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
