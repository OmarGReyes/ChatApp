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
}

extension User {
    static let sampleUsers = [
        User(name: "Usuario 1", imageURL: "https://example.com/image1.jpg"),
        User(name: "Usuario 2", imageURL: "https://example.com/image2.jpg"),
        User(name: "Usuario 3", imageURL: "https://example.com/image3.jpg"),
        User(name: "Usuario 4", imageURL: "https://example.com/image4.jpg"),
        User(name: "Usuario 5", imageURL: "https://example.com/image5.jpg"),
        User(name: "Usuario 6", imageURL: "https://example.com/image6.jpg"),
        User(name: "Usuario 7", imageURL: "https://example.com/image7.jpg"),
        User(name: "Usuario 8", imageURL: "https://example.com/image8.jpg"),
        User(name: "Usuario 9", imageURL: "https://example.com/image9.jpg"),
        User(name: "Usuario 10", imageURL: "https://example.com/image10.jpg")
    ]
    
}
