//
//  TitleViewController.swift
//  WeiBo-swift
//
//  Created by UTOUU on 16/12/9.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    func confirm(title:String?,message:String?,controller:UIViewController,handler: ( (UIAlertAction) -> Swift.Void)? = nil)
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let entureAction = UIAlertAction(title: "确定", style: .destructive, handler: handler)
        
        alertVC.addAction(entureAction)
        
        controller.present(alertVC, animated: true, completion: nil)
    }
}
