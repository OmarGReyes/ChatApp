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
}

extension Message {
    var hour: String {
        timestamp.formatted(.dateTime.hour().minute())
    }
}


extension Message {
    static var mockMessages = [
        Message(message: "Hello there!", received: true, timestamp: Date(), userId: "12"),
        Message(message: "Hi, how are you?", received: false, timestamp: Date(), userId: "12"),
        Message(message: "I'm doing well, thanks!", received: true, timestamp: Date(), userId: "12"),
        Message(message: "What have you been up to?", received: false, timestamp: Date(), userId: "12"),
        Message(message: "Just working on some projects.", received: true, timestamp: Date(), userId: "12"),
        Message(message: "That sounds interesting. Tell me more.", received: false, timestamp: Date(), userId: "12"),
        Message(message: "I'm working on a new app and reading a good book.", received: true, timestamp: Date(), userId: "12"),
        Message(message: "What book are you reading?", received: false, timestamp: Date(), userId: "12"),
        Message(message: "I'm reading 'The Great Gatsby' by F. Scott Fitzgerald.", received: true, timestamp: Date(), userId: "12"),
        Message( message: "That's a classic! How do you like it?", received: false, timestamp: Date(), userId: "12"),
    ]
}
