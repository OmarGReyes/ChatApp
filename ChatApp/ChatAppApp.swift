//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

@main
struct ChatAppApp: App {
    @StateObject var messageManager = MessageManager()
    var body: some Scene {
        WindowGroup {
            ChatUsersScreen(chatUserScreenViewModel: ChatUserScreenViewModel(messageManager: messageManager))
        }
    }
}
