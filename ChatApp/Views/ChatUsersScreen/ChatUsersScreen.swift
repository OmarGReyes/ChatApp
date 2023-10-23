//
//  ChatUsersList.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct ChatUsersScreen: View {
    // Esta screen debería traer los usuarios y el último mensaje con ese usuario pero traído de CoreData todo esto
    @ObservedObject var messageManager: MessageManager
    var body: some View {
        NavigationStack {
            List(messageManager.sortedUsers()) { user in
                NavigationLink(destination: ChatScreen(messageManager: messageManager,
                                                       user: user)) {
                    UserListCell(name: user.name,
                                 lastMessage: messageManager.getLastMessageByUserId(userId: user.userId).message,
                                 lastMessageHour: messageManager.getLastMessageByUserId(userId: user.userId).hour)
                }
            }
        }
    }
}

struct ChatUsersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatUsersScreen(messageManager: MessageManager())
    }
}
