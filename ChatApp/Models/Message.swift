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
    
    internal init(id: UUID = UUID(), message: String, received: Bool, timestamp: Date, userId: String) {
        self.id = id
        self.message = message
        self.received = received
        self.timestamp = timestamp
        self.userId = userId
    }
    
    init(CDMessage: CDMessage) {
        self.id = CDMessage.id ?? UUID()
        self.userId = CDMessage.userId ?? ""
        self.message = CDMessage.message ?? ""
        self.timestamp = CDMessage.timestamp ?? Date()
        self.received = CDMessage.received
    }
}

extension Message {
    var hour: String {
        timestamp.formatted(.dateTime.hour().minute())
    }
}
