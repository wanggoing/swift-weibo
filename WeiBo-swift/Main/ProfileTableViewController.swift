//
//  ProfileTableViewController.swift
//  WeiBo-swift
//
//  Created by wangzhaohui on 2016/12/3.
//  Copyright © 2016年 com.zhaohui.wang. All rights reserved.
//

import UIKit

class ProfileTableViewController: XLFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.initializeForm()
    }
    
    private func initializeForm() {
        
        let dateTime = "dateTime"
        let date = "date"
        let time = "time"
        
        var form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Dates") as XLFormDescriptor
        
        section = XLFormSectionDescriptor.formSection(withTitle: "Inline Dates") as XLFormSectionDescriptor
        form.addFormSection(section)
        
        // Date
        row = XLFormRowDescriptor(tag: date, rowType: XLFormRowDescriptorTypeDateInline, title:"Date")
        row.value = NSDate()
        section.addFormRow(row)
        
        // Time
        row = XLFormRowDescriptor(tag: time, rowType: XLFormRowDescriptorTypeTimeInline, title: "Time")
        row.value = NSDate()
        section.addFormRow(row)
        
        // DateTime
        row = XLFormRowDescriptor(tag: dateTime, rowType: XLFormRowDescriptorTypeDateTimeInline, title: "Date Time")
        row.value = NSDate()
        section.addFormRow(row)
        
        self.form = form;
    }
}
