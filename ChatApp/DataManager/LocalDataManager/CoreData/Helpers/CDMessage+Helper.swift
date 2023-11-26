//
//  CDMessage+Helper.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/11/23.
//

import Foundation

extension CDMessage {
    func toDomain() -> Message {
        Message(message: message ?? "",
                received: received,
                timestamp: timestamp ?? Date(),
                userId: userId ?? "")
    }
}
