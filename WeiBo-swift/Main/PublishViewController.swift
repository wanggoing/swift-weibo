//
//  PublishViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/4.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    
    let closeBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        addCloseBtn()
    }
    
    func addCloseBtn() {
        
        closeBtn.backgroundColor = UIColor.lightGray
        closeBtn.setTitle("close", for: .normal)
        closeBtn.setTitleColor(UIColor.white, for: .normal)
        closeBtn.addTarget(self, action: #selector(onCloseBtn), for: .touchUpInside)
        view.addSubview(closeBtn)
        
        closeBtn.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(view)
            ConstraintMaker.bottom.equalTo(view)
            ConstraintMaker.right.equalTo(view)
            ConstraintMaker.height.equalTo(49)
        }
    }
    
    @objc func onCloseBtn () {
        dismiss(animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
