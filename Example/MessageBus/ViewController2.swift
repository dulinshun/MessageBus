//
//  ViewController2.swift
//  MessageBus_Example
//
//  Created by Tomorrow on 2024/3/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MessageBus

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "页面2"
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onSendMessage), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 200, width: UIScreen.main.bounds.width - 120, height: 40)
        button.backgroundColor = .red
        button.setTitle("随机修改颜色", for: .normal)
        view.addSubview(button)
    }
    
    @objc func onSendMessage() {
        MessageBus.shared.send(UIColor.random)
    }
    
}
