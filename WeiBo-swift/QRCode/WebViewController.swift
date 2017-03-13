//
//  WebViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/5.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let str = url! as String
        
        let path = URL(string: str)
        let webview = UIWebView(frame: self.view.bounds)
        webview.delegate = self
        webview.loadRequest(URLRequest(url: path!))
        self.view.addSubview(webview)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
}
