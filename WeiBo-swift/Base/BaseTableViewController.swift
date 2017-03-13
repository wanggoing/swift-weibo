//
//  BaseTableViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    /// 定义标记记录用户登录状态
    var isLogin = false
    
    /// 访客视图
    var visitorView: VisitorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 判断用户是否登录, 如果没有登录就显示访客界面, 如果已经登录就显示tableview
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    fileprivate func setupVisitorView() {
        visitorView = VisitorView.visitorView()
        view = visitorView
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
