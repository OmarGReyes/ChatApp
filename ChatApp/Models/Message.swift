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


extension Message {
    static var mockMessages = [
        Message(message: "Hello there!", received: true, timestamp: Date(), userId: "1"),
        Message(message: "Hi, how are you?", received: false, timestamp: Date(), userId: "2"),
        Message(message: "I'm doing well, thanks!", received: true, timestamp: Date(), userId: "3"),
        Message(message: "What have you been up to?", received: false, timestamp: Date(), userId: "4"),
        Message(message: "Just working on some projects.", received: true, timestamp: Date(), userId: "5"),
        Message(message: "That sounds interesting. Tell me more.", received: false, timestamp: Date(), userId: "6"),
        Message(message: "I'm working on a new app and reading a good book.", received: true, timestamp: Date(), userId: "7"),
        Message(message: "What book are you reading?", received: false, timestamp: Date(), userId: "8"),
        Message(message: "I'm reading 'The Great Gatsby' by F. Scott Fitzgerald.", received: true, timestamp: Date(), userId: "9"),
        Message( message: "That's a classic! How do you like it?", received: false, timestamp: Date(), userId: "10"),
    ]
    
    static var emptyMessages = [Message]()
}
