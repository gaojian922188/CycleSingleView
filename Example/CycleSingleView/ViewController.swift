//
//  ViewController.swift
//  CycleSingleView
//
//  Created by Tree on 02/06/2018.
//  Copyright (c) 2018 Tree. All rights reserved.
//

import UIKit
import CycleSingleView

class ViewController: UIViewController {

    var timer: DispatchSourceTimer?
    var num: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let cycleSingleView = CycleSingleView.cycleSingleView() {
            cycleSingleView.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 40)
            cycleSingleView.timer_repeat = 1
            self.view.addSubview(cycleSingleView)
            cycleSingleView.configCell(nibName: "DemoTableViewCell", className: nil,reuseIdentifier: "demoReuseIdentifier", clouse: { (cell,data) in
                if let demoCell = cell as? DemoTableViewCell, let data = data as? Dictionary<String, String> {
                    demoCell.lblName.text = data["name"]
                    demoCell.lblContent.text = data["content"]
                }
            })
            cycleSingleView.dataSource = [["name":"张三","content":"hahaha"],["name":"李四","content":"xixixi"],["name":"王五","content":"hahaha"]]
            
        }
        
    }

}

