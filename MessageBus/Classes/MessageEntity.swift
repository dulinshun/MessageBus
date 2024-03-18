//
//  MessageEntitys.swift
//  MessageBus
//
//  Created by Tomorrow on 2024/3/15.
//

import Foundation

// 回调消息，传入一个数据，返回一个数据
public struct CallbackMessage<Input, Output> {
    let data: Input
    let completion: (Output) -> ()
}

// 通用的消息
public struct IdentifierMessage<T> {
    let identifier: String
    let message: T
}
