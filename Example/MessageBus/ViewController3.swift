//
//  ViewController3.swift
//  MessageBus_Example
//
//  Created by Tomorrow on 2024/3/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MessageBus

class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "页面3"
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onSendMessage), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 200, width: UIScreen.main.bounds.width - 120, height: 40)
        button.backgroundColor = .blue
        button.setTitle("随机修改颜色, 并让监听者修改自己的颜色", for: .normal)
        view.addSubview(button)
    }
    
    @objc func onSendMessage() {
        MessageBus.shared.send(UIColor.random) { [weak self] (value: UIColor) in
            self?.view.backgroundColor = value
        }
    }
}
