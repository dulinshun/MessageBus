//
//  ViewController.swift
//  MessageBus
//
//  Created by tomorrow on 03/15/2024.
//  Copyright (c) 2024 tomorrow. All rights reserved.
//

import UIKit
import MessageBus

class ViewController: UIViewController {
    private let subscriber = MessageSubscriber()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInit()
        doObserver()
    }

    func doInit() {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(toPage2), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 200, width: UIScreen.main.bounds.width - 120, height: 40)
        button.backgroundColor = .orange
        button.setTitle("去页面2", for: .normal)
        view.addSubview(button)

        let button2 = UIButton(type: .custom)
        button2.addTarget(self, action: #selector(toPage3), for: .touchUpInside)
        button2.frame = CGRect(x: 60, y: 250, width: UIScreen.main.bounds.width - 120, height: 40)
        button2.backgroundColor = .orange
        button2.setTitle("去页面3", for: .normal)
        view.addSubview(button2)
    }

    func doObserver() {
        MessageBus.shared.addListener({ [weak self] (message: UIColor) in
            guard let `self` = self else { return }
            self.view.backgroundColor = message
        }, subscriber: subscriber)
        
        MessageBus.shared.addListener({ [weak self] (data: UIColor, completion) in
            guard let `self` = self else { return }
            self.view.backgroundColor = data
            completion(UIColor.random)
        }, subscriber: subscriber)
    }

    @objc func toPage2() {
        navigationController?.pushViewController(ViewController2(), animated: true)
    }

    @objc func toPage3() {
        navigationController?.pushViewController(ViewController3(), animated: true)
    }
    
    deinit {
        MessageBus.shared.remove(subscriber)
    }
}
