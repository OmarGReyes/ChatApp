//
//  Message.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import Foundation

struct Message: Identifiable, Equatable, Codable {
    var id: UUID = UUID()
    let message: String
    let received: Bool
    let timestamp: Date
    let userId: String
    
    internal init(id: UUID = UUID(),
                  message: String,
                  received: Bool,
                  timestamp: Date,
                  userId: String) {
        self.id = id
        self.message = message
        self.received = received
        self.timestamp = timestamp
        self.userId = userId
    }
}

extension Message {
    var hour: String {
        timestamp.formatted(.dateTime.hour().minute())
    }
}
