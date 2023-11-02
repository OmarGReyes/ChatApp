//
//  ChatUsersList.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct ChatUsersScreen: View {
    @ObservedObject var chatUserScreenViewModel: ChatUserScreenViewModel
    @State var isPresentingUserListSheet = false
    var body: some View {
        Group {
            if chatUserScreenViewModel.messages.isEmpty {
                // All these should be outside because i need to put all this into VStack
                //TODO: - Working on it not finished yet
                EmptyChatView(isPresentingUserListSheet: $isPresentingUserListSheet)
            } else {
                NavigationStack {
                    List(chatUserScreenViewModel.sortedUsers()) { user in
                        NavigationLink(destination: ChatScreen(chatUserScreenViewModel: chatUserScreenViewModel,
                                                               user: user)) {
                            UserListCell(name: user.name,
                                         lastMessage: chatUserScreenViewModel.getLastMessageByUserId(userId: user.userId)?.message,
                                         lastMessageHour: chatUserScreenViewModel.getLastMessageByUserId(userId: user.userId)?.hour)
                        }
                    }.toolbar {
                        Button("New chat") {
                            isPresentingUserListSheet.toggle()
                        }
                    }
                }
            }
        }.sheet(isPresented: $isPresentingUserListSheet) {
            NavigationStack {
                List(chatUserScreenViewModel.sortedUsersAlphabetically()) { user in
                    NavigationLink(destination: ChatScreen(chatUserScreenViewModel: chatUserScreenViewModel,
                                                           user: user)) {
                        UserListCell(name: user.name,
                                     lastMessage: chatUserScreenViewModel.getLastMessageByUserId(userId: user.userId)?.message,
                                     lastMessageHour: chatUserScreenViewModel.getLastMessageByUserId(userId: user.userId)?.hour,
                                     isNewChatList: true)
                    }
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
