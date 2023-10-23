//
//  ChatUsersList.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct ChatUsersScreen: View {
    @ObservedObject var chatUserScreenViewModel: ChatUserScreenViewModel
    var body: some View {
        NavigationStack {
            List(chatUserScreenViewModel.sortedUsers()) { user in
                NavigationLink(destination: ChatScreen(chatUserScreenViewModel: chatUserScreenViewModel,
                                                       user: user)) {
                    UserListCell(name: user.name,
                                 lastMessage: chatUserScreenViewModel.getLastMessageByUserId(userId: user.userId).message,
                                 lastMessageHour: chatUserScreenViewModel.getLastMessageByUserId(userId: user.userId).hour)
                }
            }
        }
    }
}

struct ChatUsersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatUsersScreen(chatUserScreenViewModel: ChatUserScreenViewModel(messageManager: MessageManager()))
    }
}
