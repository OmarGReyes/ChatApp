//
//  ChatUsersList.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct ChatUsersScreen: View {
    // Esta screen debería traer los usuarios y el último mensaje con ese usuario pero traído de CoreData todo esto
    let users = User.sampleUsers
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(destination: ChatScreen()) {
                    UserListCell(name: user.name,
                                 lastMessage: Message.mockMessages.last?.message ?? "")
                }
            }
        }
    }
}

struct ChatUsersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatUsersScreen()
    }
}
