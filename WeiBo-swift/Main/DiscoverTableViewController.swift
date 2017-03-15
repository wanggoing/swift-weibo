//
//  DiscoverTableViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let rid = "reuseIdentifier";
//        var cell = tableView.dequeueReusableCell(withIdentifier: rid)
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: rid)
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 数据

extension DiscoverTableViewController {
    
}

// MARK: - 自定义TableViewCell
class CustTableViewCell: UITableViewCell {
    
    lazy var titleImage = UIImageView()
    lazy var title = UILabel()
    lazy var subTitle = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        initUI()
    }
    
    private func initUI() {
        
        contentView.addSubview(titleImage)
        contentView.addSubview(title)
        contentView.addSubview(subTitle)
        
        titleImage.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(self.contentView)
            ConstraintMaker.right.equalTo(self.contentView)
            ConstraintMaker.top.equalTo(self.contentView)
            ConstraintMaker.bottom.equalTo(self.contentView)
        }
        
        title.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalTo(self.contentView).offset(-15)
            ConstraintMaker.centerX.equalTo(self.contentView)
        }
        
        subTitle.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(self.contentView)
            ConstraintMaker.centerY.equalTo(self.contentView).offset(5)
        }
    }
    
    func fillCellData(imgName:String, titleString:String, subTitleString:String) {
        
        title.text = titleString
        subTitle.text = subTitleString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
