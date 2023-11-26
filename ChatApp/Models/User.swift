//
//  User.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let imageURL: String
    let userId: String
    var lastInteraction: Date?
    var lastMessage: String?
    
    internal init(
        id: UUID = UUID(),
        name: String,
        imageURL: String,
        userId: String,
        lastInteraction: Date? = nil,
        lastMessage: String? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.userId = userId
        self.lastInteraction = lastInteraction
        self.lastMessage = lastMessage
    }
}

extension User {
    var lastInteractionHour: String {
        lastInteraction?.formatted(.dateTime.hour().minute()) ?? ""
    }
}

extension User {
    static let sampleUsers = [
        User(name: "Andres Zemoga", imageURL: "https://example.com/image1.jpg", userId: "1", lastInteraction: nil),
        User(name: "Juan", imageURL: "https://example.com/image2.jpg", userId: "2", lastInteraction: nil),
        User(name: "Ernesto", imageURL: "https://example.com/image3.jpg", userId: "3", lastInteraction: nil),
        User(name: "Julio", imageURL: "https://example.com/image4.jpg", userId: "4", lastInteraction: nil),
        User(name: "Jose", imageURL: "https://example.com/image5.jpg", userId: "5", lastInteraction: nil),
        User(name: "Jean", imageURL: "https://example.com/image6.jpg", userId: "6", lastInteraction: nil),
        User(name: "Monica", imageURL: "https://example.com/image7.jpg", userId: "7", lastInteraction: nil),
        User(name: "Marvin", imageURL: "https://example.com/image8.jpg", userId: "8", lastInteraction: nil),
        User(name: "Carlos", imageURL: "https://example.com/image9.jpg", userId: "9", lastInteraction: nil),
        User(name: "Carlos Primo", imageURL: "https://example.com/image10.jpg", userId: "10", lastInteraction: nil)
    ]
}
