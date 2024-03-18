//
//  MessageBus.swift
//  Pods
//
//  Created by dulinshun on 2024/3/15.
//

import Foundation

public class MessageSubscriber {
    fileprivate var observers: [NSObjectProtocol] = []
    public init() {}
}

public class MessageBus {
    public static let shared = MessageBus()

    // 移除
    public func remove(_ subscriber: MessageSubscriber) {
        for observer in subscriber.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

// 正常的消息
public extension MessageBus {
    func send<T>(_ message: T) {
        let name = NSNotification.Name(String(describing: T.self))
        let notification = Notification(name: name, object: nil, userInfo: ["message": message])
        NotificationCenter.default.post(notification)
    }

    func addListener<T>(_ handler: @escaping (_ message: T) -> Void, subscriber: MessageSubscriber) {
        let name = NSNotification.Name(String(describing: T.self))
        subscriber.observers.append(NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { notification in
            if let message = notification.userInfo?["message"] as? T {
                handler(message)
            }
        })
    }
}

// 带ID的消息，
public extension MessageBus {
    func send<T>(_ identifier: String, message: T) {
        send(IdentifierMessage(identifier: identifier, message: message))
    }

    func addListener<T>(_ identifier: String, handler: @escaping (_ message: T) -> Void, subscriber: MessageSubscriber) {
        addListener({ (message: IdentifierMessage<T>) in
            if message.identifier == identifier {
                handler(message.message)
            }
        }, subscriber: subscriber)
    }
}

// 带回调的消息
public extension MessageBus {
    func send<Input, Output>(_ message: Input, completion: @escaping ((Output) -> Void)) {
        send(CallbackMessage(data: message, completion: completion))
    }

    func addListener<Input, Output>(_ handler: @escaping (_ data: Input, _ completion: (Output) -> Void) -> Void, subscriber: MessageSubscriber) {
        addListener({ (message: CallbackMessage<Input, Output>) in
            handler(message.data, message.completion)
        }, subscriber: subscriber)
    }
}
